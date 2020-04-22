import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vuthaserviceman/src/Utils/Common.dart';
import 'package:vuthaserviceman/src/Controller/SharedPreferences.dart' as sp_controller;
import 'package:vuthaserviceman/src/Routes/Routs.dart' as routes;
import 'package:vuthaserviceman/src/View/HomePage/HomePage.dart';

bool logIn(_number_controller, _password_controller, _scaffoldKey, context ,Function stopLoading) {
  if (_number_controller.value.text.isEmpty &&
      _password_controller.value.text.isEmpty) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
          'Empty Fields !',
          style: TextStyle(color: Colors.red),
        )));

    return false;
  } else {
    //_sendCodeToPhoneNumber();

    logInWithNumberAndPassword("+27"+ _number_controller.value.text,
        _password_controller.value.text, context , stopLoading);

    return true;
  }
}


Future<void> logInWithNumberAndPassword(
    String number, String password, context ,stopLoading) async {


  print("Number iss  ${number}");

  await FirebaseDatabase.instance
      .reference()
      .child(ServiceMan)
      .child(number)
      .once()
      .then((value) {
    if (value.value != null) {

      print("Password   iss   ${value.value["Password"] }   and text password  ${password}");

      if (value.value["Password"].toString().endsWith(password) ) {
        sp_controller.fun_addLogInInfoToSharePrefarance(number).then((value) {
           user_number = number;

          /*  Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => MapActivity(
                    number: number,
                  )),
                  (Route<dynamic> route) => false);*/




          routes.routeAndRemovePreviousRoute(
              context,
              HomePage(
                number: number,
              ));
        });
      } else {

        stopLoading();

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Alert"),
                content: Text("You are not registared"),
              );
            });
      }
    }
  });
}