part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {}

class GetTriviaForConcreteNumberEvent extends NumberTriviaEvent {

  final String numberString;

  GetTriviaForConcreteNumberEvent({required this.numberString});

  get number => int.parse(numberString);

  @override
  List<Object?> get props => [numberString];
}

class GetTriviaRandomNumberEvent extends NumberTriviaEvent {

  @override
  List<Object?> get props => [];
}