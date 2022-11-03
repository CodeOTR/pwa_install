import 'package:flutter/material.dart';
import 'package:pwa_install/prompt.dart';
import 'package:stacked/stacked.dart';
import 'package:js/js.dart' as js;


import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
            body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('3'),
              ElevatedButton(
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
