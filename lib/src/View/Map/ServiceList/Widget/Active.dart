import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:vuthaserviceman/src/Provider/ServiceRequestProvider/ServiceRequestProvider.dart';

class Active extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceRequestProvider>(
      builder: (context, service, child) {
        return InkWell(
          onTap: () {
            service.activeTab();
          },
          child: Row(
            children: [
              //Icon(Icons.playlist_add_check,size: 20,),
              service.tab == "active"
                  ? Icon(
                      Icons.location_on,
                      color: Colors.orange,
                    )
                  : Icon(
                      Icons.location_on,
                      color: Colors.black26,
                    ),
              service.tab == "active"
                  ? Text(
                      " Active",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Text(
                      " Active",
                      style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
            ],
          ),
        );
      },
    );
  }
}
