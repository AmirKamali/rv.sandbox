import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../components/navbar.dart';

class MethodChannelsPage extends StatefulWidget {
  MethodChannelsPage({Key? key}) : super(key: key);
  String _deviceName = 'Not Loaded';

  @override
  State<MethodChannelsPage> createState() => _MethodChannelsPageState();
}

class _MethodChannelsPageState extends State<MethodChannelsPage> {
  static const platform = MethodChannel('rv.interview.sandbox/device');
  void navigateToPage(String page) {
    print("navigating to $page");
    Navigator.of(context).pushNamed(page);
  }

  _MethodChannelsPageState() {
    platform.setMethodCallHandler((methodCall) {
      print('NATIVE CALL...');
      print(methodCall.method + '(' + methodCall.arguments + ')');
      switch (methodCall.method) {
        case "navigate":
          navigateToPage(methodCall.arguments);
          break;
        default:
          break;
      }
      return Future.value(true);
    });
  }

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
      widget._deviceName = deviceName;
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
                ElevatedButton(
                  onPressed: () => _getDeviceName(),
                  child: const Text("Load Device Name"),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Device Name: ",
                            textAlign: TextAlign.right,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          widget._deviceName,
                          textAlign: TextAlign.right,
                        )
                      ],
                    )),
                const SizedBox(height: 150),
                ElevatedButton(
                  onPressed: () => _addVoiceShortcut(),
                  child: const Text("Add Siri Shortcut"),
                ),
              ])),
    );
  }
}
