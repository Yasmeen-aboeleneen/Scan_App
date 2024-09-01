// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:scan_app/Core/Constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
  });
  final String buttonName;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: w * .08, right: w * .08),
      padding: EdgeInsets.only(right: w * .06, left: w * .06),
      height: h * .06,
      width: w * .08,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: kPrimary),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          buttonName,
          style: GoogleFonts.abhayaLibre(
              color: kveryWhite,
              fontSize: w * .06,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
