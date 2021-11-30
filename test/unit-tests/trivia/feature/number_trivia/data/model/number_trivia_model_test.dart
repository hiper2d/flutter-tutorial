import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/entity/number_trivia.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test');

  test('should be a subclass of NuberTrivia entity', () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });

    test('should return a valid model when the JSON number is a double', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing a proper data', () async {
      final result = tNumberTriviaModel.toJson();
      final expectedMap = {
        "text": "Test",
        "number": 1
      };
      expect(result, expectedMap);
    });
  });
}