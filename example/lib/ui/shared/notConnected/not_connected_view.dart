import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../app/app_router.dart';
import 'package:simple_animations/stateless_animation/mirror_animation.dart';
import 'package:stacked/stacked.dart';

import 'not_connected_view_model.dart';

class NotConnectedView extends StatelessWidget {
  const NotConnectedView({Key? key}) : super(key: key);

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
                  Center(
                    child: MirrorAnimation(
                      tween: Tween<double>(begin: 2, end: 4),
                      builder: (context, child, double value) {
                        return Transform.scale(
                          scale: value,
                          child: const Icon(Icons.wifi_off,
                            size: 36,),
                        );
                      },
                    ),
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
                    appRouter.pop();
                  }, child:Text('Go Back',
                    style: Theme.of(context).textTheme.subtitle1,))
                ],
              ),
            ));
      },
    );
  }
}
