import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scan_app/Core/Constants/colors.dart';
import 'package:share_plus/share_plus.dart';

class QrCode extends StatefulWidget {
  final String textdata;

  const QrCode({super.key, required this.textdata});

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  Color pickerColor = kDark;
  Color currentColor = kPrimary;
  final GlobalKey repaintBoundaryKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }

    Future showPicker() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: kdcolor,
          title: Center(
            child: Text(
              'Pick a color',
              style: GoogleFonts.abhayaLibre(
                color: kveryWhite,
                fontSize: w * .1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 88, 125, 117),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              child: Text(
                'Change',
                style: GoogleFonts.abhayaLibre(
                  fontSize: w * .05,
                  color: kveryWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Future<void> saveImageToGallery() async {
      try {
        await Future.delayed(const Duration(milliseconds: 100));
        RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;

        var image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData =
            await image.toByteData(format: ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        final result = await ImageGallerySaver.saveImage(
          pngBytes,
          quality: 100,
          name: "qr_code_${DateTime.now().millisecondsSinceEpoch}",
        );

        if (result['isSuccess'] ?? false) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('QR Code saved to gallery')),
          );
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save QR Code to gallery')),
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error saving image to gallery: ${e.toString()}');
        }
      }
    }

    Future<void> shareQrCode() async {
      try {
        await Future.delayed(const Duration(milliseconds: 100));
        RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;

        var image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData =
            await image.toByteData(format: ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        final appDir = await getApplicationDocumentsDirectory();
        final filePath =
            '${appDir.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png';
        final file = await File(filePath).create();
        await file.writeAsBytes(pngBytes);

        final XFile shareFile = XFile(file.path);

        await Share.shareXFiles([shareFile], text: "Share the QR Code");
      } catch (e) {
        if (kDebugMode) {
          print('Error sharing QR Code: ${e.toString()}');
        }
      }
    }

    return RepaintBoundary(
      key: repaintBoundaryKey,
      child: Container(
        height: h * .3,
        width: w,
        color: kveryWhite,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () => showPicker(),
                  icon: const Icon(
                    Icons.colorize_sharp,
                    color: kPrimary,
                    size: 30,
                  ),
                ),
              ),
              QrImageView(
                data: widget.textdata,
                // ignore: deprecated_member_use
                foregroundColor: currentColor,
                size: h * .3,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: shareQrCode,
                      icon: const Icon(
                        Icons.share,
                        color: Color.fromARGB(255, 88, 125, 117),
                      ),
                    ),
                    SizedBox(
                      height: h * .01,
                    ),
                    IconButton(
                      onPressed: saveImageToGallery,
                      icon: const Icon(
                        Icons.download,
                        color: Color.fromARGB(255, 88, 125, 117),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
