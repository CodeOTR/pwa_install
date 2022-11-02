import 'package:cloud_functions/cloud_functions.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:universal_io/io.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

/// REFS
/// https://stackoverflow.com/questions/38962025/can-i-initialize-firebase-without-using-google-services-json

@injectable
class FirebaseService with ReactiveServiceMixin {

  String firestorePort = '8080';
  String functionsPort = '5001';
  String authPort = '9099';
  String emulatorIp = '192.168.0.4';

  // Platform.environment.containsKey('FLUTTER_TEST') ? FakeFirebaseFirestore() :
  // Using this structure to enable mocking for tests
  FirebaseFirestore get firestore {
    return FirebaseFirestore.instance;
  }

  FirebaseAuth get auth {
    return authInstance ?? FirebaseAuth.instance;
  }

  FirebaseAuth? authInstance;

  /// MockFirebaseAuth or real Firebase Auth, used in testing
  void setAuth(dynamic newAuth) {
    authInstance = newAuth;
    notifyListeners();
  }

  /// Setup that's called only if the app should be running on the emulator
  /// TODO https://github.com/firebase/firebase-tools-ui/issues/519
  Future<void> setUpEmulator() async {
    debugPrint('Setting up emulator');
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;

      // Set up emulator for physical device
      if (androidDeviceInfo.isPhysicalDevice ?? false) {
        await setupEmulatorsForPhysicalDevice();
      }

      // Set up emulator for emulated device
      else {
        await setupEmulatorsForEmulatedDevice();
      }
    }

    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;

      // Set up emulator for physical device
      if (iosDeviceInfo.isPhysicalDevice) {
        await setupEmulatorsForPhysicalDevice();
      }

      // Set up emulator for emulated device
      else {
        await setupEmulatorsForEmulatedDevice();
      }
    }
  }

  /// Get device IP using ipconfig /all
  Future<void> setupEmulatorsForPhysicalDevice() async {
    debugPrint('Setting up physical emulator');
    // Real Device
    String host = '$emulatorIp:$firestorePort';

    // Set the host as soon as possible.
    firestore.settings = Settings(
      host: host,
      sslEnabled: false,
    );

    FirebaseFunctions.instance.useFunctionsEmulator('http://$emulatorIp:$functionsPort', 5001);

    await auth.useAuthEmulator('http://$emulatorIp', int.parse(authPort));
  }

  Future<void> setupEmulatorsForEmulatedDevice() async {
    debugPrint('Setting up physical emulator');

    // Emulated Device
    String host = '10.0.2.2:$firestorePort';

    // Set the host as soon as possible.
    firestore.settings = Settings(
      host: host,
      sslEnabled: false,
    );

    FirebaseFunctions.instance.useFunctionsEmulator('http://10.0.2.2:$functionsPort', 5001);

    await auth.useAuthEmulator('http://10.0.2.2',int.parse(authPort));
  }

  Future<void> setupApps() async {
    debugPrint('Setting up Firebase');
    await Firebase.initializeApp();

    // Init shared project
    try {
      await Firebase.initializeApp(
        name: 'Care_Navigation',
        options: getFirebaseOptions(),
      );
    } on FirebaseException catch (e) {
      if (e.code == 'duplicate-app') {
        debugPrint('Duplicate app found');
        // you can choose not to do anything here or either
        // In a case where you are assigning the initializer instance to a FirebaseApp variable, // do something like this:
        //
        //   app = Firebase.app('Flamelink');
        //
      } else {
        debugPrint('Firebase app: '+ e.message!);
        throw e;
      }
    } catch (e) {
      debugPrint('Firebase other error');
      rethrow;
    }

    if (FirebaseAuth.instanceFor(app: Firebase.app('Care_Navigation')).currentUser == null) {
      debugPrint('New anonymous account');
      await FirebaseAuth.instanceFor(app: Firebase.app('Care_Navigation')).signInAnonymously();
    }
  }

  FirebaseOptions getFirebaseOptions() {
    if (Platform.isAndroid) {
      return const FirebaseOptions(
        apiKey: "AIzaSyDPH-bHCg3l3CjsPO0UW2G_PMEwqlxHqYM",
        projectId: "care-navigation-ba4be",
        messagingSenderId: "40073693423",
        appId: "1:40073693423:android:bbfe293e8dd48cf378331a",
      );
    } else if (Platform.isIOS) {
      return const FirebaseOptions(
        apiKey: "AIzaSyDPH-bHCg3l3CjsPO0UW2G_PMEwqlxHqYM",
        projectId: "care-navigation-ba4be",
        messagingSenderId: "40073693423",
        appId: "1:40073693423:ios:f658e8fe2a61d88d78331a",
      );
    } else if (kIsWeb) {
      return const FirebaseOptions(
          apiKey: "AIzaSyBlJ8lcDugVnhyWBGrX2AOKubI3x5Yn34g",
          authDomain: "care-navigation-ba4be.firebaseapp.com",
          projectId: "care-navigation-ba4be",
          storageBucket: "care-navigation-ba4be.appspot.com",
          messagingSenderId: "40073693423",
          appId: "1:40073693423:web:be500420fb99378d78331a",
          measurementId: "G-Z3Q2057XV1");
    } else {
      return const FirebaseOptions(
        apiKey: "AIzaSyDPH-bHCg3l3CjsPO0UW2G_PMEwqlxHqYM",
        projectId: "care-navigation-ba4be",
        messagingSenderId: "40073693423",
        appId: "1:40073693423:android:bbfe293e8dd48cf378331a",
      );
    }
  }
}
