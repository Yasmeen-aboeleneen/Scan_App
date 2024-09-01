import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_app/Core/Constants/colors.dart';

class SplashBox extends StatelessWidget {
  const SplashBox({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    double fontSize = w * 0.3 < 100 ? w * 0.3 : 100;

    return Center(
      child: DefaultTextStyle(
        style: GoogleFonts.abhayaLibre(fontSize: fontSize, color: kPrimary),
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              ' SCAN ',
            ),
          ],
          isRepeatingAnimation: true,
        ),
      ),
    );
  }
}
