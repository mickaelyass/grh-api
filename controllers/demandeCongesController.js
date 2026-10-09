// controllers/demandeCongesController.js
/**
 * Demandes de congés — refonte :
 *  - écriture/lecture dans UNE transaction (demande + pièces + audit + notifications) ;
 *  - contrôle du solde À LA CRÉATION (crédit de rattrapage idempotent inclus) ;
 *  - débit UNIQUEMENT à l'acceptation totale (chef + directrice), FIFO par année ;
 *  - périmètre des données selon le rôle (employé : le sien ; chef : son service).
 */
const { Op } = require('sequelize');
const sequelize = require('../db');
const { getIo } = require('../utils/socket');
const { Resend } = require('resend');
const {
  Dossier, InfoIdent, InfoPro, Utilisateur,
  DemandeConges, PieceJointe, Notifications, AuditConge,
} = require('../models/association');
const {
  SoldeInsuffisantError, crediterJusqua, crediterTousLesAgents, soldeResume, debiterSolde,
} = require('../services/soldeService');

// Email en best-effort : sans RESEND_API_KEY dans le .env, aucun envoi.
const resend = process.env.RESEND_API_KEY ? new Resend(process.env.RESEND_API_KEY) : null;

const envoyerEmail = async ({ to, subject, text }) => {
  if (!resend || !to) return;
  try {
    await resend.emails.send({ from: process.env.RESEND_FROM || 'onboarding@resend.dev', to, subject, text });
  } catch (err) {
    console.warn('[conges] Email non envoyé :', err.message);
  }
};

const notifier = async (id_user, message, transaction) => {
  if (!id_user) return null;
  const notif = await Notifications.create({ id_user, message }, { transaction });
  try { getIo().emit('receiveNotification', notif); } catch (e) { /* socket non initialisé */ }
  return notif;
};

/** Service du chef de service (via son dossier lié par matricule). */
const serviceDeChef = async (user, transaction) => {
  const dossier = await Dossier.findOne({
    where: { matricule: user.matricule },
    include: [{ model: InfoPro, attributes: ['poste_actuel_service'] }],
    transaction,
  });
  return (dossier && dossier.InfoPro && dossier.InfoPro.poste_actuel_service) || null;
};

/** Matricules des agents d'un service (1 requête). */
const matriculesDuService = async (service, transaction) => {
  const dossiers = await Dossier.findAll({
    attributes: ['matricule'],
    include: [{ model: InfoPro, attributes: [], required: true, where: { poste_actuel_service: service } }],
    transaction,
  });
  return dossiers.map((d) => d.matricule);
};

const chefsDuService = async (service, transaction) => {
  const mats = await matriculesDuService(service, transaction);
  if (!mats.length) return [];
  return Utilisateur.findAll({
    where: { role: 'chef_service', is_active: true, matricule: { [Op.in]: mats } },
    transaction,
  });
};

/** Portée des données selon le rôle : {} = tout voir. */
const porteeWhere = async (req, transaction) => {
  const role = req.user.role;
  if (role === 'admin' || role === 'directrice') return {};
  if (role === 'chef_service') {
    const service = await serviceDeChef(req.user, transaction);
    const mats = service ? await matriculesDuService(service, transaction) : [];
    return { matricule: { [Op.in]: mats } };
  }
  return { matricule: req.user.matricule }; // employé → son dossier uniquement
};

const inclureDemande = [
  { model: PieceJointe, as: 'piecesJointes' },
  {
    model: Dossier, attributes: ['matricule'],
    include: [
      { model: InfoIdent, attributes: ['nom', 'prenom', 'email'] },
      { model: InfoPro, attributes: ['poste_actuel_service'] },
    ],
  },
];

const accesDemandeAutorise = async (req, demande, transaction) => {
  const role = req.user.role;
  if (role === 'admin' || role === 'directrice') return true;
  if (role === 'employe') return demande.matricule === req.user.matricule;
  if (role === 'chef_service') {
    const service = await serviceDeChef(req.user, transaction);
    const mats = service ? await matriculesDuService(service, transaction) : [];
    return mats.includes(demande.matricule);
  }
  return false;
};

