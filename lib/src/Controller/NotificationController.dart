import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vuthaserviceman/src/Model/NotificationData.dart';
import 'package:vuthaserviceman/src/Utils/Notification/NotificationService.dart';
import 'package:vuthaserviceman/src/View/Map/ServiceList/ServiceRequested.dart';
import 'package:vuthaserviceman/src/Routes/Routs.dart' as routes;
import 'package:vuthaserviceman/src/Utils/Common.dart';

FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

void registerNotification() {
  firebaseMessaging.requestNotificationPermissions();

  tokenUpdate();

  firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
    print('onMessage: $message');

    if (message["data"]["type"]
        .toString()
        .endsWith("serviceman") ) {
      showNotification(message['data']);
    }


    //onSelectNotification(message["data"]["click_action"]);

    return;
  }, onResume: (Map<String, dynamic> message) {
    print('onResume: $message');

    if (message["data"]["type"]
        .toString()
        .endsWith("serviceman") ) {
      showNotification(message['data']);
    }

    // onSelectNotification(message["data"]["click_action"]);

    return;
  }, onLaunch: (Map<String, dynamic> message) {
    print('onLaunch: $message');

    if (message["data"]["type"]
        .toString()
        .endsWith("serviceman") ) {
      showNotification(message['data']);
    }

    // onSelectNotification(message["data"]["click_action"]);

    return;
  });
}

void tokenUpdate() {
  firebaseMessaging.getToken().then((token) {
    print('token: $token');

    FirebaseDatabase.instance
        .reference()
        .child("Token")
        .child(ServiceMan)
        .child(user_number)
        .set({"token": token}).then((_) {
      print("Token Update");
    }).catchError((err) => print(err));
  }).catchError((err) {
    print(err);
  });
}

void configLocalNotification() {
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (value) {
    // print("Valueeeeeeeeeeeeeeeeeeeeeeeeee   ${value}");

    selectNotificationSubject.add(value);
  });
}

void showNotification(message) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    Platform.isAndroid
        ? 'com.monu.vuthaserviceman'
        : 'com.monu.vuthaserviceman',
    'Admin App',
    'your channel description',
    playSound: true,
    enableVibration: true,
    importance: Importance.Max,
    priority: Priority.High,
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      new Random().nextInt(20),
      message['title'].toString(),
      message['body'].toString(),
      platformChannelSpecifics,
      payload: json.encode(message));
}

void configureSelectNotificationSubject(context) {
  selectNotificationSubject.stream.listen((payload) async {
    print(
        "Poyload =========================================================   ${json.decode(payload)["click_action".toString()]}");

    onSelectNotification(
        json.decode(payload)["click_action"].toString(), context);
  });
}

Future<void> onSelectNotification(String payload, context) async {
  if (payload == "newRequest") {
    routes.normalRoute(context, ServiceRequested());
  }
}

void sendNotificationToUser(body, title,number) {
  //print("User Name   ${user.name}");

  FirebaseDatabase.instance
      .reference()
      .child(TOKEN)
      .child(User)
      .child(number)
      .once()
      .then((value) {
    NotificationData notificationData = new NotificationData(
        data: Data(
            type: "user",
            body: "${body}",
            title: "${title}",
            click_action: "newRequest"),
        to: value.value["token"]);

    NotificationService().sendRequest(notificationData);
  });
}

void sendNotificationToAdmin(body,title,number) {
  //print("User Name   ${user.name}");

  FirebaseDatabase.instance
      .reference()
      .child(TOKEN)
      .child(ADMIN)
/*      .child(number)*/
      .once()
      .then((value) {
    NotificationData notificationData = new NotificationData(
        data: Data(
            type: "admin",
            body: "${body}",
            title: "${title}",
            click_action: "newRequest"),
        to: value.value["token"]);

    NotificationService().sendRequest(notificationData);
  });
}
