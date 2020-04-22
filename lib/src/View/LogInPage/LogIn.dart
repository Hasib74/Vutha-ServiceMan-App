import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:ui' as ui;
import 'package:vuthaserviceman/src/Controller/LogInController.dart' as logIn_controller;


class LogIn extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogIn> {
  //var _name_controller = TextEditingController();
  // var _surName_controller = TextEditingController();
  var _number_controller = TextEditingController();
  var _password_controller = TextEditingController();

  // var _phone_controller = TextEditingController();

  bool _check_value = false;
  var country_code;
  var actualCode;
  var verificationId;

  void _value1Changed(bool value) => setState(() => _check_value = value);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,

            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: <Widget>[
                      Container(

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Image.asset("Img/piza.jpg"),

                            _title(),
                            _emailAndPasswordAndButton(),

                             loading ? _loading() : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget _emailAndPasswordAndButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _number_controller,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              prefixIcon: SizedBox(
                child: Center(
                  widthFactor: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text('+27', style: TextStyle(fontSize: 15)),
                  ),
                ),
              ),
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: '',
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _password_controller,
            decoration: new InputDecoration(
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: 'Password',
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        FlatButton(
          onPressed: () {
            /* setState(() {
              loading = true;
            });
            */

            //_number_controller,_password_controller,_scaffoldKey , context

            if (logIn_controller.logIn(_number_controller, _password_controller,
                _scaffoldKey, context , stopLoading)) {
              setState(() {
                loading = true;
              });
            } else {
              setState(() {
                loading = false;
              });
            }
          },
          child: new Container(
            margin: EdgeInsets.only(left: 0, right: 0),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(color: Colors.orange),
            child: Center(
              child: Text(
                "LogIn",
                style: TextStyle(
                    color: Color(0xffFDEBE3), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Log In",
        style: TextStyle(
            color: Color(0xff172E4B),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  _loading() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: SpinKitCircle(
          color: Colors.orange,
          size: 60,
        ),
      ),
    );
  }



  stopLoading(){

    setState(() {


      loading = false;

    });

  }

 /* AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: InkWell(
          onTap: () {
            routes.back(context);
          },
          child: new Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
    );
  }*/
}
