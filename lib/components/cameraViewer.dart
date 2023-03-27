import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'pictureViewer.dart';

class CameraViewer extends StatefulWidget with WidgetsBindingObserver {
  CameraController? _controller;
  XFile? pictureXfile;
  bool _initialized = false;
  CameraViewer({Key? key}) : super(key: key);
  late Function onNewCameraSelected;
  @override
  State<CameraViewer> createState() => _CameraViewerState();
  @override
  void didChangeAppLifecycleState(AppLifecycleState appState) {
    super.didChangeAppLifecycleState(appState);

    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    // Respond to App states
    if (appState == AppLifecycleState.inactive) {
      cameraController.dispose();
      _initialized = false;
    } else if (appState == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }
}

class _CameraViewerState extends State<CameraViewer> {
  late List<CameraDescription> _cameras;

  bool _isProcessing = false;

  @override
  void initState() {
    setupCameras();
    widget.onNewCameraSelected = () => {setupCameras()};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
          height: screen.height,
          width: screen.width,
          decoration: const BoxDecoration(color: Colors.black),
          child: widget._initialized
              ? CameraPreview(widget._controller!)
              : const Text("Loading Camera")),
      Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: FloatingActionButton(
                  onPressed: () async => _takePicture(),
                  child: const Icon(Icons.add_a_photo)))),
      Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
              padding: EdgeInsets.all(20),
              child: PictureViewer(widget.pictureXfile?.path))),
      _isProcessing
          ? const SpinKitDoubleBounce(
              color: Colors.red,
              size: 50.0,
            )
          : const SizedBox(
              height: 0,
              width: 0,
            )
    ]);
  }

  Future<void> setupCameras() async {
    _cameras = await availableCameras();
    widget._controller =
        CameraController(_cameras[0], ResolutionPreset.ultraHigh);
    await widget._controller?.initialize();
    setState(() {
      widget._initialized = true;
    });
  }

  Future<void> _takePicture() async {
    // avoid multiple taps
    if (_isProcessing) {
      return;
    }
    // Set state and trigger loading
    setState(() {
      _isProcessing = true;
    });
    widget.pictureXfile = await widget._controller?.takePicture();
    // Set state to ready to take the next picture
    setState(() {
      _isProcessing = false;
    });
    print("THIS IS A PICTURE FILE, IT'S QUITE COOL" +
        (widget.pictureXfile?.path ?? ""));
    return;
  }
}
