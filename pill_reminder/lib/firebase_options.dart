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
    apiKey: 'AIzaSyCgG_13Wy56zDapT3AEU1bG3k4lMhw2Y3A',
    appId: '1:380268192868:web:d62f16633d7641e0146b71',
    messagingSenderId: '380268192868',
    projectId: 'pill-reminder-27a6a',
    authDomain: 'pill-reminder-27a6a.firebaseapp.com',
    storageBucket: 'pill-reminder-27a6a.firebasestorage.app',
    measurementId: 'G-0HVQD7XV9N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvra1uq2L97bj_ksdmnSY9WBANxkj5KM4',
    appId: '1:380268192868:android:be8300af0ff3895a146b71',
    messagingSenderId: '380268192868',
    projectId: 'pill-reminder-27a6a',
    storageBucket: 'pill-reminder-27a6a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBSgsnJhPLM6xoCMnc6Btn5HP8U9SOURJc',
    appId: '1:380268192868:ios:97bca5b9fe848dca146b71',
    messagingSenderId: '380268192868',
    projectId: 'pill-reminder-27a6a',
    storageBucket: 'pill-reminder-27a6a.firebasestorage.app',
    iosBundleId: 'com.example.pillReminder',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBSgsnJhPLM6xoCMnc6Btn5HP8U9SOURJc',
    appId: '1:380268192868:ios:97bca5b9fe848dca146b71',
    messagingSenderId: '380268192868',
    projectId: 'pill-reminder-27a6a',
    storageBucket: 'pill-reminder-27a6a.firebasestorage.app',
    iosBundleId: 'com.example.pillReminder',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCgG_13Wy56zDapT3AEU1bG3k4lMhw2Y3A',
    appId: '1:380268192868:web:ad96a9e7640b4e99146b71',
    messagingSenderId: '380268192868',
    projectId: 'pill-reminder-27a6a',
    authDomain: 'pill-reminder-27a6a.firebaseapp.com',
    storageBucket: 'pill-reminder-27a6a.firebasestorage.app',
    measurementId: 'G-PY26LYGWYJ',
  );

}