import 'package:pwa_install_view/app/go_router.dart';
import 'package:pwa_install_view/shared/observers/basic_navigator_observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:stacked/stacked.dart';
import '../app/get_it.dart';
import '../app/themes/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
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
          title: 'Healthy Pet Connect Dashboard',
        ),
      ),
    );
  }
}

class AppModel extends BaseViewModel {}