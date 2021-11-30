import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test3/trivia/core/error/exceptions.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/datasource/number_trivia_local_datasource.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixture/fixture_reader.dart';
import 'number_trivia_local_data_source_impl_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late NumberTriviaLocalDataSourceImpl localDataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final a = fixture('trivia_cached.json');
    final tmp = json.decode(a);
    final tNumberTriviaModel = NumberTriviaModel.fromJson(tmp);

    test(
        'should return NumberTrivia from SharedPreferences when there is one one the cache',
        () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('trivia_cached.json'));
      final result = await localDataSource.getLastNumberTrivia();

      verify(mockSharedPreferences
          .getString(NumberTriviaLocalDataSource.cachedNumberTriviaKey));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw CacheException when there is no cached value', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      final result = localDataSource.getLastNumberTrivia;

      expect(() => result(), throwsA(isInstanceOf<CacheException>()));
    });
  });

  group('getLastNumberTrivia', () {
    const tNumberTriviaModel =
        NumberTriviaModel(number: 1, text: 'Test Trivia');

    test('should call SharedPreferences to cache the data', () async {
      when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);
      localDataSource.cacheNumberTrivia(tNumberTriviaModel);

      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(
          NumberTriviaLocalDataSource.cachedNumberTriviaKey,
          expectedJsonString
      ));
    });
  });
}
