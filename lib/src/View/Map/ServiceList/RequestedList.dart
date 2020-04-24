import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vuthaserviceman/src/Model/Service.dart';
import 'package:vuthaserviceman/src/Utils/Common.dart';
import 'package:vuthaserviceman/src/View/Map/ServiceList/Widget/ServiceListDesign.dart';
class RequestedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseDatabase.instance
            .reference()
            .child(Serve)
            .child(user_number)
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.data == null ||
              snapshot.data.snapshot.value == null) {
            return Center(
                child: Text(
                  "No Service Avilable ",
                  style: TextStyle(color: Colors.orange),
                ));
          } else {
            List<Service> _serviceList = new List();

            Map<dynamic, dynamic> _service =
                snapshot.data.snapshot.value;

            _service.forEach((key, value) {
              print("Keyyy  ${key}");

              print("Value  ${value}");

              if(value["status"]==null){
                _serviceList.add(new Service(
                    serviceKey: key,
                    userNumber: value["userNumber"],
                    userLat: value["lat"],
                    usterLan: value["lan"],
                    requestType: value["requestType"]));
              }


            });

            return ListView.builder(
                itemCount: _serviceList.length,
                itemBuilder: (context, index) {
                  return ServiceListDesign(
                    serviceList: _serviceList,
                    index: index,
                    isRequested: true,
                  );
                });
          }
        });


  }







}