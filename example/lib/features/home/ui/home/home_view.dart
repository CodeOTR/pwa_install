import 'package:flutter/material.dart';
import 'package:pwa_install/pwa_install.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        model.notifyListeners();
      },
      builder: (context, model, child) {
        return Scaffold(
            body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('6'),
              Text('Launch Mode: ${PWAInstall().launchMode?.shortLabel}'),
              if(!(PWAInstall().launchMode?.installed ?? false)) ElevatedButton(
                  onPressed: () {
                    try {
                      PWAInstall().promptInstall_();
                    } catch (e) {
                      model.setError(e.toString());
                      model.increment();
                    }
                    model.increment();
                  },
                  child: const Text('Install')),
              Text(model.taps.toString()),
              if (model.hasError) Text(model.modelError)
            ],
          ),
        ));
      },
    );
  }
}
