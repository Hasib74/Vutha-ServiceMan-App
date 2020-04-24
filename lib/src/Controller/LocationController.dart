import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:vuthaserviceman/src/Utils/Common.dart';



Location location;
/*update() {
  bg.BackgroundGeolocation.onLocation((bg.Location location) {
    FirebaseDatabase.instance
        .reference()
        .child(ServiceMan)
        .child(user_number)
        .child("location")
        .set({
      "lan": location.coords.longitude,
      "lat": location.coords.latitude,
    }).then((value) {
      print("Update the database ");
    });

    print('Locationnnnnnnnnnnnnn ${location.coords.latitude}');
  });

  // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
  bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
    print('[motionchange] - $location');
    FirebaseDatabase.instance
        .reference()
        .child(ServiceMan)
        .child(user_number)
        .child("location")
        .set({
      "lan": location.coords.longitude,
      "lat": location.coords.latitude,
    }).then((value) {
      print("Update the database ");
    });
  });

  // Fired whenever the state of location-services changes.  Always fired at boot
  bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
    print('[providerchange] - ${event}');
  });

  ////
  // 2.  Configure the plugin
  //
  bg.BackgroundGeolocation.ready(bg.Config(
          desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
          distanceFilter: 10.0,
          stopOnTerminate: false,
          startOnBoot: true,
          debug: true,
          logLevel: bg.Config.LOG_LEVEL_VERBOSE))
      .then((bg.State state) {
    if (!state.enabled) {
      ////
      // 3.  Start the plugin.
      //
      bg.BackgroundGeolocation.start();
    }
  });
}*/


updateUserPostion () {

  location = new Location();

  location.onLocationChanged.listen((event) {
    //setState(() {
  //  currentLocation = event;

    // });

    print(
        " Cureeeeeeeeeeeeeeeeeeeeeeeeeeeeeeent   ${event}");

  //  print("key = ${widget.serviceKey}");
    FirebaseDatabase.instance
        .reference()
        .child(ServiceMan)
        .child(user_number)
        //.child(widget.serviceKey)
        .update({

      "location":{

        "lat": event.latitude,
        "lan": event.longitude,
      }

    });

   ;
  });

}