/**
 * POST /api/demande-conges/create
 * Une seule transaction : crédit de rattrapage idempotent → contrôle du solde →
 * demande → pièces jointes 1:N → audit → notifications.
 */
exports.createDemandeConge = async (req, res) => {
  const {
    matricule, type_conge, type_de_conge, date_debut, date_de_fin,
    annee_jouissance, nombre_de_jour, raison,
  } = req.body;
  const type = type_de_conge || type_conge;
  const jours = parseInt(nombre_de_jour, 10);
  const annee = parseInt(annee_jouissance, 10);

  if (!matricule || !type || !date_debut || !date_de_fin || !annee_jouissance || !jours) {
    return res.status(400).json({
      error: 'Champs requis : matricule, type_de_conge, date_debut, date_de_fin, annee_jouissance, nombre_de_jour.',
    });
  }
  if (!Number.isInteger(jours) || jours < 1) {
    return res.status(400).json({ error: 'nombre_de_jour doit être un entier supérieur ou égal à 1.' });
  }
  if (new Date(date_de_fin) < new Date(date_debut)) {
    return res.status(400).json({ error: 'date_de_fin est antérieure à date_debut.' });
  }
  if (!Number.isInteger(annee) || annee < 2000 || annee > 2100) {
    return res.status(400).json({ error: 'annee_jouissance invalide.' });
  }

  // Périmètre : un employé ou un chef ne crée QUE ses propres demandes.
  const role = req.user.role;
  if (['employe', 'chef_service'].includes(role) && matricule !== req.user.matricule) {
    return res.status(403).json({ error: 'Vous ne pouvez créer une demande que pour votre propre matricule.' });
  }

  const t = await sequelize.transaction();
  try {
    const dossier = await Dossier.findOne({
      where: { matricule },
      include: [{ model: InfoPro }, { model: InfoIdent, attributes: ['email', 'nom', 'prenom'] }],
      transaction: t,
      // Verrou UNIQUEMENT sur dossier : FOR UPDATE global échoue sur les
      // LEFT JOIN (« nullable side of an outer join »).
      lock: { level: t.LOCK.UPDATE, of: Dossier },
    });
    if (!dossier) {
      await t.rollback();
      return res.status(404).json({ error: 'Dossier introuvable pour ce matricule.' });
    }
    if (!dossier.InfoPro) {
      await t.rollback();
      return res.status(400).json({ error: 'Informations professionnelles introuvables.' });
    }

    // Crédit de rattrapage idempotent : solde à jour avant contrôle.
    await crediterJusqua(matricule, new Date(), { transaction: t, auteur: req.user.matricule });

    const resume = await soldeResume(matricule, { transaction: t });
    if (resume.total < jours) {
      await t.rollback();
      return res.status(400).json({
        error: `Solde insuffisant : ${resume.total} jour(s) disponible(s) pour ${jours} jour(s) demande(s).`,
        solde_disponible: resume.total,
      });
    }

    const demande = await DemandeConges.create({
      matricule,
      type_de_conge: type,
      date_debut,
      date_de_fin,
      annee_jouissance: annee,
      nombre_de_jour: jours,
      raison,
    }, { transaction: t });

    // Pièces jointes 1:N : au maximum 1 certificat + 1 attestation.
    const pieces = [];
    if (req.files) {
      for (const [typePiece, fichiers] of Object.entries(req.files)) {
        if (!['certificat', 'attestation'].includes(typePiece) || !fichiers[0]) continue;
        pieces.push(await PieceJointe.create({
          id_cong: demande.id_cong,
          type: typePiece,
          url: `/doc/${fichiers[0].filename}`,
        }, { transaction: t }));
      }
    }

    await AuditConge.create({
      id_cong: demande.id_cong,
      matricule,
      action: 'CREATION',
      nouveau_statut: 'En attente',
      details: `${jours} jour(s) — ${type} — solde disponible avant demande : ${resume.total}`,
      auteur_matricule: req.user.matricule,
    }, { transaction: t });

    // Notifications : l'agent + les chefs de son service.
    const userAgent = await Utilisateur.findOne({ where: { matricule }, transaction: t });
    await notifier(userAgent && userAgent.id_user,
      `Votre demande de congé n°${demande.id_cong} (${jours} j) a été enregistrée.`, t);
    const service = dossier.InfoPro.poste_actuel_service;
    const chefs = service ? await chefsDuService(service, t) : [];
    for (const chef of chefs) {
      await notifier(chef.id_user,
        `Nouvelle demande de congé de l'agent ${matricule} : ${jours} jour(s) (${type}).`, t);
    }

    await t.commit();

    // Emails hors transaction (best effort).
    for (const chef of chefs) {
      await envoyerEmail({
        to: chef.email,
        subject: 'Nouvelle demande de congé',
        text: `Une nouvelle demande de congé a été créée.\nMatricule: ${matricule}, Date de début: ${date_debut}, Année de jouissance: ${annee}.`,
      });
    }

    const reponse = await DemandeConges.findByPk(demande.id_cong, {
      include: [{ model: PieceJointe, as: 'piecesJointes' }],
    });
    return res.status(201).json(reponse);
  } catch (error) {
    await t.rollback();
    if (error instanceof SoldeInsuffisantError) {
      return res.status(400).json({ error: error.message, solde_disponible: error.disponible });
    }
    console.error('[createDemandeConge]', error);
    return res.status(500).json({ error: 'Une erreur est survenue lors de la création de la demande de congés.' });
  }
};

