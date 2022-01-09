import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test3/trivia/core/error/failures.dart';
import 'package:flutter_test3/trivia/core/usecase/use_case.dart';
import 'package:flutter_test3/trivia/core/util/input_converter.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/usecase/get_random_number_trivia.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia, GetRandomNumberTrivia, InputConverter])
void main() {
  late GetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late GetRandomNumberTrivia mockGetRandomNumberTrivia;
  late InputConverter mockInputConverter;
  late NumberTriviaBloc bloc;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        getConcreteTriviaUseCase: mockGetConcreteNumberTrivia,
        getRandomTriviaUseCase: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initial test should be empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(number: 1, text: 'test');

    void setupMockInputConverterSuccess() {
      when(mockInputConverter.stringToUnsignedInt(tNumberString)).thenReturn(const Right(tNumberParsed));
    }

    test('should call the InputConverter to validate and convert string to unsigned int', () async {
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(params: const Params(number: tNumberParsed)))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      bloc.add(GetConcreteNumberTriviaEvent(numberString: tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInt(tNumberString));
      verify(mockInputConverter.stringToUnsignedInt(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () async {
      when(mockInputConverter.stringToUnsignedInt(tNumberString)).thenReturn(const Left(InvalidInputFailure()));

      expectLater(bloc.stream, emitsInOrder([Error(message: INVALID_INPUT_FAILURE_MESSAGE)]));
      bloc.add(GetConcreteNumberTriviaEvent(numberString: tNumberString));
    });

    test('should get the data from the concrete use case', () async {
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(params: const Params(number: tNumberParsed)))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      bloc.add(GetConcreteNumberTriviaEvent(numberString: tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(params: const Params(number: tNumberParsed)))
          .timeout(const Duration(seconds: 5));

      verify(mockGetConcreteNumberTrivia(params: const Params(number: tNumberParsed)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', () async {
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(params: const Params(number: tNumberParsed)))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      expectLater(bloc.stream, emitsInOrder([Loading(), Loaded(trivia: tNumberTrivia)]));
      bloc.add(GetConcreteNumberTriviaEvent(numberString: tNumberString));
    });

    test('should emit [Loading, Error] when getting data failed', () async {
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(params: const Params(number: tNumberParsed)))
          .thenAnswer((_) async => const Left(ServerFailure()));

      expectLater(bloc.stream, emitsInOrder([Loading(), Error(message: SERVER_FAILURE_MESSAGE)]));
      bloc.add(GetConcreteNumberTriviaEvent(numberString: tNumberString));
    });

    test('should emit [Loading, Error] with a proper message when getting data fails', () async {
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(params: const Params(number: tNumberParsed)))
          .thenAnswer((_) async => const Left(CacheFailure()));

      expectLater(bloc.stream, emitsInOrder([Loading(), Error(message: CACHE_FAILURE_MESSAGE)]));
      bloc.add(GetConcreteNumberTriviaEvent(numberString: tNumberString));
    });
  });

  group('GetTriviaForRandomNumber', () {
    const tNumberTrivia = NumberTrivia(number: 1, text: 'test');

    test('should get the data from the random use case', () async {
      when(mockGetRandomNumberTrivia(params: NoParams()))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      bloc.add(GetRandomNumberTriviaEvent());
      await untilCalled(mockGetRandomNumberTrivia(params: NoParams()))
          .timeout(const Duration(seconds: 5));

      verify(mockGetRandomNumberTrivia(params: NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', () async {
      when(mockGetRandomNumberTrivia(params: NoParams()))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      expectLater(bloc.stream, emitsInOrder([Loading(), Loaded(trivia: tNumberTrivia)]));
      bloc.add(GetRandomNumberTriviaEvent());
    });

    test('should emit [Loading, Error] when getting data failed', () async {
      when(mockGetRandomNumberTrivia(params: NoParams()))
          .thenAnswer((_) async => const Left(ServerFailure()));

      expectLater(bloc.stream, emitsInOrder([Loading(), Error(message: SERVER_FAILURE_MESSAGE)]));
      bloc.add(GetRandomNumberTriviaEvent());
    });

    test('should emit [Loading, Error] with a proper message when getting data fails', () async {
      when(mockGetRandomNumberTrivia(params: NoParams()))
          .thenAnswer((_) async => const Left(CacheFailure()));

      expectLater(bloc.stream, emitsInOrder([Loading(), Error(message: CACHE_FAILURE_MESSAGE)]));
      bloc.add(GetRandomNumberTriviaEvent());
    });
  });
}
