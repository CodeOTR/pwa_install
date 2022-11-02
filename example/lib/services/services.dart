import 'package:get_it/get_it.dart';
import 'package:pwa_install_example_view/services/utilities/string_service.dart';
import 'package:pwa_install_example_view/services/utilities/system_service.dart';
import 'package:pwa_install_example_view/services/utilities/time_service.dart';
import 'package:pwa_install_example_view/services/utilities/toast_service.dart';

import 'utilities/app_service.dart';


AppService get appService {
  return GetIt.instance.get<AppService>();
}

FirebaseService get firebaseService {
  return GetIt.instance.get<FirebaseService>();
}

StringService get stringService {
  return GetIt.instance.get<StringService>();
}

SystemService get systemService {
  return GetIt.instance.get<SystemService>();
}

TimeService get timeService {
  return GetIt.instance.get<TimeService>();
}

ToastService get toastService {
  return GetIt.instance.get<ToastService>();
}
