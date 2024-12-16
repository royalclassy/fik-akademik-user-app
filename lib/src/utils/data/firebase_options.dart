import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }


  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBLNfvUzwRy1EUKw0x-V34eSLCZQvSTvDU',
    authDomain: 'fik-akademik-user-app.firebaseapp.com',
    projectId: 'fik-akademik-user-app',
    storageBucket: 'fik-akademik-user-app.firebasestorage.app',
    messagingSenderId: '195335063252',
    appId: '1:195335063252:web:7e2e1d3eb0f6eb84f5dd41d',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLNfvUzwRy1EUKw0x-V34eSLCZQvSTvDU',
    authDomain: 'fik-akademik-user-app.firebaseapp.com',
    projectId: 'fik-akademik-user-app',
    storageBucket: 'fik-akademik-user-app.firebasestorage.app',
    messagingSenderId: '195335063252',
    appId: '1:195335063252:android:7e2e1d3eb0f6eb84f5dd41',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLNfvUzwRy1EUKw0x-V34eSLCZQvSTvDU',
    authDomain: 'fik-akademik-user-app.firebaseapp.com',
    projectId: 'fik-akademik-user-app',
    storageBucket: 'fik-akademik-user-app.firebasestorage.app',
    messagingSenderId: '195335063252',
    appId: '1:195335063252:ios:7e2e1d3eb0f6eb84f5dd41',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBLNfvUzwRy1EUKw0x-V34eSLCZQvSTvDU',
    authDomain: 'fik-akademik-user-app.firebaseapp.com',
    projectId: 'fik-akademik-user-app',
    storageBucket: 'fik-akademik-user-app.firebasestorage.app',
    messagingSenderId: '195335063252',
    appId: '1:195335063252:macos:7e2e1d3eb0f6eb84f5dd41',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );
}