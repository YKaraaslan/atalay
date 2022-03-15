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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDA6m6sTVAY0sbgW7sNMjyy0fILQgm38wo',
    appId: '1:217184487124:web:24efdd5af7d5cbf78b1d41',
    messagingSenderId: '217184487124',
    projectId: 'atalay-d5eaf',
    authDomain: 'atalay-d5eaf.firebaseapp.com',
    storageBucket: 'atalay-d5eaf.appspot.com',
    measurementId: 'G-Q1J72H733P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPpHU_d0x3JcGAdrVvQurE0EBsxkilAqQ',
    appId: '1:217184487124:android:e8d0ccecec57e5dc8b1d41',
    messagingSenderId: '217184487124',
    projectId: 'atalay-d5eaf',
    storageBucket: 'atalay-d5eaf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCEXTi3igv3Zi4sLJmPZaZ65EsmxBu8QS8',
    appId: '1:217184487124:ios:ad90a7b41875c17d8b1d41',
    messagingSenderId: '217184487124',
    projectId: 'atalay-d5eaf',
    storageBucket: 'atalay-d5eaf.appspot.com',
    androidClientId: '217184487124-8ob3k6b2hunpg9i7l1esu67ri6qoe53a.apps.googleusercontent.com',
    iosClientId: '217184487124-bc4u358pdj2vobpg5l8s3i9vajje66b3.apps.googleusercontent.com',
    iosBundleId: 'com.atalay',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCEXTi3igv3Zi4sLJmPZaZ65EsmxBu8QS8',
    appId: '1:217184487124:ios:ad90a7b41875c17d8b1d41',
    messagingSenderId: '217184487124',
    projectId: 'atalay-d5eaf',
    storageBucket: 'atalay-d5eaf.appspot.com',
    androidClientId: '217184487124-8ob3k6b2hunpg9i7l1esu67ri6qoe53a.apps.googleusercontent.com',
    iosClientId: '217184487124-bc4u358pdj2vobpg5l8s3i9vajje66b3.apps.googleusercontent.com',
    iosBundleId: 'com.atalay',
  );
}
