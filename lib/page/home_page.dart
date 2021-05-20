import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Pal'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Text("Home Page (test)"),
      ),
    );
  }
}
