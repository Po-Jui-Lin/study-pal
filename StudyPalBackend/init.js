var admin = require('firebase-admin');
const serviceAccount = require('./study-pal-dff4c-firebase-adminsdk-874tc-ed3e847c36.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();
db.settings({ignoreUndefinedProperties: true});

module.exports = {
  db: db
};
