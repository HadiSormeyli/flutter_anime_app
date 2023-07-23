import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase.dart';
import '../../../data/model/anime/Anime.dart';
import '../../repo/anime_repository.dart';

class GetUpComingAnimeUseCase implements UseCase<Anime, NoParams> {
  final AnimeRepository animeRepository;

  GetUpComingAnimeUseCase({required this.animeRepository});

  @override
  Future<Either<Failure, Anime>> call(NoParams params) async {
    return await animeRepository.getUpComingAnime();
  }
}
