import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test3/trivia/core/error/exceptions.dart';
import 'package:flutter_test3/trivia/core/error/failures.dart';
import 'package:flutter_test3/trivia/core/platform/network_info.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/datasource/numer_trivia_local_datasource.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/datasource/numer_trivia_remote_datasource.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/repository/number_trivia_repository_impl.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([NumberTriviaRemoteDataSource, NumberTriviaLocalDataSource, NetworkInfo])
void main() {

  late MockNumberTriviaLocalDataSource localDataSource;
  late MockNumberTriviaRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late NumberTriviaRepositoryImpl repository;

  setUp(() {
    localDataSource = MockNumberTriviaLocalDataSource();
    remoteDataSource = MockNumberTriviaRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('deviceIsOnline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('deviceIsOffline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    const tNumberTriviaModel = NumberTriviaModel(number: tNumber, text: 'Test Trivia');
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if the device is connected', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getConcreteNumberTrivia(any)).thenAnswer((_) async => tNumberTriviaModel);
      repository.getConcreteNumberTrivia(tNumber);
      verify(networkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return the remote data when the call to remote data source is successful', () async {
        when(remoteDataSource.getConcreteNumberTrivia(any)).thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getConcreteNumberTrivia(tNumber);

        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(const Right(tNumberTrivia)));
      });

      test('should cache the data locally when the call to remote data source is successful', () async {
        when(remoteDataSource.getConcreteNumberTrivia(any)).thenAnswer((_) async => tNumberTriviaModel);
        await repository.getConcreteNumberTrivia(tNumber);

        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(localDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });

      test('should return server failure when the call to remote data source is unsuccessful', () async {
        when(remoteDataSource.getConcreteNumberTrivia(any)).thenThrow(ServerException());
        final result = await repository.getConcreteNumberTrivia(tNumber);

        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(localDataSource);
        expect(result, const Left(ServerFailure()));
      });
    });

    runTestsOffline(() {
      test('should return last locally cached data when the cache data is present', () async {
        when(localDataSource.getLastNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getConcreteNumberTrivia(tNumber);

        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTrivia)));
      });

      test('should return cache failure when the cache data is not present', () async {
        when(localDataSource.getLastNumberTrivia()).thenThrow(CacheException());
        final result = await repository.getConcreteNumberTrivia(tNumber);

        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(const Left(CacheFailure())));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(number: 123, text: 'Test Trivia');
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if the device is connected', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getRandomNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
      repository.getRandomNumberTrivia();
      verify(networkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return the remote data when the call to remote data source is successful', () async {
        when(remoteDataSource.getRandomNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getRandomNumberTrivia();

        verify(remoteDataSource.getRandomNumberTrivia());
        expect(result, equals(const Right(tNumberTrivia)));
      });

      test('should cache the data locally when the call to remote data source is successful', () async {
        when(remoteDataSource.getRandomNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
        await repository.getRandomNumberTrivia();

        verify(remoteDataSource.getRandomNumberTrivia());
        verify(localDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });

      test('should return server failure when the call to remote data source is unsuccessful', () async {
        when(remoteDataSource.getRandomNumberTrivia()).thenThrow(ServerException());
        final result = await repository.getRandomNumberTrivia();

        verify(remoteDataSource.getRandomNumberTrivia());
        verifyZeroInteractions(localDataSource);
        expect(result, const Left(ServerFailure()));
      });
    });

    runTestsOffline(() {
      test('should return last locally cached data when the cache data is present', () async {
        when(localDataSource.getLastNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getRandomNumberTrivia();

        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTrivia)));
      });

      test('should return cache failure when the cache data is not present', () async {
        when(localDataSource.getLastNumberTrivia()).thenThrow(CacheException());
        final result = await repository.getRandomNumberTrivia();

        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(const Left(CacheFailure())));
      });
    });
  });
}