import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  int counter = 0;

  void getData() async {
    // simulate network request for a username
    String username = await Future.delayed(const Duration(seconds: 3), () => 'yoshi');
    String bio = await Future.delayed(const Duration(seconds: 2), () => 'vega, musician and egg collector');
    print('$username - $bio');
  }

  @override
  Widget build(BuildContext context) {
    print('build function run');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1), //Colors.blue[900],
        centerTitle: true,
        elevation: 0,
        title: const Text('Choose a location'),
      ),
      backgroundColor: const Color(0xFFEEEEEE), // Colors.grey[200]
      body: ElevatedButton(
        onPressed: () {
          setState(() => counter += 1);
        },
        child: Text('Counter is $counter'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('initState function run');
    getData();
    print('initState function ends');
  }
}
