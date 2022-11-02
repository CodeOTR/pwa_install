import 'package:flutter/material.dart';

/// Simple Navigator Observer that will print out navigation events
class BasicNavigatorObserver extends NavigatorObserver{

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    //debugPrint('Route pushed (current): '+ (route.settings.name ?? 'None'));
    //debugPrint('Route pushed (previous): '+ (previousRoute?.settings.name ?? 'None'));
    debugPrint('Route pushed: (${(previousRoute?.settings.name ?? 'None')}) --> (${(route.settings.name ?? 'None')})');
  }

  @override
  void didStopUserGesture() {
    debugPrint('User stopped navigation gesture');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('User started navigation gesture: (${(previousRoute?.settings.name ?? 'none')}) <-- (${(route.settings.name ?? 'none')})');
    //debugPrint('User started navigation gesture. Previous route: '+ (previousRoute?.settings.name ?? 'none'));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    //debugPrint('Route replaced (new): ( '+ (newRoute?.settings.name ?? 'None'));
    //debugPrint('Route replaced (old): '+ (oldRoute?.settings.name ?? 'None'));
    debugPrint('Route replaced: (${(oldRoute?.settings.name ?? 'None')}) ~~> (${(oldRoute?.settings.name ?? 'None')})');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    //debugPrint('Route removed (removed): '+ (route.settings.name ?? 'None'));
    //debugPrint('Route removed (removed until): '+ (previousRoute?.settings.name ?? 'None'));
    debugPrint('Route removed: (${(previousRoute?.settings.name ?? 'None')}) <-- (${(route.settings.name ?? 'None')})');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // debugPrint('Route popped (popped): '+ (route.settings.name ?? 'None'));
    //debugPrint('Route popped (popped until, now active): '+ (previousRoute?.settings.name ?? 'None'));
    debugPrint('Route popped: (${(previousRoute?.settings.name ?? 'None')}) <-- (${(route.settings.name ?? 'None')})');
  }
}