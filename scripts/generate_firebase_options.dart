import 'dart:io';

void main() {
  // Dev Firebase Options
  final devAndroidApiKey = Platform.environment['FIREBASE_DEV_ANDROID_API_KEY'];
  final devIOSApiKey = Platform.environment['FIREBASE_DEV_IOS_API_KEY'];
  final devAndroidAppId = Platform.environment['FIREBASE_DEV_ANDROID_APP_ID'];
  final devIOSAppId = Platform.environment['FIREBASE_DEV_IOS_APP_ID'];
  final devMessagingSenderId =
      Platform.environment['FIREBASE_DEV_MESSAGING_SENDER_ID'];
  final devProjectId = Platform.environment['FIREBASE_DEV_PROJECT_ID'];
  final devStorageBucket = Platform.environment['FIREBASE_DEV_STORAGE_BUCKET'];
  final devIosClientId = Platform.environment['FIREBASE_DEV_IOS_CLIENT_ID'];
  final devIosBundleId = Platform.environment['FIREBASE_DEV_IOS_BUNDLE_ID'];

  // Prod Firebase Options
  final prodAndroidApiKey =
      Platform.environment['FIREBASE_PROD_ANDROID_API_KEY'];
  final prodIOSApiKey = Platform.environment['FIREBASE_PROD_IOS_API_KEY'];
  final prodAndroidAppId = Platform.environment['FIREBASE_PROD_ANDROID_APP_ID'];
  final prodIOSAppId = Platform.environment['FIREBASE_PROD_IOS_APP_ID'];
  final prodMessagingSenderId =
      Platform.environment['FIREBASE_PROD_MESSAGING_SENDER_ID'];
  final prodProjectId = Platform.environment['FIREBASE_PROD_PROJECT_ID'];
  final prodStorageBucket =
      Platform.environment['FIREBASE_PROD_STORAGE_BUCKET'];
  final prodIosClientId = Platform.environment['FIREBASE_PROD_IOS_CLIENT_ID'];
  final prodIosBundleId = Platform.environment['FIREBASE_PROD_IOS_BUNDLE_ID'];

  // Generate Dev Firebase Options file
  if (devAndroidApiKey != null &&
      devIOSApiKey != null &&
      devAndroidAppId != null &&
      devIOSAppId != null &&
      devMessagingSenderId != null &&
      devProjectId != null &&
      devStorageBucket != null &&
      devIosClientId != null &&
      devIosBundleId != null) {
    final devContent = '''
    import 'package:flutter/foundation.dart'
        show defaultTargetPlatform, kIsWeb, TargetPlatform;
    import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

    class DefaultFirebaseOptions {
      static FirebaseOptions get currentPlatform {
        if (kIsWeb) {
          throw UnsupportedError(
            'DefaultFirebaseOptions have not been configured for web - '
            'you can reconfigure this by running the FlutterFire CLI again.',
          );
        }
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            return android;
          case TargetPlatform.iOS:
            return ios;
          case TargetPlatform.macOS:
            throw UnsupportedError(
              'DefaultFirebaseOptions have not been configured for macos - '
              'you can reconfigure this by running the FlutterFire CLI again.',
            );
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

      static const FirebaseOptions android = FirebaseOptions(
        apiKey: '$devAndroidApiKey',
        appId: '$devAndroidAppId',
        messagingSenderId: '$devMessagingSenderId',
        projectId: '$devProjectId',
        storageBucket: '$devStorageBucket',
      );

      static const FirebaseOptions ios = FirebaseOptions(
        apiKey: '$devIOSApiKey',
        appId: '$devIOSAppId',
        messagingSenderId: '$devMessagingSenderId',
        projectId: '$devProjectId',
        storageBucket: '$devStorageBucket',
        iosClientId: '$devIosClientId',
        iosBundleId: '$devIosBundleId',
      );
    }

    ''';
    File('lib/firebase_options_dev.dart').writeAsStringSync(devContent);
  } else {
    exit(1);
  }

  // Generate Prod Firebase Options file
  if (prodAndroidApiKey != null &&
      prodIOSApiKey != null &&
      prodAndroidAppId != null &&
      prodIOSAppId != null &&
      prodMessagingSenderId != null &&
      prodProjectId != null &&
      prodStorageBucket != null &&
      prodIosClientId != null &&
      prodIosBundleId != null) {
    final prodContent = '''
    import 'package:flutter/foundation.dart'
        show defaultTargetPlatform, kIsWeb, TargetPlatform;
    import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

    class DefaultFirebaseOptions {
      static FirebaseOptions get currentPlatform {
        if (kIsWeb) {
          throw UnsupportedError(
            'DefaultFirebaseOptions have not been configured for web - '
            'you can reconfigure this by running the FlutterFire CLI again.',
          );
        }
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            return android;
          case TargetPlatform.iOS:
            return ios;
          case TargetPlatform.macOS:
            throw UnsupportedError(
              'DefaultFirebaseOptions have not been configured for macos - '
              'you can reconfigure this by running the FlutterFire CLI again.',
            );
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

      static const FirebaseOptions android = FirebaseOptions(
        apiKey: '$prodAndroidApiKey',
        appId: '$prodAndroidAppId',
        messagingSenderId: '$prodMessagingSenderId',
        projectId: '$prodProjectId',
        storageBucket: '$prodStorageBucket',
      );

      static const FirebaseOptions ios = FirebaseOptions(
        apiKey: '$prodIOSApiKey',
        appId: '$prodIOSAppId',
        messagingSenderId: '$prodMessagingSenderId',
        projectId: '$prodProjectId',
        storageBucket: '$prodStorageBucket',
        iosClientId: '$prodIosClientId',
        iosBundleId: '$prodIosBundleId',
      );
    }

    ''';
    File('lib/firebase_options_prod.dart').writeAsStringSync(prodContent);
  } else {
    exit(1);
  }
}
