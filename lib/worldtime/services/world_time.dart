import 'dart:convert';

import 'package:http/http.dart';

class WorldTimeService {
  String location;
  late String time;
  String flag;
  String url;

  WorldTimeService({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    Response resp = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(resp.body);
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);
    // print(data);
    // print(datetime);
    // print(offset);

    DateTime now = DateTime.parse(datetime);
    now.add(Duration(hours: int.parse(offset)));

    time = now.toString();
  }
}