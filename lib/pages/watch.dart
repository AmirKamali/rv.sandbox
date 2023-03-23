import 'package:flutter/material.dart';
import 'package:roadvault_interview_sandbox/components/cameraViewer.dart';
import 'package:roadvault_interview_sandbox/components/navbar.dart';

class Watch extends StatefulWidget {
  const Watch({Key? key}) : super(key: key);

  @override
  State<Watch> createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(back: '/record', forward: '/', title: "Camera"),
      body: CameraViewer(),
    );
  }
}
