part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaState extends Equatable {

  const NumberTriviaState([List props = const <dynamic>[]]);

  @override
  List<Object> get props {
    return props;
  }
}

class NumberTriviaInitial extends NumberTriviaState {}
