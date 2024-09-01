import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan_app/Core/Constants/colors.dart';
import 'package:scan_app/Core/Utils/custom_button.dart';
import 'package:scan_app/Views/Widgets/custom_app_bar.dart';
import 'package:scan_app/Views/Widgets/qr_code.dart';

class GenerateQrCodeScreen extends StatefulWidget {
  const GenerateQrCodeScreen({super.key});

  @override
  State<GenerateQrCodeScreen> createState() => _GenerateQrCodeScreenState();
}

class _GenerateQrCodeScreenState extends State<GenerateQrCodeScreen> {
  final key = GlobalKey();
  String textdata = 'http://androidride.com'; // Default value
  final textcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    requestPermissions(); // Request permissions on initialization
  }

  Future<void> requestPermissions() async {
    // Check if permission is granted
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // Request permission if not granted
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kveryWhite,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const CustomAppBar(
              text: 'QR Code Generator',
            ),
            SizedBox(
              height: h * .02,
            ),
            QrCode(textdata: textdata), // Pass the updated textdata
            Padding(
              padding: const EdgeInsets.all(4),
              child: TextField(
                maxLines: 5,
                controller: textcontroller,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimary, width: 2.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimary, width: 2.5),
                  ),
                  hintText: 'Enter Data Here',
                ),
              ),
            ),
            SizedBox(
              height: h * .04,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  textdata =
                      textcontroller.text; // Update textdata on button press
                });
              },
              child: const CustomButton(
                buttonName: 'Generate QR Code',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