/** GET /api/demande-conges — liste selon la portée du rôle (pagination si ?page=). */
exports.listesDemandeConge = async (req, res) => {
  try {
    const where = await porteeWhere(req);
    const include = [
      { model: PieceJointe, as: 'piecesJointes' },
      {
        model: Dossier, attributes: ['matricule'],
        include: [{ model: InfoIdent, attributes: ['nom', 'prenom'] }],
      },
    ];
    const page = parseInt(req.query.page, 10);
    if (page > 0) {
      const limit = Math.min(parseInt(req.query.limit, 10) || 50, 200);
      const { count, rows } = await DemandeConges.findAndCountAll({
        where, include, order: [['date_debut', 'DESC']], limit, offset: (page - 1) * limit,
      });
      return res.status(200).json({ data: rows, total: count, page, pages: Math.ceil(count / limit) });
    }
    const demandes = await DemandeConges.findAll({ where, include, order: [['date_debut', 'DESC']] });
    res.status(200).json(demandes);
  } catch (error) {
    console.error('[listesDemandeConge]', error);
    res.status(500).json({ error: 'Une erreur est survenue lors de la récupération des demandes de congés.' });
  }
};

/**
 * GET /api/demandes/service/:service — demandes en attente de décision du chef.
 * Requête unique : la jointure remplace l'ancien traitement mémoire N×M.
 */
exports.listesCongeParServices = async (req, res) => {
  const { service } = req.params;
  try {
    if (req.user.role === 'employe') {
      return res.status(403).json({ error: 'Accès réservé aux chefs de service et à la direction.' });
    }
    if (req.user.role === 'chef_service') {
      const monService = await serviceDeChef(req.user);
      if (!monService || monService !== service) {
        return res.status(403).json({ error: 'Vous ne pouvez consulter que les demandes de votre service.' });
      }
    }
    const demandes = await DemandeConges.findAll({
      where: { decision_chef_service: 'En attente', status: 'En attente' },
      include: [
        { model: PieceJointe, as: 'piecesJointes' },
        {
          model: Dossier, required: true, attributes: ['matricule'],
          include: [
            {
              model: InfoPro, attributes: ['poste_actuel_service'], required: true,
              where: { poste_actuel_service: service },
            },
            { model: InfoIdent, attributes: ['nom', 'prenom'] },
          ],
        },
      ],
      order: [['date_debut', 'DESC']],
    });
    res.status(200).json(demandes);
  } catch (error) {
    console.error('[listesCongeParServices]', error);
    res.status(500).json({ message: 'Erreur lors de la récupération des demandes de congés par service' });
  }
};

