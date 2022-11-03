@JS()
library t;

import 'package:js/js.dart';

@JS("alertMessage")
external void alertMessage(dynamic message);

@JS("promptInstall")
external void promptInstall();