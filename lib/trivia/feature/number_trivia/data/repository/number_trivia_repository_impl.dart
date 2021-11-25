import 'package:dartz/dartz.dart';
import 'package:flutter_test3/trivia/core/error/exceptions.dart';
import 'package:flutter_test3/trivia/core/error/failures.dart';
import 'package:flutter_test3/trivia/core/platform/network_info.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/datasource/numer_trivia_local_datasource.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/datasource/numer_trivia_remote_datasource.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/repository/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {

  NumberTriviaLocalDataSource localDataSource;
  NumberTriviaRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async {
    return (await networkInfo.isConnected)
        ? await getRemoteConcreteData(number)
        : await getCachedData();
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return (await networkInfo.isConnected)
        ? await getRemoteRandomData()
        : await getCachedData();
  }

  Future<Either<Failure, NumberTrivia>> getRemoteConcreteData(int number) async {
    try {
      final remoteResult = await remoteDataSource.getConcreteNumberTrivia(number);
      localDataSource.cacheNumberTrivia(remoteResult);
      return Right(remoteResult);
    } on ServerException catch (e) {
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, NumberTrivia>> getRemoteRandomData() async {
    try {
      final remoteResult = await remoteDataSource.getRandomNumberTrivia();
      localDataSource.cacheNumberTrivia(remoteResult);
      return Right(remoteResult);
    } on ServerException catch (e) {
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, NumberTrivia>> getCachedData() async {
    try {
      final localResult = await localDataSource.getLastNumberTrivia();
      return Right(localResult);
    } on CacheException catch(e) {
      return const Left(CacheFailure());
    }
  }
}