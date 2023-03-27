import 'dart:io';
import 'package:flutter/material.dart';

class PictureViewer extends StatefulWidget {
  String? _imagePath;
  PictureViewer(this._imagePath, {Key? key}) : super(key: key);

  @override
  State<PictureViewer> createState() => _PictureViewerState();
}

class _PictureViewerState extends State<PictureViewer> {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          height: screen.height * 0.3,
          width: screen.width * 0.3,
          child: widget._imagePath == null
              ? Container(
                  color: Colors.grey,
                )
              : Image.file(File(widget._imagePath!),
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, obj, trace) => const Center(
                      child: Text("No Image to Display",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors
                                  .white)))) // HINT: The camera package returns a filepath to the picture taken.
          ),
    );
  }
}
