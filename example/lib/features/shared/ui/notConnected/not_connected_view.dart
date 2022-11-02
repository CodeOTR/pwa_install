import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'not_connected_view_model.dart';

class NotConnectedView extends StatelessWidget {
  const NotConnectedView({Key? key}) : super(key: key);

  get router => null;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotConnectedViewModel>.reactive(
      viewModelBuilder: () => NotConnectedViewModel(),
      onModelReady: (model) {
        // model.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Icon(Icons.wifi_off,
                      size: 36,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: Center(
                      child: Text('You aren\'t connected to the internet',
                        textAlign: TextAlign.center,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4,),
                    ),
                  ),
                  OutlinedButton(onPressed: () {
                    router.pop();
                  }, child:Text('Go Back',
                    style: Theme.of(context).textTheme.subtitle1,))
                ],
              ),
            ));
      },
    );
  }
}
