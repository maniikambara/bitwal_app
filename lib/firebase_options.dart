// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDt0Fh-9Oebb9H6GVZWwkjIIc1iQL6p0eI',
    appId: '1:492169211395:web:1bb61ce69892e8dba62836',
    messagingSenderId: '492169211395',
    projectId: 'bitwal-app',
    authDomain: 'bitwal-app.firebaseapp.com',
    storageBucket: 'bitwal-app.firebasestorage.app',
    measurementId: 'G-L694FKFM3V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJMWCuoKrWmU-YnDHoxVlIfeh-1u2_nh4',
    appId: '1:492169211395:android:1093265042460eb7a62836',
    messagingSenderId: '492169211395',
    projectId: 'bitwal-app',
    storageBucket: 'bitwal-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMZX-9lEYUQpDI6Z32sflPmafF5aJ96-0',
    appId: '1:492169211395:ios:00a99eaf6fb4205ba62836',
    messagingSenderId: '492169211395',
    projectId: 'bitwal-app',
    storageBucket: 'bitwal-app.firebasestorage.app',
    iosBundleId: 'com.example.bitwalApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMZX-9lEYUQpDI6Z32sflPmafF5aJ96-0',
    appId: '1:492169211395:ios:00a99eaf6fb4205ba62836',
    messagingSenderId: '492169211395',
    projectId: 'bitwal-app',
    storageBucket: 'bitwal-app.firebasestorage.app',
    iosBundleId: 'com.example.bitwalApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDt0Fh-9Oebb9H6GVZWwkjIIc1iQL6p0eI',
    appId: '1:492169211395:web:fbe44f92126bdcfca62836',
    messagingSenderId: '492169211395',
    projectId: 'bitwal-app',
    authDomain: 'bitwal-app.firebaseapp.com',
    storageBucket: 'bitwal-app.firebasestorage.app',
    measurementId: 'G-ZSP3RG1T23',
  );
}
