import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_app/Core/Constants/colors.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.text, required this.icon});
  final String text;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: h * .02, left: h * .04, right: h * .04),
      child: Container(
        height: h * .08,
        width: w * .5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: kPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text,
              style: GoogleFonts.abhayaLibre(
                  color: kveryWhite,
                  fontSize: w * .06,
                  fontWeight: FontWeight.w600),
            ),
            icon
          ],
        ),
      ),
    );
  }
}
