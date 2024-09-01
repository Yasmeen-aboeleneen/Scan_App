import 'package:flutter/material.dart';
import 'package:scan_app/Core/Constants/colors.dart';
import 'package:scan_app/Core/Utils/custom_app_bar.dart';
import 'package:scan_app/Views/Widgets/barcode_scanner.dart';

class ScanBarcode extends StatefulWidget {
  const ScanBarcode({super.key});

  @override
  State<ScanBarcode> createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kveryWhite,
        body: Column(
          children: [
            const CustomAppBar(text: 'Barcode Scanner'),
            SizedBox(
              height: h * .04,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: const [BarcodeScanner()],
              ),
            ),
            SizedBox(height: h * .02),
          ],
        ),
      ),
    );
  }
}
