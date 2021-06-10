import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeModel extends ChangeNotifier {
  SharedPreferences sharedPreferences;
  // Map<String,String> _words;
  // HomeModel() {
  //   initSP();
  // }
  // initSP() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   loadData();
  // }
  // void loadData() {
  //   Map<String,String> spList = sharedPreferences.;
  //   if (spList != null) {
  //     _tasks = spList.map((item) => Task.fromMap(jsonDecode(item))).toList();
  //   }
  //   notifyListeners();
  // }
  

  double _openValue = 50.0;
  get openValue => _openValue;
  set openValue(value) {
    _openValue = value;
    notifyListeners();
  }

  bool _isOpening = false;
  get isOpening => _isOpening;
  set isOpening(value) {
    _isOpening = value;
    notifyListeners();
  }

  void openLiquidMenu(AnimationController controller) {
    print('Menu is opening..');
    isOpening = !isOpening;
    if (isOpening) {
      openValue = 80.0;
      controller.forward();
    } else {
      openValue = 50.0;
      controller.reset();
    }
    notifyListeners();
  }
}
