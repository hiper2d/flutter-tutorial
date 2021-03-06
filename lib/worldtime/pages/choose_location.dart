import 'package:flutter/material.dart';
import 'package:flutter_test3/worldtime/model/world_time_dto.dart';
import 'package:flutter_test3/worldtime/services/world_time_servie.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        elevation: 0,
        title: const Text('Choose a location'),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
          padding: const EdgeInsets.all(0.0),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(locations[index]);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          },
          itemCount: locations.length,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void updateTime(WorldTime dto) async {
    WorldTimeService worldTimeService = WorldTimeService();
    await worldTimeService.requestTime(dto);
    Navigator.pop(context, {
      'location': dto.location,
      'flag': dto.flag,
      'time': dto.time,
      'isDateTime': dto.isDayTime,
    });
  }
}
