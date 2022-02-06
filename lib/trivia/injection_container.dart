import 'package:flutter_test3/trivia/core/network/network_info.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/data/datasource/number_trivia_remote_datasource.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/domain/usecase/get_random_number_trivia.dart';
import 'package:flutter_test3/trivia/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/util/input_converter.dart';
import 'feature/number_trivia/data/datasource/number_trivia_local_datasource.dart';
import 'feature/number_trivia/data/repository/number_trivia_repository_impl.dart';
import 'feature/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
      () => NumberTriviaBloc(getConcreteTriviaUseCase: sl(), getRandomTriviaUseCase: sl(), inputConverter: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(repository: sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(repository: sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  //Data sources
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(() => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(() => NumberTriviaRemoteDataSourceImpl(client: sl()));

  // Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingletonAsync(() => SharedPreferences.getInstance());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
