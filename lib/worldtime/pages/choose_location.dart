import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1), //Colors.blue[900],
        centerTitle: true,
        elevation: 0,
        title: const Text('Choose a location'),
      ),
      backgroundColor: const Color(0xFFEEEEEE), // Colors.grey[200]
      body: const Text('choose location screen'),
    );
  }
}
