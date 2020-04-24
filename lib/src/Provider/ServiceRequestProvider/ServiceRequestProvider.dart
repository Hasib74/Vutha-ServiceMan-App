import 'package:flutter/cupertino.dart';

class ServiceRequestProvider extends ChangeNotifier {
  var _tab;

  get tab => _tab;

  ServiceRequestProvider() {
    _tab = "active";
  }

  activeTab() {
    _tab = "active";

    notifyListeners();
  }

  requestTab() {
    _tab = "request";

    notifyListeners();
  }
}
