import 'package:flutter/material.dart';
import 'package:pogo_world/pages/landing_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoGo World',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(title: 'Flutter Demo Home Page'),
    );
  }
}
