import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pwa_install/pwa_install.dart';
import 'package:pwa_install_example/app/router.dart';
import 'package:pwa_install_example/firebase_options.dart';
import 'package:stacked/stacked.dart';

import '../app/get_it.dart';
import '../app/themes/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  PWAInstall().setup();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      theme: lightTheme,
      home: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      title: 'PWA Install',
    );
  }
}

class AppModel extends BaseViewModel {}
