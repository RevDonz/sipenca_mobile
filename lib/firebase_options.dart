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
    apiKey: 'AIzaSyC-B0RU3RKhKqDItPt1ws6EIB3qmAZe-GU',
    appId: '1:634931892716:web:24393ff6485deb95eb70c9',
    messagingSenderId: '634931892716',
    projectId: 'sipenca-2cebd',
    authDomain: 'sipenca-2cebd.firebaseapp.com',
    storageBucket: 'sipenca-2cebd.appspot.com',
    measurementId: 'G-GV30MTV497',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLakPGLCRh-lrAKzcoTlSMDulGLO3OFoI',
    appId: '1:634931892716:android:f18198a23ab6b20beb70c9',
    messagingSenderId: '634931892716',
    projectId: 'sipenca-2cebd',
    storageBucket: 'sipenca-2cebd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmt4LovrjzBPXfucnrBPqjjBoyM_FNTo8',
    appId: '1:634931892716:ios:ab89ce191d19369deb70c9',
    messagingSenderId: '634931892716',
    projectId: 'sipenca-2cebd',
    storageBucket: 'sipenca-2cebd.appspot.com',
    iosClientId:
        '634931892716-3dunl1k7285ie7cvt6me97fbbrp7ej3o.apps.googleusercontent.com',
    iosBundleId: 'com.example.sipencaMobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmt4LovrjzBPXfucnrBPqjjBoyM_FNTo8',
    appId: '1:634931892716:ios:ab89ce191d19369deb70c9',
    messagingSenderId: '634931892716',
    projectId: 'sipenca-2cebd',
    storageBucket: 'sipenca-2cebd.appspot.com',
    iosClientId:
        '634931892716-3dunl1k7285ie7cvt6me97fbbrp7ej3o.apps.googleusercontent.com',
    iosBundleId: 'com.example.sipencaMobile',
  );
}