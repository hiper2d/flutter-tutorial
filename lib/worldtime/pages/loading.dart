
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Padding(
        child: Text(time),
        padding: const EdgeInsets.all(50.0),
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
      time = worldTimeService.time;
    });
  }
}