/** GET /api/demande-conges/:id — par identifiant, avec repli sur le matricule. */
exports.findCongeId = async (req, res) => {
  const { id_cong } = req.params;
  try {
    let demande = null;
    if (/^\d+$/.test(id_cong)) {
      demande = await DemandeConges.findByPk(id_cong, { include: inclureDemande });
    }
    if (!demande) {
      // Repli : la valeur peut être un matricule (anciennes URLs).
      demande = await DemandeConges.findOne({
        where: { matricule: id_cong },
        include: inclureDemande,
        order: [['id_cong', 'DESC']],
      });
    }
    if (!demande) return res.status(404).json({ error: 'Demande non trouvée' });
    if (!(await accesDemandeAutorise(req, demande))) {
      return res.status(403).json({ error: 'Accès refusé à cette demande.' });
    }
    res.status(200).json(demande);
  } catch (error) {
    console.error('[findCongeId]', error);
    res.status(500).json({ error: 'Une erreur est survenue lors de la récupération de la demande de congés.' });
  }
};

/** GET /api/demande-conges/matricule/:matricule — toutes les demandes d'un agent. */
exports.findCongeMatricule = async (req, res) => {
  const { matricule } = req.params;
  try {
    if (req.user.role === 'employe' && matricule !== req.user.matricule) {
      return res.status(403).json({ error: 'Accès refusé.' });
    }
    if (req.user.role === 'chef_service') {
      const service = await serviceDeChef(req.user);
      const mats = service ? await matriculesDuService(service) : [];
      if (!mats.includes(matricule)) return res.status(403).json({ error: 'Accès refusé.' });
    }
    const demandes = await DemandeConges.findAll({
      where: { matricule },
      include: inclureDemande,
      order: [['id_cong', 'DESC']],
    });
    if (!demandes.length) return res.status(404).json({ error: 'Aucune demande trouvée pour ce matricule' });
    res.status(200).json(demandes);
  } catch (error) {
    console.error('[findCongeMatricule]', error);
    res.status(500).json({ error: 'Une erreur est survenue lors de la récupération de la demande de congés.' });
  }
};

/**
 * PUT /api/demande-conges/:id/decision-chef-service
 * Le chef ne décide QUE des demandes de son service. Rejet → statut final.
 */
