var admin = require('firebase-admin');
const serviceAccount = require('./study-pal-1187e-firebase-adminsdk-hegd3-83ab11b3d0.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();
db.settings({ignoreUndefinedProperties: true});

module.exports = {
  db: db,
  admin: admin
};
