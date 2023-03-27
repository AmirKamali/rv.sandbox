import 'package:flutter/material.dart';

import '../components/cameraViewer.dart';
import '../components/navbar.dart';

class WatchPage extends StatefulWidget {
  WatchPage({Key? key}) : super(key: key);
  var cameraViewer = CameraViewer();
  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(back: '/record', forward: '/', title: "Camera"),
      body: widget.cameraViewer,
    );
  }
}
