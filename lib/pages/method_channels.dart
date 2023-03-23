import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:roadvault_interview_sandbox/components/index.dart';

class MethodChannels extends StatefulWidget {
  const MethodChannels({Key? key}) : super(key: key);

  @override
  State<MethodChannels> createState() => _MethodChannelsState();
}

class _MethodChannelsState extends State<MethodChannels> {
  static const platform = MethodChannel('rv.interview.sandbox/device');
  String _deviceName = 'INVALID';

  Future<void> _getDeviceName() async {
    String deviceName;

    try {
      final String result = await platform.invokeMethod('getDeviceName');
      deviceName = 'Device Name:\n$result';
    } on PlatformException catch (e) {
      deviceName = "READ DEVICE NAME ERROR: ${e.message}.";
    } catch (e) {
      print(e);
      deviceName = "AN UNKNOWN ERROR OCCURRED.";
    }

    setState(() {
      _deviceName = deviceName;
    });
  }

  Future<void> _addVoiceShortcut() async {
    print("ADDING VOICE SHORTCUT");
    try {
      final String result = await platform.invokeMethod('addSiriShortcut');
      print(result);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const NavBar(
          back: '/watch', forward: '/record', title: 'Method Channels'),
      body: SizedBox(
          width: screen.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Home"),
                ElevatedButton(
                  onPressed: () => _getDeviceName(),
                  child: const Text("Load Device Name"),
                ),
                Text(_deviceName),
                ElevatedButton(
                  onPressed: () => _addVoiceShortcut(),
                  child: const Text("Add Voice Shortcut"),
                ),
              ])),
    );
  }
}
