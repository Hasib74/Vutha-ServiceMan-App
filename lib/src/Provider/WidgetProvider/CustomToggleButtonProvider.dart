import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:vuthaserviceman/src/Controller/SharedPreferences.dart'
    as sp_controller;
import 'package:vuthaserviceman/src/Controller/FirebaseController.dart'
    as fb_controller;

class CustomToggleButtonProvider with ChangeNotifier {
  bool _toggle = false;

  bool get toggle => _toggle;

  CustomToggleButtonProvider(var initial) {
    print(initial);

    if (initial != null && initial == "initial") {
      initialToggleButton();
    }

    notifyListeners();
  }

  void changeToggle() {
    if (_toggle) {
      _toggle = false;

      sp_controller.setOnlineStatus(false);

      //print("Falseeeeeeeeeeeeeeeeeeee");

      fb_controller.activeOperation(_toggle);

      notifyListeners();
    } else {
      _toggle = true;

      sp_controller.setOnlineStatus(true);

      //   print("trueeeeeeeeeeeeeeeeeeeeeeeeeeee");

      fb_controller.activeOperation(_toggle);

      notifyListeners();
    }
  }

  initialToggleButton() {
    sp_controller.getOnlineStatus().then((value) {
      print("The value iss  ${value}");

      if (value == null) {
        _toggle = true;
      } else {
        _toggle = value;
      }
    });

    fb_controller.activeOperation(_toggle);

    // notifyListeners();
  }
}
