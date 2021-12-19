import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  final List<dynamic> properties;

  const Failure(this.properties);

  @override
  List<dynamic> get props => properties;
}

class ServerFailure extends Failure {
  const ServerFailure({List<dynamic> properties = const []}) : super(properties);
}

class CacheFailure extends Failure {
  const CacheFailure({List<dynamic> properties = const []}) : super(properties);
}