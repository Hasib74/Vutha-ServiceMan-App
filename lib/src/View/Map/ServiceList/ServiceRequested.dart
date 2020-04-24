import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:vuthaserviceman/src/Model/Service.dart';
import 'package:vuthaserviceman/src/Provider/ServiceRequestProvider/ServiceRequestProvider.dart';
import 'package:vuthaserviceman/src/Utils/Common.dart';
import 'package:vuthaserviceman/src/View/Map/MapActivity.dart';
import 'package:vuthaserviceman/src/View/Map/ServiceList/ActiveList.dart';
import 'package:vuthaserviceman/src/View/Map/ServiceList/RequestedList.dart';
import 'package:vuthaserviceman/src/View/Map/ServiceList/Widget/Active.dart';
import 'package:vuthaserviceman/src/View/Map/ServiceList/Widget/Request.dart';
import 'package:vuthaserviceman/src/View/Widget/CustomToggle.dart';
import 'package:vuthaserviceman/src/View/Map/ServiceList/Widget/ServiceListDesign.dart';

class ServiceRequested extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<ServiceRequestProvider>(
        create: (_) => ServiceRequestProvider(),
        child: Scaffold(
          body: Column(
            children: <Widget>[
              TopBar(),
              ActiveAndRequestList(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded ActiveAndRequestList() {
    return Expanded(
              child: Consumer<ServiceRequestProvider>(
                  builder: (context,service,_){


                    if(service.tab=="active"){
                      return ActiveList();

                    }else {
                      return RequestedList();

                    }

                  }


              ),
            );
  }

  Container TopBar() {
    return Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 1.5, blurRadius: 1.5)
              ]),
              height: 100,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomToggle(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Active(),
                      Request(),
                    ],
                  ),
                ],
              ),
            );
  }
}
