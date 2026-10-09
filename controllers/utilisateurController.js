// controllers/utilisateurController.js
// Comptes utilisateurs : login matricule (email en secours), matricule/role
// verrouillés (modifiables par l'admin uniquement), soft-delete = archivage.
const crypto = require('crypto');
const { Utilisateur, Notifications } = require('../models/association');
const { hashPassword, comparePassword, generateToken, verifyToken } = require('../utils/auth');
const { envoyerEmail } = require('../lib/resend');
const { baseFront } = require('../utils/origines');

// POST /api/users/register — création d'un compte (admin uniquement via la route)
exports.register = async (req, res) => {
  const { matricule, email, password, role } = req.body;
  if (!matricule || !password) {
    return res.status(400).json({ error: 'matricule et password requis.' });
  }
  try {
    if (await Utilisateur.findOne({ where: { matricule } })) {
      return res.status(409).json({ error: 'Matricule déjà utilisé' });
    }
    if (email && await Utilisateur.findOne({ where: { email } })) {
      return res.status(409).json({ error: 'Email déjà utilisé' });
    }
    const user = await Utilisateur.create({
      matricule, email: email || null,
      password: await hashPassword(password),
      role: role && Utilisateur.ROLES.includes(role) ? role : 'employe',
    });
    const { password: _pw, ...sansMotDePasse } = user.toJSON();
    res.status(201).json(sansMotDePasse);
  } catch (err) {
    res.status(500).json({ error: 'Erreur serveur' });
  }
};

// POST /api/users/login — matricule OU email + password
exports.login = async (req, res) => {
  const { matricule, email, password } = req.body;
  const identifiant = matricule || email;
  if (!identifiant || !password) {
    return res.status(400).json({ error: 'Identifiant (matricule ou email) et password requis.' });
  }
  try {
    const { Op } = require('sequelize');
    const user = await Utilisateur.scope('withPassword').findOne({
      where: { [Op.or]: [{ matricule: identifiant }, { email: identifiant }] },
    });
    if (!user || !user.is_active) return res.status(404).json({ error: 'Utilisateur introuvable' });
    if (!(await comparePassword(password, user.password))) {
      return res.status(401).json({ error: 'Mot de passe incorrect' });
    }
    user.last_login_at = new Date();
    await user.save();
    const token = generateToken(user);
    res.json({ token, role: user.role, id_user: user.id_user, matricule: user.matricule });
  } catch (err) {
    res.status(500).json({ error: 'Erreur serveur' });
  }
};

exports.getAll = async (req, res) => {
  try {
    const page = Math.max(parseInt(req.query.page, 10) || 1, 1);
    const limit = Math.min(Math.max(parseInt(req.query.limit, 10) || 20, 1), 100);
    const { rows, count } = await Utilisateur.findAndCountAll({
      order: [['createdAt', 'DESC']],
      limit, offset: (page - 1) * limit,
    });
    res.json({ data: rows, meta: { page, limit, total: count } });
  } catch (err) {
    res.status(500).json({ error: 'Erreur serveur' });
  }
};

exports.getById = async (req, res) => {
  try {
    const user = await Utilisateur.findByPk(req.params.id);
    if (!user) return res.status(404).json({ error: 'Utilisateur introuvable' });
    res.json(user);
  } catch (err) {
    res.status(500).json({ error: 'Erreur serveur' });
  }
};

// PUT /api/users/:id — l'utilisateur modifie son email/password ;
// SEUL l'admin peut changer le matricule est IMMUABLE, le rôle et l'état.
exports.update = async (req, res) => {
  try {
    const user = await Utilisateur.findByPk(req.params.id);
    if (!user) return res.status(404).json({ error: 'Utilisateur introuvable' });
    const estAdmin = req.user.role === 'admin';
    const estSoiMeme = req.user.id_user === user.id_user;
    if (!estAdmin && !estSoiMeme) {
      return res.status(403).json({ error: 'Vous ne pouvez modifier que votre propre compte.' });
    }
    const patch = {};
    if (req.body.email) patch.email = req.body.email;
    if (req.body.password) patch.password = await hashPassword(req.body.password);
    if (estAdmin) {
      // Le matricule reste immuable même pour l'admin (source de vérité dossier↔compte).
      if (req.body.role) {
        if (!Utilisateur.ROLES.includes(req.body.role)) {
          return res.status(400).json({ error: 'Rôle invalide.' });
        }
        patch.role = req.body.role;
      }
      if (typeof req.body.is_active === 'boolean') patch.is_active = req.body.is_active;
    } else if (req.body.role || typeof req.body.is_active === 'boolean') {
      return res.status(403).json({ error: 'Seul un admin peut modifier le rôle ou l’état du compte.' });
    }
    await user.update(patch);
    const { password: _pw, ...sansMotDePasse } = user.toJSON();
    res.json(sansMotDePasse);
  } catch (err) {
    res.status(500).json({ error: 'Erreur serveur' });
  }
};

