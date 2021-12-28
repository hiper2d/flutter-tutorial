part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  final List<dynamic> properties;

  const NumberTriviaEvent({this.properties = const []});

  @override
  List<dynamic> get props => properties;
}

class GetConcreteNumberTriviaEvent extends NumberTriviaEvent {
  final String numberString;

  GetConcreteNumberTriviaEvent({required this.numberString})
      : super(properties: [numberString]);

  get number => int.parse(numberString);
}

class GetRandomNumberTriviaEvent extends NumberTriviaEvent {}
