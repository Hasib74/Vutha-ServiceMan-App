import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vuthaserviceman/src/Display/Page/ServicePage/Map/MapActivity.dart';
import 'package:vuthaserviceman/src/Model/Service.dart';
import 'package:vuthaserviceman/src/Utils/Common.dart';

class ServiceRequested extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseDatabase.instance
              .reference()
              .child(Serve)
              .child(user_number)
              .onValue,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            } else {
              List<Service> _serviceList = new List();

              Map<dynamic, dynamic> _service = snapshot.data.snapshot.value;

              _service.forEach((key, value) {
                print("Keyyy  ${key}");

                print("Value  ${value}");

                _serviceList.add(new Service(


                    serviceKey: key,
                    userNumber: value["userNumber"],
                    userLat: value["lat"],
                    usterLan: value["lan"],
                    requestType: value["requestType"]));
              });

              return ListView.builder(
                  itemCount: _serviceList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print(
                            "Lat and lan   = ${_serviceList[index].usterLan}   ,  ${_serviceList[index].userLat}");

                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => MapActvity(
                                  serviceKey: _serviceList[index].serviceKey ,
                                  userLan: _serviceList[index].usterLan,
                                  userlat: _serviceList[index].userLat,


                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FutureBuilder(
                                  future: FirebaseDatabase.instance
                                      .reference()
                                      .child("User")
                                      .child(_serviceList[index].userNumber)
                                      .once(),
                                  builder: (context, AsyncSnapshot data) {
                                    if (data.data == null) {
                                      return Container();
                                    } else {
                                      return Row(
                                        children: <Widget>[
                                          Text("${data.data.value["Name"]}",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),),
                                          Text("  Waiting for  ",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500)),
                                          Text("${_serviceList[index].requestType}",style: TextStyle(color: Colors.red,fontSize: 17,fontWeight: FontWeight.bold))
                                        ],
                                      );
                                    }
                                  },
                                ),

                                SizedBox(height: 10,),

                                Text("Number : ${_serviceList[index].userNumber}",style: TextStyle(color: Colors.black54,fontSize: 17,fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
