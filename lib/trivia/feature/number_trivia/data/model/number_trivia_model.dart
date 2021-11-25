import 'package:flutter_test3/trivia/feature/number_trivia/domain/entity/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {

  const NumberTriviaModel({required int number, required String text})
      : super(text: text, number: number);

  static fromJson(Map<String, dynamic> jsonMap) {
    return NumberTriviaModel(text: jsonMap['text'], number: (jsonMap['number'] as num).toInt());
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'number': number};
  }
}