exports.decisionChef = async (req, res) => {
  const { id } = req.params;
  const { decision_chef_service } = req.body;
  const valides = ['Autorisée', 'Rejetée', 'En attente'];
  if (!valides.includes(decision_chef_service)) {
    return res.status(400).json({ error: 'Valeur de décision non valide (Autorisée, Rejetée, En attente).' });
  }

  const t = await sequelize.transaction();
  try {
    const demande = await DemandeConges.findByPk(id, {
      include: [{
        model: Dossier, attributes: ['matricule'],
        include: [
          { model: InfoPro, attributes: ['poste_actuel_service'] },
          { model: InfoIdent, attributes: ['email', 'nom', 'prenom'] },
        ],
      }],
      transaction: t,
      // Verrou sur demande_conges uniquement (les LEFT JOIN ne peuvent pas
      // être verrouillés : « nullable side of an outer join »).
      lock: { level: t.LOCK.UPDATE, of: DemandeConges },
    });
    if (!demande) {
      await t.rollback();
      return res.status(404).json({ error: 'Demande non trouvée' });
    }
    if (demande.status !== 'En attente') {
      await t.rollback();
      return res.status(409).json({ error: `Demande déjà tranchée (statut : ${demande.status}).` });
    }

    // Périmètre : le chef ne décide que de SON service.
    if (req.user.role === 'chef_service') {
      const serviceDemande = demande.Dossier && demande.Dossier.InfoPro
        && demande.Dossier.InfoPro.poste_actuel_service;
      const monService = await serviceDeChef(req.user, t);
      if (!monService || monService !== serviceDemande) {
        await t.rollback();
        return res.status(403).json({ error: 'Cette demande relève d un autre service.' });
      }
    }

    const ancien = demande.decision_chef_service;
    demande.decision_chef_service = decision_chef_service;
    if (decision_chef_service === 'Rejetée') demande.status = 'Rejetée';
    await demande.save({ transaction: t });

    await AuditConge.create({
      id_cong: demande.id_cong,
      matricule: demande.matricule,
      action: 'DECISION_CHEF',
      ancien_statut: ancien,
      nouveau_statut: decision_chef_service,
      details: `Décision du chef de service : ${decision_chef_service}`,
      auteur_matricule: req.user.matricule,
    }, { transaction: t });

    const userAgent = await Utilisateur.findOne({ where: { matricule: demande.matricule }, transaction: t });
    await notifier(userAgent && userAgent.id_user,
      `Votre demande de congé n°${demande.id_cong} : décision du chef de service → ${decision_chef_service}.`, t);

    await t.commit();

    const agentEmail = demande.Dossier && demande.Dossier.InfoIdent && demande.Dossier.InfoIdent.email;
    await envoyerEmail({
      to: agentEmail,
      subject: 'Décision du chef de service sur votre demande de congé',
      text: `Votre demande de congé n°${demande.id_cong} est « ${decision_chef_service} » (décision du chef de service).`,
    });

    const reponse = await DemandeConges.findByPk(demande.id_cong, { include: inclureDemande });
    res.status(200).json(reponse);
  } catch (error) {
    await t.rollback();
    console.error('[decisionChef]', error);
    res.status(500).json({ error: 'Une erreur est survenue lors de la mise à jour de la décision du chef de service.' });
  }
};

/**
 * PUT /api/demande-conges/:id/decision-directrice
 * Exige l'accord préalable du chef. Acceptation TOTALE → débit FIFO du solde
 * (années les plus anciennes d'abord) dans la même transaction + audit.
 */
