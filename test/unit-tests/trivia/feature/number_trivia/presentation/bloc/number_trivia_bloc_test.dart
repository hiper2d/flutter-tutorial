import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test3/trivia/core/util/input_converter.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks(
    [GetConcreteNumberTriviaEvent, GetRandomNumberTriviaEvent, InputConverter])
void main() {
  late GetConcreteNumberTriviaEvent mockGetConcreteNumberTriviaEvent;
  late GetRandomNumberTriviaEvent mockGetRandomNumberTriviaEvent;
  late InputConverter mockInputConverter;
  late NumberTriviaBloc bloc;

  setUp(() {
    mockGetConcreteNumberTriviaEvent = MockGetConcreteNumberTriviaEvent();
    mockGetRandomNumberTriviaEvent = MockGetRandomNumberTriviaEvent();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        concrete: mockGetConcreteNumberTriviaEvent,
        random: mockGetRandomNumberTriviaEvent,
        inputConverter: mockInputConverter);
  });

  test('initial test should be empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const iNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(number: 1, text: 'test');

    test(
        'should call the InputConverter to validate and convert string to unsigned int',
        () async {
      when(mockInputConverter.stringToUnsignedInt(tNumberString))
          .thenReturn(const Right(iNumberParsed));
      bloc.add(GetConcreteNumberTriviaEvent(numberString: tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInt(tNumberString));
      verify(mockInputConverter.stringToUnsignedInt(tNumberString));
    });
  });
}
