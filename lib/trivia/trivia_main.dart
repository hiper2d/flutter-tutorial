import 'package:flutter/material.dart';

import 'feature/number_trivia/presentation/page/number_trivia_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // this is needed for SharedPreferences initialization in di.init()
  await di.init();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NumberTriviaPage(),
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.green.shade800,
          secondary: Colors.green.shade600,
        ),
      ),
      title: 'Number Trivia',
    );
  }
}
