import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test3/worldtime/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'loading';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0D47A1), // Colors.blue[900]
      body: Center(
        child: SpinKitSpinningLines(
          color: Colors.white,
          size: 80.0,
        )
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  void setupWorldTime() async {
    WorldTimeService worldTimeService = WorldTimeService(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    await worldTimeService.getTime();
    print(worldTimeService.time);
    setState(() {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': worldTimeService.location,
        'flag': worldTimeService.flag,
        'time': worldTimeService.time,
      });
    });
  }
}
