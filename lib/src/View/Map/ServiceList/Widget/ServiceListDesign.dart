import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vuthaserviceman/src/Model/Service.dart';
import 'package:vuthaserviceman/src/Utils/Common.dart';
import 'package:vuthaserviceman/src/View/Map/MapActivity.dart';
import 'package:vuthaserviceman/src/Controller/ServiceListController.dart'
    as controller;

class ServiceListDesign extends StatelessWidget {
  List<Service> serviceList;
  var index;

  bool isRequested;

  ServiceListDesign({this.serviceList, this.index, this.isRequested});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(
            "Lat and lan   = ${serviceList[index].usterLan}   ,  ${serviceList[index].userLat}");

        !isRequested
            ? Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => MapActvity(
                      serviceKey: serviceList[index].serviceKey,
                      userLan: serviceList[index].usterLan,
                      userlat: serviceList[index].userLat,
                    )))
            : null;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 1)
          ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder(
                  future: FirebaseDatabase.instance
                      .reference()
                      .child("User")
                      .child(serviceList[index].userNumber)
                      .once(),
                  builder: (context, AsyncSnapshot data) {
                    if (data.data == null) {
                      return Container();
                    } else {
                      return Row(
                        children: <Widget>[
                          Text(
                            "${data.data.value["Name"]}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("  Waiting for  ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                          Text("${serviceList[index].requestType}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold))
                        ],
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Number : ",
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      " ${serviceList[index].userNumber}",
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Address :",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600)),
                    FutureBuilder(
                        future: getUserLocation(serviceList[index].userLat,
                            serviceList[index].usterLan),
                        builder: (context, data) {
                          if (data.data == null) {
                            return Container();
                          } else {
                            return Flexible(
                              child: Text("${data.data} "),
                            );
                          }
                        })
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                isRequested
                    ? Divider(
                        height: 1,
                      )
                    : Container(),
                isRequested
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => _showDialog(context, "accept"),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Accept",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    child:
                                        VerticalDivider(color: Colors.grey))),
                          ),
                          InkWell(
                            onTap: () => _showDialog(context, "decline"),
                            child: new Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Decline",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(context, type) async {
    await showDialog<String>(
      context: context,
      child: new CupertinoAlertDialog(
        content: Text(
          type == "accept" ? "You want to Accept ?" : " You want to Decline ?",
          style: TextStyle(
              color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                //////////////////////

                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text(
                'YES',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                //////////////////////

                Navigator.pop(context);

                type == "accept"
                    ? controller.accept(serviceList[index].serviceKey,serviceList[index].userNumber)
                    : controller.decline(serviceList[index].serviceKey,serviceList[index].userNumber);
              })
        ],
      ),
    );
  }
}
