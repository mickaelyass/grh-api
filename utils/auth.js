// utils/auth.js
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const Utilisateur = require('../models/utilisateur');

// Secret en variable d'environnement (fichier .env) — plus de clé en dur.
const SECRET_KEY = process.env.JWT_SECRET || 'DAMSO';

const generateToken = (user) => {
  return jwt.sign(
    { id: user.id_user, role: user.role, matricule: user.matricule },
    SECRET_KEY,
    { expiresIn: '1h' }
  );
};

const hashPassword = async (password) => {
  const salt = await bcrypt.genSalt(10);
  return bcrypt.hash(password, salt);
};

const comparePassword = async (password, hashedPassword) => {
  return bcrypt.compare(password, hashedPassword);
};

const verifyToken = (token) => {
  return jwt.verify(token, SECRET_KEY);
};

/**
 * Vérifie le porteur du JWT et charge le compte en base
 * (`req.user` = instance Utilisateur SANS le mot de passe).
 */
const authenticate = async (req, res, next) => {
  const header = req.header('Authorization');
  if (!header) {
    return res.status(401).json({ error: 'Authentification requise.' });
  }
  try {
    const token = header.replace('Bearer ', '');
    const decoded = jwt.verify(token, SECRET_KEY);
    const user = await Utilisateur.findByPk(decoded.id);

    if (!user || !user.is_active) {
      return res.status(401).json({ error: 'Compte introuvable ou désactivé.' });
    }

    req.user = user;
    next();
  } catch (err) {
    res.status(401).json({ error: 'Jeton invalide ou expiré.' });
  }
};




/**
 * Restreint une route à certains rôles.
 * Le rôle est relu EN BASE (`req.user`, fourni par `authenticate`) :
 * un rôle périmérimé dans le JWT n'autorise donc rien de plus.
 *
 *   router.get('/x', authenticate, requireRole('admin', 'directrice'), handler)
 */
const requireRole = (...roles) => (req, res, next) => {
  if (!req.user) {
    return res.status(401).json({ error: 'Authentification requise.' });
  }
  if (!roles.includes(req.user.role)) {
    return res.status(403).json({
      error: `Accès refusé : rôle requis ${roles.join(' ou ')} (votre rôle : ${req.user.role}).`,
    });
  }
  next();
};

module.exports = { generateToken, hashPassword, comparePassword, verifyToken, authenticate, requireRole };
