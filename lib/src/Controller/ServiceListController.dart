import 'package:firebase_database/firebase_database.dart';
import 'package:vuthaserviceman/src/Utils/Common.dart';
import 'package:vuthaserviceman/src/Controller/NotificationController.dart'
    as controller;

accept(key, userNumber) {
  controller.sendNotificationToAdmin("${userNumber} has decline the service request",
      "ACCEPT SERVICE REQUEST",  userNumber);

  controller.sendNotificationToUser("${userNumber} has decline the service request",
      "ACCEPT SERVICE REQUEST", userNumber);

  FirebaseDatabase.instance
      .reference()
      .child(Serve)
      .child(user_number)
      .child(key)
      .update({"status": "accept"});

  FirebaseDatabase.instance
      .reference()
      .child(HelpRequest)
      .child(userNumber)
      .remove();
}

decline(key, userNumber) {
  controller.sendNotificationToAdmin("${userNumber} has decline the service request",
      "DECLINE", userNumber);

  FirebaseDatabase.instance
      .reference()
      .child(Serve)
      .child(user_number)
      .child(key)
      .remove();

  FirebaseDatabase.instance
      .reference()
      .child(HelpRequest)
      .child(userNumber)
      .update({"status": "decline"});
}
