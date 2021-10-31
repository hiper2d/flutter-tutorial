import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Home(),
));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                backgroundImage: AssetImage('assets/thumb.jpeg'),
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
              'Chun-Li',
              style: TextStyle(
                color: Colors.amberAccent,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              )
            ),
            const SizedBox(height: 30.0),
            const Text(
              'CURRENT NINJA LEVEL',
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
                  'chun.li@ninjas.com',
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
