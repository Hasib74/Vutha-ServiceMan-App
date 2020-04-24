import 'package:geocoder/geocoder.dart';

var Serve = "Serve";
//var number= "+8801727123373";
var user_number;

var ServiceMan = "ServiceMan";
var HelpRequest = "HelpRequest";
var TOKEN = "Token";

var User = "User";

var Chat = "Chat";
var ADMIN = "Admin";

Future<String> getUserLocation(lat, lan) async {
  final coordinates = new Coordinates(lat, lan);
  var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var first = addresses.first;

  return '${first.addressLine}   ';
}
