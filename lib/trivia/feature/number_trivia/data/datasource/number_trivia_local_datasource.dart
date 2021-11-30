import 'dart:convert';

import 'package:flutter_test3/trivia/core/error/exceptions.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  static const String cachedNumberTriviaKey = 'CACHED_NUMBER_TRIVIA';

  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences
        .getString(NumberTriviaLocalDataSource.cachedNumberTriviaKey);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
        NumberTriviaLocalDataSource.cachedNumberTriviaKey,
        json.encode(triviaToCache.toJson())
    );
  }
}
