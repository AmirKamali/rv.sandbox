import 'package:flutter/material.dart';
import 'package:roadvault_interview_sandbox/pages/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interview Sandbox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MethodChannels(),
        '/record': (context) => const HttpActions(),
        '/watch': (context) => const Watch(),
      },
    );
  }
}
