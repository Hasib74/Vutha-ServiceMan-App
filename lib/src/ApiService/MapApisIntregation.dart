import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "AIzaSyBmNnaj5IwYVLtMl81vxmIDePMcb-9v8ps";

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyBmNnaj5IwYVLtMl81vxmIDePMcb-9v8ps";

    // String url = "https://maps.googleapis.com/maps/api/directions/json?origin=23.7549085,90.3775628&destination=23.7549184,90.3741778&key=AIzaSyBmNnaj5IwYVLtMl81vxmIDePMcb-9v8ps";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }

  Future<List<dynamic>> getDistance(LatLng source, LatLng dastination) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${source.latitude},${source.longitude}&destination=${dastination.latitude},${dastination.longitude}&key=AIzaSyBmNnaj5IwYVLtMl81vxmIDePMcb-9v8ps";

    http.Response response = await http.get(url);

    Map values = jsonDecode(response.body);

    return values["routes"][0]["legs"];
  }
}

/*
*     String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyBmNnaj5IwYVLtMl81vxmIDePMcb-9v8ps";

* */
