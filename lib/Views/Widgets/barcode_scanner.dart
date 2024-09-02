import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_app/Core/Constants/colors.dart';
import 'package:scan_app/Core/Utils/customIcon_Button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<BarcodeScanner> {
  String sdata = "No data found!";
  Color pickerColor = kDark;
  Color currentColor = kPrimary;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(h * .02),
      height: h * .7,
      width: w,
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Linkify(
              options: const LinkifyOptions(humanize: false),
              onOpen: (link) async {
                if (!await launchUrl(
                  Uri.parse(link.url),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception('Could not launch ${link.url}');
                }
              },
              text: sdata,
              style: TextStyle(
                color: currentColor,
                fontSize: w * .06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: h * .1,
          ),
          GestureDetector(
            onTap: _scanFromGallery,
            child: CustomIconButton(
              text: 'From Gallery',
              icon: Icon(
                Icons.photo,
                size: w * .1,
                color: kveryWhite,
              ),
            ),
          ),
          GestureDetector(
            onTap: _scanDirectly,
            child: CustomIconButton(
              text: 'Capture Image',
              icon: Icon(
                Icons.photo_camera,
                size: w * .1,
                color: kveryWhite,
              ),
            ),
          ),
          SizedBox(
            height: h * .05,
          ),
        ],
      ),
    );
  }

  Future<void> _scanDirectly() async {
    var data = await FlutterBarcodeScanner.scanBarcode(
        '#2A99CF', 'Cancel', true, ScanMode.QR);
    if (data != '-1') {
      setState(() {
        sdata = data.toString();
      });
    }
  }

  Future<void> _scanFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final inputImage = InputImage.fromFilePath(image.path);
        final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

        final List<Barcode> barcodes =
            await barcodeScanner.processImage(inputImage);

        if (barcodes.isNotEmpty) {
          setState(() {
            sdata = barcodes.map((barcode) => barcode.displayValue).join(', ');
          });
        } else {
          setState(() {
            sdata = "No barcode found in the image.";
          });
        }

        barcodeScanner.close();
      } else {
        setState(() {
          sdata = "No image selected!";
        });
      }
    } catch (e) {
      setState(() {
        sdata = "Failed to scan barcode: ${e.toString()}";
      });
      debugPrint("Exception while scanning from gallery: $e");
    }
  }

  Future<void> launch(String url) async {
    if (!await launchUrlString(url)) {
      throw 'Could not launch $url';
    }
  }
}
