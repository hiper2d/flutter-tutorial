import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test3/trivia/core/util/input_converter.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:mockito/annotations.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTriviaEvent, GetRandomNumberTriviaEvent, InputConverter])
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
      inputConverter: mockInputConverter
    );
  });

  test('', () {

  });
}