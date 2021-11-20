import 'package:dartz/dartz.dart';
import 'package:flutter_test3/trivia/domain/entity/number_trivia.dart';
import 'package:flutter_test3/trivia/error/failure.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}