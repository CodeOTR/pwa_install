import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  RemoteConfig? remoteConfig;

  /// Run at app launch
  Future<void> initializeRemoteConfig() async {
    remoteConfig = RemoteConfig.instance;

    /// Can change cache settings if necessary
    /*await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeoutMillis: 60000,
      minimumFetchIntervalMillis: 43200000,
    ));*/

    await remoteConfig?.setDefaults({'welcome_text': 'Hello!'});

    try {
      await remoteConfig?.fetch();
      await remoteConfig?.activate();
      print('remote config updated successfully');
    } catch(e){
      print('remote config error: '+ e.toString());
    }
  }

  String? getWelcomeText() {
    return remoteConfig?.getString('welcome_text');
  }
}