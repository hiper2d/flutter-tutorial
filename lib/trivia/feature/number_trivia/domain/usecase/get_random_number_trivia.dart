import 'package:dartz/dartz.dart';
import 'package:flutter_test3/trivia/core/error/failure.dart';
import 'package:flutter_test3/trivia/core/usecase/use_case.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/repository/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {

  final NumberTriviaRepository repository;

  GetRandomNumberTrivia({required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call({required NoParams params}) async {
    return await repository.getRandomNumberTrivia();
  }
}