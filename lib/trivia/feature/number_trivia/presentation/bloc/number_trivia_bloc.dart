import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test3/trivia/core/util/input_converter.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:meta/meta.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTriviaEvent concrete;
  final GetRandomNumberTriviaEvent random;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.concrete,
    required this.random,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetConcreteNumberTriviaEvent>((event, emit) async {
      final inputEither = inputConverter.stringToUnsignedInt(
          event.numberString);
      inputEither.fold(
              (failure) => emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
              (integer) {}
      );
    });
  }
}
