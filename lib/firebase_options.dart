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
    apiKey: 'AIzaSyBD8PHyU4jEQqePPyKwGQSgRgz6ABZWlwM',
    appId: '1:451860151967:web:48f226a616814d5aa72caa',
    messagingSenderId: '451860151967',
    projectId: 'carworkshop-59450',
    authDomain: 'carworkshop-59450.firebaseapp.com',
    storageBucket: 'carworkshop-59450.firebasestorage.app',
    measurementId: 'G-935X0P49LW',
    databaseURL:"https://carworkshop-59450-default-rtdb.asia-southeast1.firebasedatabase.app",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcuDL1dGX35bHz0L9MhZsCKriIK_0yc1w',
    appId: '1:451860151967:android:a63ac83db8aa1b20a72caa',
    messagingSenderId: '451860151967',
    projectId: 'carworkshop-59450',
    storageBucket: 'carworkshop-59450.firebasestorage.app',
    databaseURL:"https://carworkshop-59450-default-rtdb.asia-southeast1.firebasedatabase.app",

  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACe2WAic6ffhipbu0lgkYEcCHpuDSDS4E',
    appId: '1:451860151967:ios:1b7e34b48fea60f1a72caa',
    messagingSenderId: '451860151967',
    projectId: 'carworkshop-59450',
    storageBucket: 'carworkshop-59450.firebasestorage.app',
    iosBundleId: 'com.example.carWorkshopMobileApp',
    databaseURL:"https://carworkshop-59450-default-rtdb.asia-southeast1.firebasedatabase.app",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACe2WAic6ffhipbu0lgkYEcCHpuDSDS4E',
    appId: '1:451860151967:ios:1b7e34b48fea60f1a72caa',
    messagingSenderId: '451860151967',
    projectId: 'carworkshop-59450',
    storageBucket: 'carworkshop-59450.firebasestorage.app',
    iosBundleId: 'com.example.carWorkshopMobileApp',
    databaseURL:"https://carworkshop-59450-default-rtdb.asia-southeast1.firebasedatabase.app",
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBD8PHyU4jEQqePPyKwGQSgRgz6ABZWlwM',
    appId: '1:451860151967:web:314ad97404ce49eca72caa',
    messagingSenderId: '451860151967',
    projectId: 'carworkshop-59450',
    authDomain: 'carworkshop-59450.firebaseapp.com',
    storageBucket: 'carworkshop-59450.firebasestorage.app',
    measurementId: 'G-51PGGBDMY0',
  );
}
