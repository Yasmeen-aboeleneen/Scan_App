import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ColumnIcons extends StatelessWidget {
  const ColumnIcons({super.key});

  @override
  Widget build(BuildContext context) {
    File? xFile;
    

    final GlobalKey repaintBoundaryKey = GlobalKey();
    var h = MediaQuery.of(context).size.height;
    Future<void> saveImageToGallery() async {
      try {
        RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;

        var image = await boundary.toImage();
        ByteData? byteData =
            await image.toByteData(format: ImageByteFormat.png);
        byteData!.buffer.asUint8List();

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR Code saved to gallery')),
        );
      // ignore: empty_catches
      } catch (e) {
      }
    }

    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            try {
              RenderRepaintBoundary boundary =
                  repaintBoundaryKey.currentContext!.findRenderObject()
                      as RenderRepaintBoundary;

              var image = await boundary.toImage();
              ByteData? byteData =
                  await image.toByteData(format: ImageByteFormat.png);
              Uint8List pngBytes = byteData!.buffer.asUint8List();

              final appDir = await getApplicationDocumentsDirectory();
              var datetime = DateTime.now();

              xFile = await File('${appDir.path}/$datetime.png').create();
              await xFile?.writeAsBytes(pngBytes);

              await Share.shareXFiles(
                xFile!.path as List<XFile>,
                //  mimeTypes: ["image/png"],
                text: "Share the QR Code",
              );
            } catch (e) {
              return;
            }
          },
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
    ));
  }
}
