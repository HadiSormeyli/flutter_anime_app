import 'package:dio/dio.dart';
import 'package:flutter_anime_app/constants/constants.dart';
import 'package:flutter_anime_app/data/datasource/anime_remote_data_source.dart';
import 'package:flutter_anime_app/data/repo/anime_repository_impl.dart';
import 'package:flutter_anime_app/domain/repo/anime_repository.dart';
import 'package:flutter_anime_app/domain/usecases/getrecommendationsanime/recommendations_anime_use_case.dart';
import 'package:flutter_anime_app/domain/usecases/gettopanime/top_anime_use_case.dart';
import 'package:flutter_anime_app/domain/usecases/getupcominganime/upcoming_anime_use_case.dart';
import 'package:flutter_anime_app/presentation/blocs/topanime/top_anime_bloc.dart';
import 'package:flutter_anime_app/presentation/blocs/upcominganime/upcoming_anime_bloc.dart';
import 'package:get_it/get_it.dart';

import '../presentation/blocs/recommendationsanime/recommendations_anime_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => TopAnimeBloc(sl()),
  );

  sl.registerFactory(
    () => RecommendationsAnimeBloc(sl()),
  );

  sl.registerFactory(
        () => UpComingAnimeBloc(sl()),
  );

  // Use Case
  sl.registerLazySingleton(() => GetTopAnimeUseCase(animeRepository: sl()));
  sl.registerLazySingleton(
      () => GetRecommendationsAnimeUseCase(animeRepository: sl()));
  sl.registerLazySingleton(() => GetUpComingAnimeUseCase(animeRepository: sl()));

  // Repository
  sl.registerLazySingleton<AnimeRepository>(
      () => AnimeRepositoryImpl(animeRemoteDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<AnimeRemoteDataSource>(
      () => AnimeRemoteDataSourceImpl(dio: sl()));

  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = Constants.base_url;
    return dio;
  });
}
