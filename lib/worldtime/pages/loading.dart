import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test3/worldtime/model/world_time_dto.dart';
import 'package:flutter_test3/worldtime/services/world_time_servie.dart';

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
      backgroundColor: Colors.blue,
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
    WorldTime dto = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    WorldTimeService worldTimeService = WorldTimeService();
    await worldTimeService.requestTime(dto);
    setState(() {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': dto.location,
        'flag': dto.flag,
        'time': dto.time,
        'isDateTime': dto.isDayTime,
      });
    });
  }
}
