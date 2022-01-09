import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test3/trivia/core/error/failures.dart';
import 'package:flutter_test3/trivia/core/usecase/use_case.dart';
import 'package:flutter_test3/trivia/core/util/input_converter.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/usecase/get_random_number_trivia.dart';
import 'package:meta/meta.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteTriviaUseCase;
  final GetRandomNumberTrivia getRandomTriviaUseCase;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteTriviaUseCase,
    required this.getRandomTriviaUseCase,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetConcreteNumberTriviaEvent>((event, emit) async {
      final inputEither = inputConverter.stringToUnsignedInt(event.numberString);
      inputEither.fold((failure) => emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
          (integer) async => getConcreteTrivia(emit, integer));
    });

    on<GetRandomNumberTriviaEvent>((event, emit) async {
      await getTrivia(emit, () => getRandomTriviaUseCase(params: NoParams()));
    });
  }

  Future<void> getConcreteTrivia(Emitter<NumberTriviaState> emit, int integer) async {
    await getTrivia(emit, () => getConcreteTriviaUseCase(params: Params(number: integer)));
  }

  Future<void> getTrivia(Emitter<NumberTriviaState> emit, Function func) async {
    emit(Loading());
    final triviaOrFailure = await func();
    emit(triviaOrFailure.fold(
      (failure) => Error(message: mapFailureToMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    ));
  }

  String mapFailureToMessage(Failure failure) {
    failure is ServerFailure ? SERVER_FAILURE_MESSAGE : CACHE_FAILURE_MESSAGE;
    switch(failure.runtimeType) {
        case ServerFailure:
          return SERVER_FAILURE_MESSAGE;
        case CacheFailure:
          return CACHE_FAILURE_MESSAGE;
        default:
          return 'Unexpected error';
    }
  }
}
