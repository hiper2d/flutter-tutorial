import 'dart:convert';

import 'package:flutter_test3/worldtime/model/world_time_dto.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTimeService {

  Future<void> requestTime(WorldTime model) async {
    try {
      Response resp = await get(Uri.parse('https://worldtimeapi.org/api/timezone/${model.url}'));
      Map data = jsonDecode(resp.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      now.add(Duration(hours: int.parse(offset)));
      model.time = DateFormat.jm().format(now);
      model.isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch (e) {
      model.time = 'could not get time';
      model.isDayTime = true; // make sure it is never null
      print('caused error: $e');
    }
  }
}