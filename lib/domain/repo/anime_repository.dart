import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/model/anime/Anime.dart';
import '../../data/model/recommendations/RecommendationAnime.dart';

abstract class AnimeRepository {

  Future<Either<Failure, Anime>> getTopAnime();
  Future<Either<Failure, RecommendationAnime>> getRecommendationsAnime();
  Future<Either<Failure, Anime>> getUpComingAnime();
}