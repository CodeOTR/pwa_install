import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@singleton
class FirebaseRefreshService with ReactiveServiceMixin {

  void refreshView(){
    notifyListeners();
  }
}