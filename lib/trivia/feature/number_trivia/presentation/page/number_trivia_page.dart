import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: const Center(
        child: Text('Number Trivia Page'),
      ),
    );
  }
}