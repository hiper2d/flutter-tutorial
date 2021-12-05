import 'dart:convert';

import 'package:flutter_test3/trivia/core/error/exceptions.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl extends NumberTriviaRemoteDataSource {
  late http.Client client;
  static const url = 'http://numbersapi.com';
  static const headers = {'Content-Type': 'application/json'};

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return await _callForTrivia('$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return await _callForTrivia('random');
  }

  Future<dynamic> _callForTrivia(String urlEnding) async {
    http.Response r =
        await client.get(Uri.parse('$url/$urlEnding'), headers: headers);
    if (r.body.isEmpty || r.statusCode != 200) {
      throw ServerException();
    } else {
      return NumberTriviaModel.fromJson(json.decode(r.body));
    }
  }
}
