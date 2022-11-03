import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {

  int taps = 0;

  void increment(){
    taps++;
    notifyListeners();
  }

  void initialize() {}
}
