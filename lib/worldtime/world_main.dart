import 'package:flutter/material.dart';
import 'package:flutter_test3/worldtime/pages/choose_location.dart';
import 'package:flutter_test3/worldtime/pages/home.dart';
import 'package:flutter_test3/worldtime/pages/loading.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const Loading(),
    '/home': (context) => const Home(),
    '/location': (context) => const ChooseLocation(),
  },
));