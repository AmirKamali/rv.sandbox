import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:roadvault_interview_sandbox/components/navbar.dart';

class HttpActions extends StatefulWidget {
  const HttpActions({Key? key}) : super(key: key);

  @override
  State<HttpActions> createState() => _HttpActionsState();
}

class _HttpActionsState extends State<HttpActions> {
  Future<String> _loadHttpData() async {
    final bacon = await http.get(Uri.parse(
        "https://baconipsum.com/api/?type=meat-and-filler&paras=8&format=text"));

    return bacon.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(back: '/', forward: '/watch', title: "HTTP Request"),
      body: Center(
        child: FutureBuilder(
          future: _loadHttpData(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            return Padding(
                padding: EdgeInsets.all(20),
                child: Text(snapshot.data ?? "No Data to Display"));
          },
        ),
      ),
    );
  }
}
