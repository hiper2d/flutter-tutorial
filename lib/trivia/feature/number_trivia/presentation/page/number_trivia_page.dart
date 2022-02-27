import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entity/number_trivia.dart';
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
          child: Column(
            children: [
              const SizedBox(height: 10),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  /*if (state is Empty) {
                  return const MessageDisplay(message: 'Start searching!');
                } else if (state is Error) {
                  return MessageDisplay(message: state.message);
                } else if (state is Loading) {
                  return const LoadingWidget();
                } else if (state is Loaded) {
                  return TriviaDisplay(numberTrivia: state.trivia);
                } else {
                  return const MessageDisplay(message: 'Ops...');
                }*/
                  return const TriviaDisplay(
                      numberTrivia: NumberTrivia(
                          number: 12,
                          text:
                              'adfjsdlkfs sdlfjsdlsdklf sdfksjdflsdjfsdklf sdfksjdflsdjfsdklf sdfksjdflsdjfsdklf sdfksjdflsdjffjsdklf sdfksjdflsdjfsdklf sdfksjdflsdjfsdklf sdfksjdflsdjfsdklf sdfksjdflsdjf'
                                  'lsdjf sdlfkjsdlkfj'));
                },
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Placeholder(
                    fallbackHeight: 40,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(children: const [
                    Expanded(
                        child: Placeholder(
                      fallbackHeight: 30,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Placeholder(
                      fallbackHeight: 30,
                    )),
                  ])
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const TriviaDisplay({
    Key? key,
    required this.numberTrivia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            Text(
              numberTrivia.number.toString(),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Text(
                    numberTrivia.text,
                    style: const TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
