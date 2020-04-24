import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:vuthaserviceman/src/Provider/ServiceRequestProvider/ServiceRequestProvider.dart';

class Request extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceRequestProvider>(
      builder: (context, service, _) {
        return InkWell(
          onTap: () {
            service.requestTab();
          },
          child: service.tab == "request"
              ? Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      size: 20,
                      color: Colors.orange,
                    ),
                    Text(
                      " Request",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      size: 20,
                      color: Colors.black26,
                    ),
                    Text(
                      " Request",
                      style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