// DELETE /api/users/:id — désactivation (admin), le compte est conservé
exports.delete = async (req, res) => {
  try {
    const user = await Utilisateur.findByPk(req.params.id);
    if (!user) return res.status(404).json({ error: 'Utilisateur introuvable' });
    user.is_active = false;
    await user.save();
    res.json({ message: 'Compte désactivé (conservé pour l’historique).' });
  } catch (err) {
    res.status(500).json({ error: 'Erreur serveur' });
  }
};

// POST /api/users/request-reset — lien de réinitialisation (token hashé en base)
exports.requestReset = async (req, res) => {
  const { email, matricule } = req.body;
  const identifiant = matricule || email;
  if (!identifiant) return res.status(400).json({ error: 'matricule ou email requis.' });
  try {
    const { Op } = require('sequelize');
    const user = await Utilisateur.findOne({
      where: { [Op.or]: [{ matricule: identifiant }, { email: identifiant }] },
    });
    // Réponse identique que le compte existe ou non (anti-énumération).
    if (!user) return res.json({ message: 'Si le compte existe, un lien a été envoyé.' });
    const token = crypto.randomBytes(32).toString('hex');
    user.reset_token_hash = crypto.createHash('sha256').update(token).digest('hex');
    user.reset_token_expire = new Date(Date.now() + 60 * 60 * 1000);
    await user.save();
    const base = baseFront();
    const resetLink = `${base}/reset-password/${token}`;
    // Envoi par email (best-effort : si RESEND_API_KEY manque, un warning est loggé).
    const envoye = await envoyerEmail({
      to: user.email,
      subject: 'Réinitialisation de votre mot de passe',
      text: `Bonjour,\n\nCliquez sur ce lien pour réinitialiser votre mot de passe (valable 1 heure) :\n${resetLink}\n\nSi vous n'êtes pas à l'origine de cette demande, ignorez cet email.`,
    });
    // En développement : le lien est aussi renvoyé dans la réponse pour tester
    // sans boîte mail. En production : réponse anonyme (anti-énumération).
    if (process.env.NODE_ENV !== 'production') {
      return res.json({ message: 'Lien généré', envoye, resetLink });
    }
    return res.json({ message: 'Si le compte existe, un lien a été envoyé.' });
  } catch (err) {
    res.status(500).json({ error: 'Erreur d’envoi du lien' });
  }
};

// POST /api/users/reset-password/:token
exports.resetPassword = async (req, res) => {
  const { password } = req.body;
  const { token } = req.params;
  if (!password) return res.status(400).json({ error: 'Nouveau mot de passe requis.' });
  try {
    const hash = crypto.createHash('sha256').update(token).digest('hex');
    const { Op } = require('sequelize');
    const user = await Utilisateur.findOne({
      where: { reset_token_hash: hash, reset_token_expire: { [Op.gt]: new Date() } },
    });
    if (!user) return res.status(400).json({ error: 'Token invalide ou expiré' });
    // Compatibilité : anciens liens JWT signés avec le secret (période de transition)
    let cible = user;
    if (!cible) {
      const decoded = verifyToken(token);
      cible = await Utilisateur.findOne({ where: { matricule: decoded.matricule } });
      if (!cible) return res.status(404).json({ error: 'Utilisateur introuvable' });
    }
    cible.password = await hashPassword(password);
    cible.reset_token_hash = null;
    cible.reset_token_expire = null;
    await cible.save();
    res.json({ message: 'Mot de passe réinitialisé' });
  } catch (err) {
    res.status(400).json({ error: 'Token invalide ou expiré' });
  }
};
