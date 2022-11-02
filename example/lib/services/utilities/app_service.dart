import 'package:injectable/injectable.dart';

@singleton
class AppService {
  bool fullScreen = false;

  void setFullScreen(bool val){
    fullScreen = val;
  }
}