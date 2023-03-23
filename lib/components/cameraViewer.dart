import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:roadvault_interview_sandbox/components/pictureViewer.dart';

class CameraViewer extends StatefulWidget {
  const CameraViewer({Key? key}) : super(key: key);

  @override
  State<CameraViewer> createState() => _CameraViewerState();
}

class _CameraViewerState extends State<CameraViewer> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  bool _initialized = false;

  Future<void> setupCameras() async {
    _cameras = await availableCameras();
    final controller =
        CameraController(_cameras[0], ResolutionPreset.ultraHigh);
    await controller.initialize();
    setState(() {
      _initialized = true;
      _controller = controller;
    });
  }

  Future<void> _takePicture() async {
    final XFile picture_xfile = await _controller.takePicture();
    print("THIS IS A PICTURE FILE, IT'S QUITE COOL" + picture_xfile.path);
    return;
  }

  @override
  void initState() {
    setupCameras();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
          height: screen.height,
          width: screen.width,
          decoration: BoxDecoration(color: Colors.black),
          child: _initialized
              ? CameraPreview(_controller)
              : const Text("Loading Camera")),
      Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: EdgeInsets.all(20),
              child: FloatingActionButton(
                  onPressed: () => _takePicture(),
                  child: const Icon(Icons.add_a_photo)))),
      Align(
          alignment: Alignment.bottomLeft,
          child: Padding(padding: EdgeInsets.all(20), child: PictureViewer()))
    ]);
  }
}
