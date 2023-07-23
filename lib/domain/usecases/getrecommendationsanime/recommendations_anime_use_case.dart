import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase.dart';
import '../../../data/model/recommendations/RecommendationAnime.dart';
import '../../repo/anime_repository.dart';

class GetRecommendationsAnimeUseCase
    implements UseCase<RecommendationAnime, NoParams> {
  final AnimeRepository animeRepository;

  GetRecommendationsAnimeUseCase({required this.animeRepository});

  @override
  Future<Either<Failure, RecommendationAnime>> call(NoParams params) async {
    return await animeRepository.getRecommendationsAnime();
  }
}
