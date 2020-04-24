import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vuthaserviceman/src/Model/NotificationData.dart';

class NotificationService {
  var base_url = "https://fcm.googleapis.com/fcm/send";
  var token =
      "AAAAzniTbRk:APA91bHzs9U0kFJQyRwSJVMyyCBVPon87qS8awSOdvqcNSCeOKUprEPVA8J3cAwrnVINfLNxJgObb0PY65KLShInfYU8-KBERYnLAm-88gHy9afFE5Bi8u-MnI32CHxSgbHsEz93VtTP";

  sendRequest(NotificationData notificationData) {
    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "key=${token}"
    };

    http
        .post(base_url,
            headers: header, body: jsonEncode(notificationData.toJson()))
        .then((value) {
      print(
          "Notification valueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee  ${value.body}");
    });
  }
}
