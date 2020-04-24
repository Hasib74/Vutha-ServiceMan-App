class NotificationData {
  var to;

  var priority;

  Data data;

  NotificationData({this.data, this.priority, this.to});

  Map<String, dynamic> toJson() => {
        'to': to,
        'priority': "high",
        'data': {
          "click_action": data.click_action,
          "title": data.title,
          "body": data.body,
          "type": data.type
        },
        //'improvement': _improvement,
      };
}

class Data {
  var click_action;
  var title;
  var body;
  var type;

  Data({this.type, this.body, this.title, this.click_action});
}
