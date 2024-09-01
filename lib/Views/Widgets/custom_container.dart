// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:scan_app/Core/Constants/colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      height: h * .2,
      width: w * .5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: kPrimary),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              textAlign: TextAlign.center,
              title,
              style: GoogleFonts.abhayaLibre(
                  color: kveryWhite,
                  fontSize: w * .08,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