exports.decisionDirectrice = async (req, res) => {
  const { id } = req.params;
  const { decision_directrice } = req.body;
  const valides = ['Autorisée', 'Rejetée', 'En attente'];
  if (!valides.includes(decision_directrice)) {
    return res.status(400).json({ error: 'Valeur de décision non valide (Autorisée, Rejetée, En attente).' });
  }

  const t = await sequelize.transaction();
  try {
    const demande = await DemandeConges.findByPk(id, {
      include: [{
        model: Dossier, attributes: ['matricule'],
        include: [{ model: InfoIdent, attributes: ['email', 'nom', 'prenom'] }],
      }],
      transaction: t,
      lock: { level: t.LOCK.UPDATE, of: DemandeConges },
    });
    if (!demande) {
      await t.rollback();
      return res.status(404).json({ error: 'Demande non trouvée' });
    }
    if (demande.status !== 'En attente') {
      await t.rollback();
      return res.status(409).json({ error: `Demande déjà tranchée (statut : ${demande.status}).` });
    }
    if (demande.decision_chef_service !== 'Autorisée') {
      await t.rollback();
      return res.status(409).json({ error: 'Le chef de service n a pas encore autorisé cette demande.' });
    }

    const ancien = demande.status;
    demande.decision_directrice = decision_directrice;
    let debit = null;
    if (decision_directrice === 'Rejetée') {
      demande.status = 'Rejetée'; // aucun débit → rien à recréditer
    } else if (decision_directrice === 'Autorisée') {
      demande.status = 'Autorisée';
      // Débit UNIQUEMENT ici : solde verrouillé, FIFO par année, transactionnel.
      debit = await debiterSolde(demande.matricule, demande.nombre_de_jour, {
        transaction: t, auteur: req.user.matricule, id_cong: demande.id_cong,
      });
    }
    await demande.save({ transaction: t });

    await AuditConge.create({
      id_cong: demande.id_cong,
      matricule: demande.matricule,
      action: 'DECISION_DIRECTRICE',
      ancien_statut: ancien,
      nouveau_statut: demande.status,
      details: debit
        ? `Acceptation totale — débit de ${demande.nombre_de_jour} jour(s) [${debit.ventilation}]`
        : `Décision de la direction : ${decision_directrice}`,
      auteur_matricule: req.user.matricule,
    }, { transaction: t });

    const userAgent = await Utilisateur.findOne({ where: { matricule: demande.matricule }, transaction: t });
    await notifier(userAgent && userAgent.id_user,
      `Votre demande de congé n°${demande.id_cong} : décision de la direction → ${demande.status}.`, t);

    await t.commit();

    const agentEmail = demande.Dossier && demande.Dossier.InfoIdent && demande.Dossier.InfoIdent.email;
    await envoyerEmail({
      to: agentEmail,
      subject: 'Décision finale sur votre demande de congé',
      text: `Votre demande de congé n°${demande.id_cong} est « ${demande.status} » (décision de la direction).`,
    });

    const reponse = await DemandeConges.findByPk(demande.id_cong, { include: inclureDemande });
    res.status(200).json(reponse);
  } catch (error) {
    await t.rollback();
    if (error instanceof SoldeInsuffisantError) {
      return res.status(409).json({
        error: `Solde devenu insuffisant depuis la création : ${error.message}`,
        solde_disponible: error.disponible,
      });
    }
    console.error('[decisionDirectrice]', error);
    res.status(500).json({ error: 'Une erreur est survenue lors de la mise à jour de la décision de la directrice.' });
  }
};

/** GET /api/demande-conges/status/:status — filtré par décision du chef + portée du rôle. */
exports.listescongeParStatus = async (req, res) => {
  const { status } = req.params;
  try {
    const portee = await porteeWhere(req);
    const demandes = await DemandeConges.findAll({
      where: { ...portee, decision_chef_service: status },
      include: [{ model: PieceJointe, as: 'piecesJointes' }],
      order: [['date_debut', 'DESC']],
    });
    res.status(200).json(demandes);
  } catch (error) {
    console.error('[listescongeParStatus]', error);
    res.status(500).json({ error: 'Une erreur est survenue lors de la récupération des demandes de congés.' });
  }
};

/**
 * GET /api/demande-conges-autoriser — demandes autorisées avec nom/prénom.
 * Une SEULE requête SQL (jointure) remplace l'ancien croisement en mémoire.
 */
exports.listescongeParStatusAutoriser = async (req, res) => {
  try {
    const portee = await porteeWhere(req);
    const demandes = await DemandeConges.findAll({
      where: { ...portee, status: 'Autorisée' },
      attributes: [
        'id_cong', 'matricule', 'type_de_conge', 'date_debut', 'date_de_fin',
        'raison', 'status', 'annee_jouissance', 'nombre_de_jour',
      ],
      include: [{
        model: Dossier, attributes: [], required: false,
        include: [{ model: InfoIdent, attributes: ['nom', 'prenom'] }],
      }],
      order: [['date_debut', 'DESC']],
    });
    const result = demandes.map((d) => {
      const info = d.Dossier && d.Dossier.InfoIdent;
      return {
        ...d.dataValues,
        nom: info ? info.nom : null,
        prenom: info ? info.prenom : null,
        Dossier: undefined,
      };
    });
    res.status(200).json(result);
  } catch (error) {
    console.error('[listescongeParStatusAutoriser]', error);
    res.status(500).json({ error: 'Erreur lors de la récupération des demandes de congés.' });
  }
};

