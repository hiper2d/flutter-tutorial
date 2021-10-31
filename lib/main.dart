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
        title: const Text('Hey'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.cyan,
              padding: const EdgeInsets.all(30.0),
              child: const Text('1'),
            ),
            flex: 3,
          ),
          Expanded(
            child: Container(
              color: Colors.pinkAccent,
              padding: const EdgeInsets.all(30.0),
              child: const Text('2'),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              color: Colors.amber,
              padding: const EdgeInsets.all(30.0),
              child: const Text('3'),
            ),
            flex: 1,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Text('click'),
        backgroundColor: Colors.red,
      )
    );
  }
}
