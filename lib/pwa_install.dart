library pwa_install;

import 'package:flutter/material.dart';
import 'package:js/js.dart';

/// Function that gets called from JavaScript code if app was launched as a PWA
@JS("appLaunchedAsPWA")
external set _appLaunchedAsPWA(void Function() f);

/// Function that gets called from JavaScript code if app was launched as a TWA
@JS("appLaunchedAsTWA")
external set _appLaunchedAsTWA(void Function() f);

/// Function that gets called from JavaScript code if app was launched from a browser
@JS("appLaunchedInBrowser")
external set _appLaunchedInBrowser(void Function() f);

class PWAInstall {
  static final PWAInstall _pwaInstall = PWAInstall._internal();

  factory PWAInstall() => _pwaInstall;

  PWAInstall._internal();

  LaunchMode? launchMode;

  @JS()
  external void appLaunchedAsPWA();

  void setLaunchModePWA() {
    debugPrint('Launched as PWA');
    launchMode = LaunchMode.pwa;
  }

  @JS()
  external void appLaunchedAsTWA();

  void setLaunchModeTWA() {
    debugPrint('Launched as TWA');
    launchMode = LaunchMode.twa;
  }

  @JS()
  external void appLaunchedInBrowser();

  void setLaunchModeBrowser() {
    debugPrint('Launched in Browser');
    launchMode = LaunchMode.browser;
  }

  /// Show the PWA install prompt if it exists
  @JS("promptInstall")
  external void promptInstall();

  /// Fetch the launch mode of the app from JavaScript
  /// The launch mode is determined by checking the display-mode media query value
  /// https://web.dev/customize-install/#track-how-the-pwa-was-launched
  @JS("getLaunchMode")
  external void getLaunchMode();

  void setup() {
    // JavaScript code may now call `appLaunchedAsPWA()` or `window.appLaunchedAsPWA()`.
    _appLaunchedAsPWA = allowInterop(setLaunchModePWA);
    // JavaScript code may now call `appLaunchedInBrowser()` or `window.appLaunchedInBrowser()`.
    _appLaunchedInBrowser = allowInterop(setLaunchModeBrowser);
    // JavaScript code may now call `appLaunchedAsTWA()` or `window.appLaunchedAsTWA()`.
    _appLaunchedAsTWA = allowInterop(setLaunchModeTWA);
    getLaunchMode();
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
