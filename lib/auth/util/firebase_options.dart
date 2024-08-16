import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;

      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCa6YjqK0k_t3yM7-K634lRdqeqEgY9OVs',
    appId: '1:95388415799:ios:59d8c56041c552396c8cb2',
    messagingSenderId: '95388415799',
    projectId: 'serenestream-2ed81',
    storageBucket: 'serenestream-2ed81.appspot.com',

  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEK5pC8fyMIo87RT9Y-Z5EVUjlgbQ5ck8',
    appId: '1:95388415799:android:3ab352add7e482c06c8cb2',
    messagingSenderId: '95388415799',
    projectId: 'serenestream-2ed81',
    storageBucket: 'serenestream-2ed81.appspot.com',

  );

}
