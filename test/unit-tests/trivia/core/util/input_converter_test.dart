import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test3/trivia/core/util/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test('should return an integer when the string represents an unsigned integer', () async {
      const str = '123';
      final result = inputConverter.stringToUnsignedInt(str);
      expect(result, const Right(123));
    });

    test('should return Failure when the string is not an integer', () async {
      const str = '123.1';
      final result = inputConverter.stringToUnsignedInt(str);
      expect(result, const Left(InvalidInputFailure()));
    });

    test('should return a Failure when the string is a negative number', () async {
      const str = '-123';
      final result = inputConverter.stringToUnsignedInt(str);
      expect(result, const Left(InvalidInputFailure()));
    });
  });
}