import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PictureViewer extends StatefulWidget {
  const PictureViewer({Key? key}) : super(key: key);

  @override
  State<PictureViewer> createState() => _PictureViewerState();
}

class _PictureViewerState extends State<PictureViewer> {
  String _imagePath = '';
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
        height: screen.height * 0.3,
        width: screen.width * 0.3,
        child: Image.file(File(_imagePath),
            errorBuilder: (context, obj, trace) => const Center(
                child: Text("No Image to Display",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors
                            .white)))) // HINT: The camera package returns a filepath to the picture taken.
        );
  }
}
