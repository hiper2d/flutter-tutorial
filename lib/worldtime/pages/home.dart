import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String bgImage = data['isDateTime'] ? 'day.png' : 'night.png';
    Color? bgColor = data['isDateTime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            child: Column(
              children: [
                TextButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDateTime': result['isDateTime'],
                          'flag': result['flag'],
                        };
                      });
                    },
                    icon: const Icon(
                      Icons.edit_location,
                      color: Color(0xFFE0E0E0), // Colors.grey[300]
                    ),
                    label: const Text(
                      'Edit Location',
                      style: TextStyle(color: Color(0xFFE0E0E0)), // Colors.grey[300]
                    ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                        data['location']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                        )
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                const SizedBox(height: 20),
                Text(
                  data['time']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 66.0,
                  )
                )
              ],
            ),
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          ),
        ),
      ),
    );
  }
}
