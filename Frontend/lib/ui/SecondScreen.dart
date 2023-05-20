import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreen createState() => _SecondScreen();
}


class _SecondScreen extends  State<SecondScreen>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Text(
          'This is the second screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}