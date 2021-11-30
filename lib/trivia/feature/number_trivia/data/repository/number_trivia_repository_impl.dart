import 'package:dartz/dartz.dart';
import 'package:flutter_test3/trivia/core/error/exceptions.dart';
import 'package:flutter_test3/trivia/core/error/failures.dart';
import 'package:flutter_test3/trivia/core/network/network_info.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/datasource/number_trivia_local_datasource.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/datasource/number_trivia_remote_datasource.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/repository/number_trivia_repository.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  NumberTriviaLocalDataSource localDataSource;
  NumberTriviaRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    return (await networkInfo.isConnected)
        ? await _getRemoteConcreteOrRandomData(getConcreteOrRandom)
        : await _getCachedData();
  }

  Future<Either<Failure, NumberTrivia>> _getRemoteConcreteOrRandomData(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    try {
      final remoteResult = await getConcreteOrRandom();
      localDataSource.cacheNumberTrivia(remoteResult);
      return Right(remoteResult);
    } on ServerException catch (e) {
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, NumberTrivia>> _getCachedData() async {
    try {
      final localResult = await localDataSource.getLastNumberTrivia();
      return Right(localResult);
    } on CacheException catch (e) {
      return const Left(CacheFailure());
    }
  }
}
