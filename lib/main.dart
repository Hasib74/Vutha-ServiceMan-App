import 'package:flutter/material.dart';
import 'package:vuthaserviceman/src/Utils/Common.dart';
import 'package:vuthaserviceman/src/View/HomePage/HomePage.dart';
import 'package:vuthaserviceman/src/RegistationAndLogInPage/loginPage.dart';
import 'package:vuthaserviceman/src/Controller/SharedPreferences.dart' as sp_controller;
import 'package:vuthaserviceman/src/View/LogInPage/LogIn.dart';
/*void main() {
  runApp(MaterialApp(home : HomePage()));
}*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  sp_controller.fun_readLogInInfo().then((value) {
    if (value != null) {
       user_number = value;

      print("Value  ${value} ");

      runApp(MaterialApp(
        home: HomePage(
          number: value,
        ),
      ));
    } else {
      runApp(MaterialApp(
        home: LogIn(),
      ));
    }
  });
}