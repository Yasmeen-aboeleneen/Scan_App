import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:scan_app/Core/Constants/colors.dart';

import 'package:scan_app/Views/Home/Mobile/QRCode/generate_qr_code_screen.dart';
import 'package:scan_app/Views/Home/Mobile/QRCode/scan_barcode.dart';
import 'package:scan_app/Views/Widgets/custom_container.dart';

class ContainerBody extends StatelessWidget {
  const ContainerBody({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(h * .001),
      width: w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const GenerateQrCodeScreen());
                  },
                  child: const CustomContainer(
                      title: 'Generate QR Code',
                      icon: Icon(
                        Icons.qr_code,
                        color: kveryWhite,
                        size: 35,
                      )),
                ),
              ),
              SizedBox(
                width: w * .03,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const ScanBarcode());
                  },
                  child: const CustomContainer(
                      title: 'Scan Barcode',
                      icon: Icon(
                        Icons.qr_code_scanner_rounded,
                        color: kveryWhite,
                        size: 35,
                      )),
                ),
              )
            ],
          ),
          SizedBox(
            height: h * .05,
          ),
          SizedBox(
            height: h * .05,
          ),
        ],
      ),
    );
  }
}
