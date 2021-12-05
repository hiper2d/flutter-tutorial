import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test3/trivia/core/error/exceptions.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/datasource/number_trivia_remote_datasource.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late http.Client mockHttpClient;

  const tNumber = 1;
  final Uri uriConcrete = Uri.parse('${NumberTriviaRemoteDataSourceImpl.url}/$tNumber');
  final Uri uriRandom = Uri.parse('${NumberTriviaRemoteDataSourceImpl.url}/random');
  final triviaFromTestFile = fixture('trivia.json');
  final decodedTriviaFromTestFile = json.decode(triviaFromTestFile);
  final tNumberTriviaModel = NumberTriviaModel.fromJson(decodedTriviaFromTestFile);

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getConcreteNumberTrivia', () {
    test('''should perform a GET request on a URL with a number being
      the endpoint and with application/json header''', () async {
      setupMockHttpCallSuccess(mockHttpClient, uriConcrete);
      await dataSource.getConcreteNumberTrivia(tNumber);

      verify(mockHttpClient.get(uriConcrete,
          headers: NumberTriviaRemoteDataSourceImpl.headers));
    });

    test('should return NumberTrivia when the response code is 200', () async {
      setupMockHttpCallSuccess(mockHttpClient, uriConcrete);
      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw ServerException when the response is 404 or other',
        () async {
      setupMockHttpCallFailure404(mockHttpClient, uriConcrete);
      final call = dataSource.getConcreteNumberTrivia;

      expect(() => call(tNumber), throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    test('''should perform a GET request on a URL with a number being
      the endpoint and with application/json header''', () async {
      setupMockHttpCallSuccess(mockHttpClient, uriRandom);
      await dataSource.getRandomNumberTrivia();

      verify(mockHttpClient.get(uriRandom,
          headers: NumberTriviaRemoteDataSourceImpl.headers));
    });

    test('should return NumberTrivia when the response code is 200', () async {
      setupMockHttpCallSuccess(mockHttpClient, uriRandom);
      final result = await dataSource.getRandomNumberTrivia();

      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw ServerException when the response is 404 or other',
        () async {
      setupMockHttpCallFailure404(mockHttpClient, uriRandom);
      final call = dataSource.getRandomNumberTrivia;

      expect(() => call(), throwsA(isInstanceOf<ServerException>()));
    });
  });
}

void setupMockHttpCallFailure404(http.Client mockHttpClient, Uri uri) {
  when(mockHttpClient.get(uri, headers: anyNamed('headers')))
      .thenAnswer((_) async => http.Response('Something went wrong', 404));
}

void setupMockHttpCallSuccess(http.Client mockHttpClient, Uri uri) {
  when(mockHttpClient.get(uri, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('{"number": 1, "text": "Test"}', 200));
}
