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
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () {
              print('Something');
            },
            icon: const Icon(
                Icons.airport_shuttle
            ),
            label: const Text('Hey'),
            style: ElevatedButton.styleFrom(primary: Colors.amber)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Text('click'),
        backgroundColor: Colors.grey,
      )
    );
  }
}
