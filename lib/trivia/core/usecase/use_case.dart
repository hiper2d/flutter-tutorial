import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test3/trivia/core/error/failure.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call({required Params params});
}

class NoParams extends Equatable {

  @override
  List<Object> get props => [];
}