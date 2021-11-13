import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> data = {};
    data = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          child: Column(
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/location');
                  },
                  icon: const Icon(Icons.edit_location),
                  label: const Text('Edit Location')),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                      data['location']!,
                      style: const TextStyle(fontSize: 28.0, letterSpacing: 2.0)
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              const SizedBox(height: 20),
              Text(
                data['time']!,
                style: const TextStyle(
                  fontSize: 60.0
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
