// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBsngxYkdvmTmkAE8aBR1ZzAXLaf5iMH9A',
    appId: '1:8688587901:web:38c1c762d9c6fc1ff0cd14',
    messagingSenderId: '8688587901',
    projectId: 'hotel-hunter-1f40d',
    authDomain: 'hotel-hunter-1f40d.firebaseapp.com',
    storageBucket: 'hotel-hunter-1f40d.appspot.com',
    measurementId: 'G-0F0C5SB7FQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5Rx9TUnCyiAEefPb134GTVRQsfKXN4MI',
    appId: '1:8688587901:android:fdbc0ac1c8129f14f0cd14',
    messagingSenderId: '8688587901',
    projectId: 'hotel-hunter-1f40d',
    storageBucket: 'hotel-hunter-1f40d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDq5t0BmIyntVh5b-vZCUrwP_E0Pdc0yug',
    appId: '1:8688587901:ios:3a62dae46fcc7312f0cd14',
    messagingSenderId: '8688587901',
    projectId: 'hotel-hunter-1f40d',
    storageBucket: 'hotel-hunter-1f40d.appspot.com',
    iosBundleId: 'com.example.events',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDq5t0BmIyntVh5b-vZCUrwP_E0Pdc0yug',
    appId: '1:8688587901:ios:9473495fc183baa7f0cd14',
    messagingSenderId: '8688587901',
    projectId: 'hotel-hunter-1f40d',
    storageBucket: 'hotel-hunter-1f40d.appspot.com',
    iosBundleId: 'com.example.hotelHunter.RunnerTests',
  );
}
