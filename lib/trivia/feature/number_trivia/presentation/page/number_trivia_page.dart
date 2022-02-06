import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            const SizedBox(height: 10),
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
              builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(message: 'Start searching!');
                } else if (state is Error) {
                  return MessageDisplay(message: state.message);
                } else if (state is Loading) {
                  return MessageDisplay(message: 'Loading...');
                } else if (state is Loaded) {
                  return MessageDisplay(message: state.trivia.text);
                } else {
                  return MessageDisplay(message: 'Ops...');
                }
              },
            ),
            const SizedBox(height: 20),
            Column(children: [
              const Placeholder(fallbackHeight: 40,),
              const SizedBox(height: 10,),
              Row(children: const [
                Expanded(child: Placeholder(fallbackHeight: 30,)),
                SizedBox(width: 10,),
                Expanded(child: Placeholder(fallbackHeight: 30,)),
              ])
            ],)
          ],),
        ),
      ),
    );
  }
}

class MessageDisplay extends StatelessWidget {
  String message;

  MessageDisplay({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Center(
          child: SingleChildScrollView(
            child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25),
            ),
          ),
        ),
    );
  }
}