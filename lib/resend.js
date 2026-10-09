// lib/resend.js — envoi d'emails en best-effort (Resend).
//  - Sans RESEND_API_KEY : aucun envoi, avertissement loggé (API jamais impactée).
//  - Réseau intermittent vers api.resend.com : jusqu'à 3 tentatives avec backoff.
const { Resend } = require('resend');

const resend = process.env.RESEND_API_KEY ? new Resend(process.env.RESEND_API_KEY) : null;

const pause = (ms) => new Promise((r) => setTimeout(r, ms));

/**
 * Envoie un email texte (3 essais max : immédiat, +1 s, +3 s).
 * @returns {boolean} true si l'envoi a réussi
 */
async function envoyerEmail({ to, subject, text, html }) {
  if (!to) return false;
  if (!resend) {
    console.warn(`[email] RESEND_API_KEY absente — email NON envoyé : "${subject}" à ${to}`);
    return false;
  }
  const message = {
    from: process.env.RESEND_FROM || 'onboarding@resend.dev',
    to,
    subject,
    text,
    html: html || undefined,
  };
  const delais = [0, 1000, 3000]; // 3 tentatives
  for (let essai = 0; essai < delais.length; essai += 1) {
    if (delais[essai]) await pause(delais[essai]);
    try {
      const { data, error } = await resend.emails.send(message);
      if (!error) return true;
      console.warn(`[email] tentative ${essai + 1}/${delais.length} échouée :`,
        JSON.stringify(error));
    } catch (err) {
      console.warn(`[email] tentative ${essai + 1}/${delais.length} échouée :`,
        err.message, '| cause:', err.cause && (err.cause.code || err.cause.message));
    }
  }
  console.warn(`[email] ÉCHEC DÉFINITIF après ${delais.length} essais : "${subject}" à ${to}`);
  return false;
}

module.exports = { envoyerEmail, estConfigure: () => !!resend };
