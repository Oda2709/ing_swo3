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
    apiKey: 'AIzaSyCyUzjwryJQzwwRGxXe4ftXYOsyKkyDqNQ',
    appId: '1:175886454401:web:17d048ba5a2215bc3fc780',
    messagingSenderId: '175886454401',
    projectId: 'ch2o-4df5d',
    authDomain: 'ch2o-4df5d.firebaseapp.com',
    storageBucket: 'ch2o-4df5d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvpBbVblzJStonyUXe5wSS8vmuBPA4_Bo',
    appId: '1:175886454401:android:347f430a11caa14b3fc780',
    messagingSenderId: '175886454401',
    projectId: 'ch2o-4df5d',
    storageBucket: 'ch2o-4df5d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7rmoMj8q9yN2LPV9TrFzi7Dd-K40R9Ns',
    appId: '1:175886454401:ios:a09497473aa9ff8d3fc780',
    messagingSenderId: '175886454401',
    projectId: 'ch2o-4df5d',
    storageBucket: 'ch2o-4df5d.appspot.com',
    iosBundleId: 'com.example.cafe1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD7rmoMj8q9yN2LPV9TrFzi7Dd-K40R9Ns',
    appId: '1:175886454401:ios:a09497473aa9ff8d3fc780',
    messagingSenderId: '175886454401',
    projectId: 'ch2o-4df5d',
    storageBucket: 'ch2o-4df5d.appspot.com',
    iosBundleId: 'com.example.cafe1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCyUzjwryJQzwwRGxXe4ftXYOsyKkyDqNQ',
    appId: '1:175886454401:web:a2554639fddc5d653fc780',
    messagingSenderId: '175886454401',
    projectId: 'ch2o-4df5d',
    authDomain: 'ch2o-4df5d.firebaseapp.com',
    storageBucket: 'ch2o-4df5d.appspot.com',
  );
}
