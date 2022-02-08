import 'package:flutter/material.dart';

class MovesPage extends StatefulWidget {
  const MovesPage({Key? key}) : super(key: key);

  @override
  _MovesPageState createState() => _MovesPageState();
}

class _MovesPageState extends State<MovesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("MOVES"),
      ),
    );
  }
}
