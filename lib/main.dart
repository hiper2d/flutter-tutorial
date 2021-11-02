import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Home(),
));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ID Card'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/snuffy.jpeg'),
                radius: 40.0,
              )
            ),
            const Divider(
              height: 60.0,
              color: Color(0xFF424242), // grey[800],
            ),
            const Text(
              'NAME',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              )
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Snuffy',
              style: TextStyle(
                color: Colors.amberAccent,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              )
            ),
            const SizedBox(height: 30.0),
            const Text(
              'CURRENT SEAL LEVEL',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              )
            ),
            const SizedBox(height: 10.0),
            const Text(
              '8',
              style: TextStyle(
                color: Colors.amberAccent,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              )
            ),
            const SizedBox(height: 30.0),
            Row(
              children: const [
                Icon(
                  Icons.email,
                  color: Color(0xFFBDBDBD), // grey[400]
                ),
                SizedBox(width: 10.0),
                Text(
                  'snuffy@seal.com',
                  style: TextStyle(
                    color: Color(0xFFBDBDBD), // grey[400]
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      )
    );
  }
}
