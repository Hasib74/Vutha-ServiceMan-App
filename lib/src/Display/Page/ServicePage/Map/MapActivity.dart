import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:vuthaserviceman/src/Display/Page/ServicePage/Map/ApiService/MapApisIntregation.dart';

class MapActvity extends StatefulWidget {
  final userlat;

  final userLan;

  MapActvity({this.userLan, this.userlat});

  @override
  _MapActvityState createState() => _MapActvityState();
}

const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
const LatLng DEST_LOCATION = LatLng(37.335685, -122.0605916);

class _MapActvityState extends State<MapActvity> {
  Completer<GoogleMapController> _controller = Completer();

  // var geolocator = Geolocator();
  /* var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);*/

  GoogleMapsServices _googleMapsServices = new GoogleMapsServices();

  LocationData currentLocation;

//  StreamSubscription<Position> positionStream;

  Set<Marker> _markers = {};
  List<LatLng> _list_lat_lan = [];

  final Set<Polyline> _polyline = {};

  var distance = "0 km";
  var duration = "0 mins";

  var TAG = "TAG";
  Location location;

/*
  static final CameraPosition _kGooglePlex =
*/

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _list_lat_lan.clear();


    _markers.clear();

    //contollerDispose();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _markers.add(new Marker(
          infoWindow: new InfoWindow(title: "User"),
          markerId: MarkerId("userMarker"),
          position: LatLng(widget.userlat, widget.userLan),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueYellow)));

      _list_lat_lan.add(new LatLng(widget.userlat, widget.userLan));
    });

    location = new Location();

    location.onLocationChanged.listen((event) {


      //setState(() {
        currentLocation = event;

     // });

        print("${TAG}   Cureeeeeeeeeeeeeeeeeeeeeeeeeeeeeeent   ${currentLocation}");


        update();

    });




  }




  update(){

    updatePinOnMap();

    setState(() {
      if (_list_lat_lan[1] != null) {
        _list_lat_lan.removeAt(1);
      }

      _list_lat_lan.add(
          new LatLng(currentLocation.latitude, currentLocation.longitude));
    });

    sendRequest();

    GoogleMapsServices()
        .getDistance(
        LatLng(currentLocation.latitude, currentLocation.longitude),
        LatLng(widget.userlat, widget.userLan))
        .then((value) {
      setState(() {
        distance = value[0]["distance"]["text"];
        duration = value[0]["duration"]["text"];
      });
    });

  }

  CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {





    print("${TAG}   currrent location  $currentLocation");



    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationButtonEnabled: true,
            polylines: _polyline,
            markers: _markers,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: onMaCreated,
            myLocationEnabled: false,
            scrollGesturesEnabled: true,
            mapType: MapType.terrain,
            rotateGesturesEnabled: false,
            tiltGesturesEnabled: false,
            zoomGesturesEnabled: true,
          ),
          Positioned.fill(
            bottom: 15,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${distance}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${duration}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation

    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
   // setState(() {
      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      setState(() {
        _list_lat_lan
            .add(LatLng(currentLocation.latitude, currentLocation.longitude));

        _markers.removeWhere((m) => m.markerId.value == 'myLocation');
        _markers.add(Marker(
            markerId: MarkerId('myLocation'),
            onTap: () {},
            position: pinPosition, // updated position
            icon: BitmapDescriptor.defaultMarkerWithHue(10)));


      });





      CameraPosition cPosition = CameraPosition(
        zoom: 14,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
   // });
  }

  onMaCreated(GoogleMapController controller) {
    print("${TAG} Map Createdddddddddddd");
    _controller.complete(controller);
  }

  /* void getCurrentLocation() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      print("${TAG}   intitila Postion   ${value}");

      setState(() {
        _list_lat_lan.add(new LatLng(value.latitude, value.longitude));

        initialPosition = value;

        _markers.add(new Marker(
            infoWindow: InfoWindow(title: "My Location"),
            markerId: MarkerId("myLocation"),
            position: LatLng(value.latitude, value.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueYellow)));
      });
    });
  }
*/
  void createRoute(String encondedPoly) {
    setState(() {
      _polyline.add(Polyline(
          polylineId: PolylineId("${"poly"}"),
          width: 4,
          points: _convertToLatLng(_decodePoly(encondedPoly)),
          color: Colors.black));
    });
  }

  /* void moveCamera() async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(
            currentLocation.latitude,
            currentLocation.longitude,
          ),
          zoom: 14)),
    );
  }*/

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    print(lList.toString());
    return lList;
  }

  void sendRequest() async {
    // LatLng destination = LatLng(20.008751, 73.780037);

    String route = await _googleMapsServices.getRouteCoordinates(
        _list_lat_lan[0], _list_lat_lan[1]);

    // print("Routssssssssssssssss  ${route}");
    createRoute(route);
    //_addMarker(destination,"KTHM Collage");
  }


}
