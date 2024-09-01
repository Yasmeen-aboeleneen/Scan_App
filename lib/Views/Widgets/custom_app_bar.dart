// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:scan_app/Core/Constants/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      height: h * .15,
      width: w,
      decoration: const BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70),
          )),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.abhayaLibre(
              fontSize: w * .1, fontWeight: FontWeight.bold, color: kveryWhite),
        ),
      ),
    );
  }
}
