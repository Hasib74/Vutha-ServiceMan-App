import 'package:flutter/material.dart';

normalRoute(context, page) {
  Navigator.of(context).push(new MaterialPageRoute(builder: (context) => page));
}

routeAndRemovePreviousRoute(context, page) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false);
}

void back(context) {
  Navigator.of(context).pop();
}