/**
 * DELETE /api/demande-conges/:id — archivage (soft-delete) + audit.
 * L'employé ne peut supprimer que ses demandes encore « En attente ».
 */
exports.deleteConge = async (req, res) => {
  const { id } = req.params;
  const t = await sequelize.transaction();
  try {
    const demande = await DemandeConges.findByPk(id, { transaction: t, lock: t.LOCK.UPDATE });
    if (!demande) {
      await t.rollback();
      return res.status(404).json({ error: 'Demande non trouvée' });
    }
    if (!(await accesDemandeAutorise(req, demande, t))) {
      await t.rollback();
      return res.status(403).json({ error: 'Accès refusé à cette demande.' });
    }
    if (req.user.role === 'employe' && demande.status !== 'En attente') {
      await t.rollback();
      return res.status(409).json({ error: 'Seule une demande encore « En attente » peut être annulée.' });
    }

    const ancien = demande.status;
    await demande.destroy({ transaction: t }); // archivage : la ligne est conservée
    await AuditConge.create({
      id_cong: demande.id_cong,
      matricule: demande.matricule,
      action: 'SUPPRESSION',
      ancien_statut: ancien,
      nouveau_statut: 'Archivée',
      details: `Demande archivée par ${req.user.matricule}`,
      auteur_matricule: req.user.matricule,
    }, { transaction: t });

    const userAgent = await Utilisateur.findOne({ where: { matricule: demande.matricule }, transaction: t });
    await notifier(userAgent && userAgent.id_user,
      `Votre demande de congé n°${demande.id_cong} a été archinée/annulée par ${req.user.matricule}.`, t);

    await t.commit();
    try { getIo().emit('receiveNotification', { message: `Demande n°${demande.id_cong} archinée.` }); } catch (e) { /* socket non initialisé */ }
    res.status(200).json({ message: 'Demande supprimée avec succès' });
  } catch (error) {
    await t.rollback();
    console.error('[deleteConge]', error);
    res.status(500).json({ error: 'Une erreur est survenue lors de la suppression de la demande de congés.' });
  }
};

/**
 * GET /api/demande-conges/solde[/:matricule] — solde détaillé par année.
 * Sans matricule : son propre solde (employé). Avec : selon la portée du rôle.
 */
exports.getSoldeConge = async (req, res) => {
  try {
    const matricule = req.params.matricule || req.user.matricule;
    const role = req.user.role;
    if (role === 'employe' && matricule !== req.user.matricule) {
      return res.status(403).json({ error: 'Accès refusé : vous ne pouvez consulter que votre propre solde.' });
    }
    if (role === 'chef_service') {
      const service = await serviceDeChef(req.user);
      const mats = service ? await matriculesDuService(service) : [];
      if (!mats.includes(matricule)) {
        return res.status(403).json({ error: 'Accès refusé : agent hors de votre service.' });
      }
    }
    const resume = await soldeResume(matricule);
    res.status(200).json({
      matricule,
      total_disponible: resume.total,
      annees: resume.detail,
    });
  } catch (error) {
    console.error('[getSoldeConge]', error);
    res.status(500).json({ error: 'Une erreur est survenue lors de la lecture du solde de congés.' });
  }
};

/**
 * POST /api/demande-conges/solde/forcer-credit[/:matricule] — admin uniquement.
 * Crédit de rattrapage idempotent (un mois déjà crédité ne l'est jamais 2 fois).
 */
exports.forcerCredit = async (req, res) => {
  try {
    const matricule = req.params.matricule || (req.body && req.body.matricule);
    if (matricule) {
      const r = await crediterJusqua(matricule, new Date(), { auteur: req.user.matricule });
      return res.status(200).json({ matricule, ...r });
    }
    const r = await crediterTousLesAgents({ auteur: req.user.matricule });
    res.status(200).json(r);
  } catch (error) {
    console.error('[forcerCredit]', error);
    res.status(500).json({ error: "Une erreur est survenue lors du crédit des jours de congés." });
  }
};






