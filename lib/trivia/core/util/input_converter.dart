import 'package:dartz/dartz.dart';
import 'package:flutter_test3/trivia/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInt(String str) {
    try {
      final int converterInt = int.parse(str);
      if (converterInt < 0) throw const FormatException();
      return Right(converterInt);
    } on FormatException {
      return const Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure() : super();
}
