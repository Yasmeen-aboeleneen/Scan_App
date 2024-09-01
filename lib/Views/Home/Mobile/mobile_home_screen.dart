import 'package:flutter/material.dart';
import 'package:scan_app/Core/Constants/colors.dart';
import 'package:scan_app/Views/Widgets/container_body.dart';

class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: kveryWhite,
        body: Padding(
          padding: EdgeInsets.only(top: h * .01, left: h * .01, right: h * .01),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                height: h * .34,
                width: w,
                child: Image.asset(
                  'assets/pic.png',
                ),
              ),
              SizedBox(
                height: h * .08,
              ),
              const ContainerBody()
            ],
          ),
        ));
  }
}
