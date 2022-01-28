import 'package:flutter/material.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/pages/landing_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoGo World',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kcBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kcTransparentColor,
          elevation: 0.0,
        ),
      ),
      home: const LandingPage(),
    );
  }
}
