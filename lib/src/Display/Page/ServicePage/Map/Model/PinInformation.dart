
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinInformation {
  Icon pinPath;
  Icon avatarPath;
  LatLng location;
  String locationName;
  Color labelColor;

  PinInformation({this.pinPath, this.avatarPath, this.location, this.locationName, this.labelColor});
}