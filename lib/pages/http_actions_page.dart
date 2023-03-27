import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

import '../components/navbar.dart';

class HttpActionsPage extends StatefulWidget {
  HttpActionsPage({Key? key}) : super(key: key);
  String? body;

  @override
  State<HttpActionsPage> createState() => _HttpActionsPageState();
}

class _HttpActionsPageState extends State<HttpActionsPage> {
  Future<String> _loadHttpData() async {
    if (widget.body != null) {
      return Future.value(widget.body);
    }
    final bacon = await http.get(Uri.parse(
        "https://baconipsum.com/api/?type=meat-and-filler&paras=8&format=text"));
    widget.body = bacon.body;
    return bacon.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(back: '/', forward: '/watch', title: "HTTP Request"),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: _loadHttpData(),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SpinKitDoubleBounce(
                  color: Colors.red,
                  size: 50.0,
                );
              } else {
                return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(snapshot.data ?? "No Data to Display"));
              }
            },
          ),
        ),
      ),
    );
  }
}
