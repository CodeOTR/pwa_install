import 'package:flutter/material.dart';
import 'package:pwa_install/js/display_mode.dart';
import 'package:pwa_install/js/prompt.dart';
import 'package:pwa_install/main.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        getPWADisplayMode();
        model.notifyListeners();
      },
      builder: (context, model, child) {
        return Scaffold(
            body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('5'),
              Text('Launch Mode: $launchMode'),
              if(launchMode != 'PWA') ElevatedButton(
                  onPressed: () {
                    try {
                      //var object = js.JsObject(js.context['Object']);
                      //object.callMethod('promptInstall');
                      //alertMessage('hi');
                      promptInstall();
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
