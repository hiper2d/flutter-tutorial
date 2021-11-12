import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('loading screen')
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    Response resp = await get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
    Map data = jsonDecode(resp.body);
    print(data);
    print(data['title']);
  }
}
