// Mocks generated by Mockito 5.0.16 from annotations
// in flutter_test3/test/unit-tests/trivia/feature/number_trivia/presentation/bloc/number_trivia_bloc_test.dart.
// Do not manually edit this file.

import 'package:dartz/dartz.dart' as _i2;
import 'package:flutter_test3/trivia/core/error/failures.dart' as _i5;
import 'package:flutter_test3/trivia/core/util/input_converter.dart' as _i4;
import 'package:flutter_test3/trivia/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [GetConcreteNumberTriviaEvent].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetConcreteNumberTriviaEvent extends _i1.Mock
    implements _i3.GetConcreteNumberTriviaEvent {
  MockGetConcreteNumberTriviaEvent() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get numberString =>
      (super.noSuchMethod(Invocation.getter(#numberString), returnValue: '')
          as String);
  @override
  List<dynamic> get properties =>
      (super.noSuchMethod(Invocation.getter(#properties),
          returnValue: <dynamic>[]) as List<dynamic>);
  @override
  List<dynamic> get props =>
      (super.noSuchMethod(Invocation.getter(#props), returnValue: <dynamic>[])
          as List<dynamic>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetRandomNumberTriviaEvent].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRandomNumberTriviaEvent extends _i1.Mock
    implements _i3.GetRandomNumberTriviaEvent {
  MockGetRandomNumberTriviaEvent() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<dynamic> get properties =>
      (super.noSuchMethod(Invocation.getter(#properties),
          returnValue: <dynamic>[]) as List<dynamic>);
  @override
  List<dynamic> get props =>
      (super.noSuchMethod(Invocation.getter(#props), returnValue: <dynamic>[])
          as List<dynamic>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [InputConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockInputConverter extends _i1.Mock implements _i4.InputConverter {
  MockInputConverter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Either<_i5.Failure, int> stringToUnsignedInt(String? str) =>
      (super.noSuchMethod(Invocation.method(#stringToUnsignedInt, [str]),
              returnValue: _FakeEither_0<_i5.Failure, int>())
          as _i2.Either<_i5.Failure, int>);
  @override
  String toString() => super.toString();
}
