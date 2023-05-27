const admin = require('firebase-admin');

// Configura la inicialización de Firebase
const serviceAccount = require('../config/firebaseServiceAccountKey.json');
admin.initializeApp({
    platform: serviceAccount,
    // Otros parámetros de configuración de Firebase
});
const db = admin.firestore();

module.exports = {
    db,
};
