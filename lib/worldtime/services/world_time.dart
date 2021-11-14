import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTimeService {
  String location;
  String flag;
  String url;
  late String time;
  late bool isDayTime;

  WorldTimeService({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response resp = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(resp.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(data);
      // print(datetime);
      // print(offset);
      DateTime now = DateTime.parse(datetime);
      now.add(Duration(hours: int.parse(offset)));
      time = DateFormat.jm().format(now);
      isDayTime = now.hour > 6 && now.hour < 15 ? true : false;
    } catch (e) {
      time = 'could not get time';
      isDayTime = true; // make sure it is never null
      print('caused error: $e');
    }

  }
}