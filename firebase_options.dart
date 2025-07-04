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
    apiKey: 'AIzaSyAwy-gCdZfew8hXTR6Qh_JdNox5gkAfk24',
    appId: '1:880714570579:web:48f4763883d1108e609fa6',
    messagingSenderId: '880714570579',
    projectId: 'smartattendance1-4a03f',
    authDomain: 'smartattendance1-4a03f.firebaseapp.com',
    storageBucket: 'smartattendance1-4a03f.firebasestorage.app',
    measurementId: 'G-J17C6SSDXS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhPYuSv_uDfJK5v9Z5P03Ev2-7ZwX3uGc',
    appId: '1:880714570579:android:f304f3a670e76d7e609fa6',
    messagingSenderId: '880714570579',
    projectId: 'smartattendance1-4a03f',
    storageBucket: 'smartattendance1-4a03f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYd6DoYOjzEiBQmk1ospjtP_A_ke4gsTE',
    appId: '1:880714570579:ios:5864ba309bfd4728609fa6',
    messagingSenderId: '880714570579',
    projectId: 'smartattendance1-4a03f',
    storageBucket: 'smartattendance1-4a03f.firebasestorage.app',
    iosBundleId: 'com.example.smartattendence',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCYd6DoYOjzEiBQmk1ospjtP_A_ke4gsTE',
    appId: '1:880714570579:ios:5864ba309bfd4728609fa6',
    messagingSenderId: '880714570579',
    projectId: 'smartattendance1-4a03f',
    storageBucket: 'smartattendance1-4a03f.firebasestorage.app',
    iosBundleId: 'com.example.smartattendence',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAwy-gCdZfew8hXTR6Qh_JdNox5gkAfk24',
    appId: '1:880714570579:web:0b14ea5207cf53fe609fa6',
    messagingSenderId: '880714570579',
    projectId: 'smartattendance1-4a03f',
    authDomain: 'smartattendance1-4a03f.firebaseapp.com',
    storageBucket: 'smartattendance1-4a03f.firebasestorage.app',
    measurementId: 'G-LR17XJT8WJ',
  );
}
