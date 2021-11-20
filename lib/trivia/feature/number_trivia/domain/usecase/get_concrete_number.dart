import 'package:dartz/dartz.dart';
import 'package:flutter_test3/trivia/error/failure.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/repository/number_trivia_repository.dart';

class GetConcreteNumberTrivia {

  final NumberTriviaRepository repository;

  const GetConcreteNumberTrivia({required this.repository});

  Future<Either<Failure, NumberTrivia>> execute({required int number}) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}