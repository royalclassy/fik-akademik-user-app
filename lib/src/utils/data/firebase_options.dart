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
      print('Android');
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
    apiKey: 'AIzaSyCoxSDmmVMSyHUyK9_ocdQCIePiAsUD2g0',
    authDomain: 'peminjaman-ruangan-upnvj.firebaseapp.com',
    projectId: 'peminjaman-ruangan-upnvj',
    storageBucket: 'peminjaman-ruangan-upnvj.firebasestorage.app',
    messagingSenderId: '199686756907',
    appId: '1:199686756907:web:b77cc9b270a3115122286e',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCoxSDmmVMSyHUyK9_ocdQCIePiAsUD2g0',
    authDomain: 'peminjaman-ruangan-upnvj.firebaseapp.com',
    projectId: 'peminjaman-ruangan-upnvj',
    storageBucket: 'peminjaman-ruangan-upnvj.firebasestorage.app',
    messagingSenderId: '199686756907',
    appId: '1:199686756907:android:b77cc9b270a3115122286e',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCoxSDmmVMSyHUyK9_ocdQCIePiAsUD2g0',
    authDomain: 'peminjaman-ruangan-upnvj.firebaseapp.com',
    projectId: 'peminjaman-ruangan-upnvj',
    storageBucket: 'peminjaman-ruangan-upnvj.firebasestorage.app',
    messagingSenderId: '199686756907',
    appId: '1:199686756907:ios:b77cc9b270a3115122286e',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCoxSDmmVMSyHUyK9_ocdQCIePiAsUD2g0',
    authDomain: 'peminjaman-ruangan-upnvj.firebaseapp.com',
    projectId: 'peminjaman-ruangan-upnvj',
    storageBucket: 'peminjaman-ruangan-upnvj.firebasestorage.app',
    messagingSenderId: '199686756907',
    appId: '1:199686756907:macos:8493e0cc1df0388522286e',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );
}
