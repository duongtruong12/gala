importScripts("https://www.gstatic.com/firebasejs/9.17.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.17.1/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: 'AIzaSyDNkGKNwvHdsXGX-9oMXOWqH7den6syyJ4',
  appId: '1:26451410277:web:8dbe581a37ddd97929758c',
  messagingSenderId: '26451410277',
  projectId: 'claha-pato',
  authDomain: 'claha-pato.firebaseapp.com',
  storageBucket: 'claha-pato.appspot.com',
  measurementId: 'G-4JB1G27ML2',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((payload) => {
    const promiseChain = clients
          .matchAll({
              type: "window",
              includeUncontrolled: true
          })
          .then(windowClients => {
              for (let i = 0; i < windowClients.length; i++) {
                  const windowClient = windowClients[i];
                  windowClient.postMessage(payload);
              }
          })
          .then(() => {
              const title = payload.notification.title;
              const options = {
                  body: payload.notification.body,
                  icon: "icons/Icon-192.png"
                };
              return registration.showNotification(title, options);
          });
      return promiseChain;
});