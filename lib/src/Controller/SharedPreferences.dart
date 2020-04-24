import 'package:shared_preferences/shared_preferences.dart';

Future<bool> fun_addLogInInfoToSharePrefarance(number) async {
  var data;

  SharedPreferences sp = await SharedPreferences.getInstance();

  await sp.setString("logIn", number).then((value) {
   // print("sp Value : ${value}");

    data = value;
  });

  return data;
}

Future<String> fun_readLogInInfo() async {
  SharedPreferences sp = await SharedPreferences.getInstance();

  return sp.getString("logIn");
}

logOut() async {
  SharedPreferences sp = await SharedPreferences.getInstance();

  return sp.remove("logIn");
}

setOnlineStatus(value) async {


  SharedPreferences sp = await SharedPreferences.getInstance();

   //sp.remove("IsOnline");

   sp.setBool("IsOnline", value).then((value) {
    //print("sp Value : ${value}");
  });
}

Future<bool> getOnlineStatus() async {
  SharedPreferences sp = await SharedPreferences.getInstance();

  return sp.getBool("IsOnline");
}
