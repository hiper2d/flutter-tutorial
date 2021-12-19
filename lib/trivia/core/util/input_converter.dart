import 'package:dartz/dartz.dart';
import 'package:flutter_test3/trivia/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInt(String str) {
    return Right(int.parse(str));
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({List<dynamic> properties = const []})
      : super(properties);
}
