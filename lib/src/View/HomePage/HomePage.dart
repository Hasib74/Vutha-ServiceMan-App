import 'package:flutter/material.dart';
import 'package:vuthaserviceman/src/View/Map/ServiceList/ServiceRequested.dart';
import 'package:vuthaserviceman/src/Controller/NotificationController.dart'
    as notification_controller;

import 'package:vuthaserviceman/src/Controller/LocationController.dart'
    as location_controller;
import 'package:vuthaserviceman/src/View/Widget/CustomToggle.dart';

class HomePage extends StatefulWidget {
  var number;

  HomePage({this.number});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    location_controller.updateUserPostion();

    notification_controller.registerNotification();
    notification_controller.configLocalNotification();
    notification_controller.configureSelectNotificationSubject(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    notification_controller.selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Positioned(
                child: ClipPath(
                  clipper: TopWaveClipper(),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xfffbb448), Color(0xfff7892b)]),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: BottomClipper(),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xfffbb448), Color(0xfff7892b)]),
                    ),
                  ),
                ),
              ),
              _cards(context),
              _toggleButton(),
            ],
          ),
        ),
      ),
    );
  }

  _cards(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    _profile(),
                    SizedBox(
                      width: 14,
                    ),
                    _new_user(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    _payment(),
                    SizedBox(
                      width: 14,
                    ),
                    _location(context),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _profile() {
    return Expanded(
      flex: 1,
      child: Stack(
        children: <Widget>[
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 1.5, blurRadius: 1.5)
              ],
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.perm_identity,
                    color: Colors.orange,
                    size: 100,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _new_user() {
    return Expanded(
      flex: 1,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 1.5, blurRadius: 1.5)
          ],
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.recent_actors,
                color: Colors.orange,
                size: 100,
              ),
              Text(
                "History",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _payment() {
    return Expanded(
      flex: 1,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 1.5, blurRadius: 1.5)
          ],
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.payment,
                color: Colors.orange,
                size: 100,
              ),
              Text(
                "Payment",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _location(context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => ServiceRequested()));
        },
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, spreadRadius: 1.5, blurRadius: 1.5)
            ],
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.orange,
                  size: 100,
                ),
                Text(
                  "Service",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _toggleButton() {
    return Positioned(right: 10, top: 10, child: CustomToggle());
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();
    path.lineTo(0.0, size.height / 3);

    //creating first curver near bottom left corner
    var firstControlPoint = new Offset(size.width / 3, size.height);
    var firstEndPoint = new Offset(size.width, size.height);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    //creating second curver near center

    ///move to top right corner
    path.lineTo(size.width, 0.0);

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip

    return true;
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();

    path.lineTo(0.0, 0.0);

    /* var firstControlPoint = new Offset(size.width +30, size.height-100);
    var firstEndPoint = new Offset(size.width/10, size.height );

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);*/

    path.quadraticBezierTo(
        size.width / 2 + 50, size.height / 7, size.width - 20, size.height);

    path.lineTo(size.width, size.height);

    path.lineTo(0.0, size.height);

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip

    return true;
  }
}
