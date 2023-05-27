const firebase = require('firebase');

const firebaseConfig = {
    apiKey: 'AIzaSyA5UuLLfSQDvtg4mkLBi1W4DM5RleQEKKI',
    appId: '1:827576450976:web:ed1873c1ea8f7fbf342ec5',
    messagingSenderId: '827576450976',
    projectId: 'cloud_explorers-demo',
    authDomain: 'cloud_explorers-demo.firebaseapp.com',
    storageBucket: 'cloud_explorers-demo.appspot.com',
    measurementId: 'G-BLX4FT1Y52',
};

firebase.initializeApp(firebaseConfig); //initialize firebase app 
module.exports = { firebase }; //export the app
