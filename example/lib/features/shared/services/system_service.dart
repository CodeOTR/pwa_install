import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SystemService {

  Future<bool> connected() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else  {
      return false;
    }
  }

  double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  String screenType(BuildContext context){
    if(screenWidth(context) > 1500){
      return 'large';
    } if (screenWidth(context) <= 1500 && screenWidth(context) > 800) {
      return 'medium';
    }  else{
      return 'small';
    }
  }

  int gridCount(BuildContext context){
    if(screenWidth(context) > 1500){
      return 3;
    } if (screenWidth(context) <= 1500 && screenWidth(context) > 800) {
      return 2;
    }  else{
      return 1;
    }
  }

  /// Return device info for Android devices
  Future<AndroidDeviceInfo> getAndroidDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    return androidInfo;
  }

  /// Return device info for iOS devices
  Future<IosDeviceInfo> getIOSDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    return iosInfo;
  }

  Future<PackageInfo> getPackageInfo() async {
    /*PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
    });*/

    return await PackageInfo.fromPlatform();
  }

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool isUrlValid(String url){
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

 /* Future<void> launchEmail(EmailTemplate email) async {
    String version;
    String buildNumber;
    String? os;
    String? osVersion;
    String? device;

    PackageInfo packageInfo = await systemService.getPackageInfo();

    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceInfo = await systemService.getAndroidDeviceInfo();

      device = deviceInfo.device;
      osVersion = deviceInfo.version.release;
      os = deviceInfo.version.baseOS;
    } else if (Platform.isIOS) {
      IosDeviceInfo deviceInfo = await systemService.getIOSDeviceInfo();

      device = deviceInfo.name;
      osVersion = deviceInfo.systemVersion;
      os = deviceInfo.systemName;
    }

    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'fitjodevelopers@gmail.com',
      queryParameters: {
        'subject': 'FitJo%20-%20${email.type}',
        'body':
        'User:%20${userService.uid}\nFitJo%20Version:%20$version\nFitJo%20Build%20Number:%20$buildNumber\nOS:%20$os\nVersion%20Number:%20${osVersion ?? 'None'}\nPhone%20Model:%20${device ?? 'None'}\n%0D%0A${email.type}:\n'
      },
    );

    launch(Uri.decodeFull(_emailLaunchUri.toString()));
  }*/
}
