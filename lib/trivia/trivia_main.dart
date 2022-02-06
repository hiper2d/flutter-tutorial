import 'package:flutter/material.dart';

import 'feature/number_trivia/presentation/page/number_trivia_page.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NumberTriviaPage(),
    );
  }
}