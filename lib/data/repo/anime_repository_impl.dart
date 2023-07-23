import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/error/failure.dart';
import '../../domain/repo/anime_repository.dart';
import '../datasource/anime_remote_data_source.dart';
import '../model/anime/Anime.dart';
import '../model/recommendations/RecommendationAnime.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final AnimeRemoteDataSource animeRemoteDataSource;

  AnimeRepositoryImpl({
    required this.animeRemoteDataSource,
  });

  @override
  Future<Either<Failure, Anime>> getTopAnime() async {
    try {
      var response = await animeRemoteDataSource.getTopAnime();
      return Right(response);
    } on DioError catch (error) {
      return Left(ServerFailure(error.message!));
    }
  }

  @override
  Future<Either<Failure, RecommendationAnime>> getRecommendationsAnime() async {
    try {
      var response = await animeRemoteDataSource.getRecommendationsAnime();
      return Right(response);
    } on DioError catch (error) {
      return Left(ServerFailure(error.message!));
    }
  }

  @override
  Future<Either<Failure, Anime>> getUpComingAnime() async {
    try {
      var response = await animeRemoteDataSource.getUpComingAnime();
      return Right(response);
    } on DioError catch (error) {
      return Left(ServerFailure(error.message!));
    }
  }
}
