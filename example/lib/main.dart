import 'package:flutter/material.dart';
import 'package:pwa_install/pwa_install.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PWAInstall().setup(installCallback: () {
    debugPrint('APP INSTALLED!');
  });

  runApp(MaterialApp(home: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
      title: 'PWA Install',
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('6'),
              Text('Launch Mode: ${PWAInstall().launchMode?.shortLabel}'),
              Text('Has Install Prompt: ${PWAInstall().hasPrompt}'),
              if(PWAInstall().installButtonEnabled) ElevatedButton(
                  onPressed: () {
                    try {
                      PWAInstall().promptInstall_();
                    } catch (e) {
                      setState(() {
                        error = e.toString();
                      });
                    }
                  },
                  child: const Text('Install')),
              if (error != null) Text(error!)
            ],
          ),
        ));
  }
}
