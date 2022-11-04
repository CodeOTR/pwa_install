library pwa_install;

import 'package:flutter/material.dart';
import 'package:js/js.dart';

/// Functions that are called from JavaScript
/// Three parts:
/// 1. external set _functionName(void Function() f);
/// 2. external void functionName();
/// 3. The actual Dart function
///
/// Function that gets called from JavaScript code if app was launched as a PWA
@JS("appLaunchedAsPWA")
external set _appLaunchedAsPWA(void Function() f);

@JS()
external void appLaunchedAsPWA();

void setLaunchModePWA() {
  debugPrint('Launched as PWA');
  PWAInstall().launchMode = LaunchMode.pwa;
}

/// Function that gets called from JavaScript code if app was launched as a TWA
@JS("appLaunchedAsTWA")
external set _appLaunchedAsTWA(void Function() f);

@JS()
external void appLaunchedAsTWA();

void setLaunchModeTWA() {
  debugPrint('Launched as TWA');
  PWAInstall().launchMode = LaunchMode.twa;
}

@JS("setHasPrompt")
external void _setHasPrompt();

@JS()
external void setHasPrompt();

void setHasPrompt_(){
  PWAInstall().hasPrompt = true;
}

/// Function that gets called from JavaScript when the app is installed as a PWA
@JS("appInstalled")
external set _appInstalled(void Function() f);

@JS()
external void appInstalled();

/// Function that gets called from JavaScript code if app was launched from a browser
@JS("appLaunchedInBrowser")
external set _appLaunchedInBrowser(void Function() f);

@JS()
external void appLaunchedInBrowser();

void setLaunchModeBrowser() {
  debugPrint('Launched in Browser');
  PWAInstall().launchMode = LaunchMode.browser;
}

/// Function that gets called from JavaScript when a install prompt has been detected
@JS("hasPrompt")
external set _hasPrompt(void Function() f);


/// JavaScript functions that are called from Dart
/// Show the PWA install prompt if it exists
@JS("promptInstall")
external void promptInstall();

/// Fetch the launch mode of the app from JavaScript
/// The launch mode is determined by checking the display-mode media query value
/// https://web.dev/customize-install/#track-how-the-pwa-was-launched
@JS("getLaunchMode")
external void getLaunchMode();

class PWAInstall {
  static final PWAInstall _pwaInstall = PWAInstall._internal();

  factory PWAInstall() {
    return _pwaInstall;
  }

  PWAInstall._internal();

  bool hasPrompt = false;

  LaunchMode? launchMode;

  Function? onAppInstalled;

  void getLaunchMode_() => getLaunchMode();

  void promptInstall_() => promptInstall();

  void setup({Function? installCallback}) {
    // JavaScript code may now call `appLaunchedAsPWA()` or `window.appLaunchedAsPWA()`.
    _appLaunchedAsPWA = allowInterop(setLaunchModePWA);
    // JavaScript code may now call `appLaunchedInBrowser()` or `window.appLaunchedInBrowser()`.
    _appLaunchedInBrowser = allowInterop(setLaunchModeBrowser);
    // JavaScript code may now call `appLaunchedAsTWA()` or `window.appLaunchedAsTWA()`.
    _appLaunchedAsTWA = allowInterop(setLaunchModeTWA);

    _hasPrompt = allowInterop(setLaunchModeTWA);
    _appInstalled = allowInterop(() {
      if (onAppInstalled != null) onAppInstalled!();
    });
    getLaunchMode_();
    onAppInstalled = installCallback;
  }
}

enum LaunchMode {
  pwa(
    shortLabel: 'PWA',
    longLabel: 'Progressive Web App',
    installed: true,
  ),
  twa(
    shortLabel: 'TWA',
    longLabel: 'Trusted Web Activity',
    installed: true,
  ),
  browser(
    shortLabel: 'Browser',
    longLabel: 'Browser',
    installed: false,
  );

  const LaunchMode({
    required this.shortLabel,
    required this.longLabel,
    required this.installed,
  });

  /// Short name for this launch mode
  final String shortLabel;

  /// Full name for this launch mode
  final String longLabel;

  /// True if the app has been installed on the user's device
  final bool installed;
}
