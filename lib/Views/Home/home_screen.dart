import 'package:flutter/material.dart';
import 'package:scan_app/Views/Home/Mobile/mobile_home_screen.dart';
import 'package:scan_app/Views/Widgets/Adaptive/adaptive_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        mobileLayout: (context) => const MobileHomeScreen(),
        tabletLayout: (context) => const SizedBox(),
        desktopLayout: (context) => const SizedBox(),
      ),
    );
  }
}
