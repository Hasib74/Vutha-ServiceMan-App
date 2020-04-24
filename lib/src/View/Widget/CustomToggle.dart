import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuthaserviceman/src/Provider/WidgetProvider/CustomToggleButtonProvider.dart';

class CustomToggle extends StatefulWidget {
  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomToggleButtonProvider>(builder: (context, toggle, _) {
      return Card(
        elevation: 2,
        margin: EdgeInsets.only(top: 3, left: 6, right: 6),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: toggle.toggle ? _on(context) : _off(context),
        ),
      );
    });
  }

  _on(BuildContext context) {
    // final toggle = Provider.of<CustomToggleButtonProvider>(context);

    return Consumer<CustomToggleButtonProvider>(
        builder: (context, toggle, child) {
      return InkWell(
        onTap: () {
          toggle.changeToggle();
        },
        child: Container(
          width: 56,
          height: 20,
          decoration: BoxDecoration(
            //  color: Color(0xff2F419A),
            borderRadius: BorderRadius.all(Radius.circular(50)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xfffbb448), Color(0xfff7892b)]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "ON",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 1.0),
                child: Container(
                  width: 20,
                  height: 17,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  _off(BuildContext context) {
    var toggle = Provider.of<CustomToggleButtonProvider>(context);

    return InkWell(
      onTap: () {
        toggle.changeToggle();
      },
      child: Container(
        width: 56,
        height: 20,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xfffbb448), Color(0xfff7892b)]),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 1.0),
              child: Container(
                width: 20,
                height: 17,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "OFF  ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );

    /*  return Consumer<CustomToggleButtonProvider>(
        builder: (context, toggle, child) {
      return InkWell(


          toggle.changeToggle();
        },
        child: Container(
          width: 56,
          height: 20,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)]),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 1.0),
                child: Container(
                  width: 20,
                  height: 17,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  "OFF  ",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    });*/
  }
}
