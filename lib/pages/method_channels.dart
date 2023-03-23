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
  String _deviceName = 'Not Loaded';

  Future<void> _getDeviceName() async {
    String deviceName;

    try {
      final String result = await platform.invokeMethod('getDeviceName');
      deviceName = result;
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
                Padding(
                    padding: EdgeInsets.all(40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Device Name: ",
                            textAlign: TextAlign.right,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          _deviceName,
                          textAlign: TextAlign.right,
                        )
                      ],
                    )),
                ElevatedButton(
                  onPressed: () => _getDeviceName(),
                  child: const Text("Load Device Name"),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () => _addVoiceShortcut(),
                  child: const Text("Add Voice Shortcut"),
                ),
              ])),
    );
  }
}
