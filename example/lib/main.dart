import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:js/js.dart';
import 'package:pwa_install/app/router.dart';
import 'package:pwa_install/firebase_options.dart';
import 'package:stacked/stacked.dart';

import '../app/get_it.dart';
import '../app/themes/light_theme.dart';

String launchMode = '';

/// Function that gets called from JavaScript code if app was launched as a PWA
@JS("appLaunchedAsPWA")
external set _appLaunchedAsPWA(void Function() f);

@JS()
external void appLaunchedAsPWA();

/// Function that gets called from JavaScript code if app was launched from a browser
@JS("appLaunchedInBrowser")
external set _appLaunchedInBrowser(void Function() f);

@JS()
external void appLaunchedInBrowser();

void setLaunchModeBrowser() {
  debugPrint('Launched in Browser');
  launchMode = 'Browser';
}

void setLaunchModePWA() {
  debugPrint('Launched as PWA');
  launchMode = 'PWA';
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // JavaScript code may now call `appLaunchedAsPWA()` or `window.appLaunchedAsPWA()`.
  // JavaScript code may now call `appLaunchedInBrowser()` or `window.appLaunchedInBrowser()`.
  _appLaunchedAsPWA = allowInterop(setLaunchModePWA);
  _appLaunchedInBrowser = allowInterop(setLaunchModeBrowser);

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
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemStatusBarContrastEnforced: false),
      child: Portal(
        child: MaterialApp.router(
          theme: lightTheme,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          title: 'PWA Install',
        ),
      ),
    );
  }
}

class AppModel extends BaseViewModel {}
