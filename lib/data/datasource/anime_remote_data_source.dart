import 'package:dio/dio.dart';

import '../model/anime/Anime.dart';
import '../model/recommendations/RecommendationAnime.dart';


abstract class AnimeRemoteDataSource {
  Future<Anime> getTopAnime();
  Future<RecommendationAnime> getRecommendationsAnime();
  Future<Anime> getUpComingAnime();
}

class AnimeRemoteDataSourceImpl implements AnimeRemoteDataSource {
  final Dio dio;

  AnimeRemoteDataSourceImpl({required this.dio});

  @override
  Future<Anime> getTopAnime() async {
    Response response = await dio.get(
      'v4/top/anime',
    );
    if (response.statusCode == 200) {
      return Anime.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  @override
  Future<RecommendationAnime> getRecommendationsAnime() async {
    Response response = await dio.get(
      'v4/recommendations/anime'
    );
    if (response.statusCode == 200) {
      return RecommendationAnime.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  @override
  Future<Anime> getUpComingAnime() async {
    Response response = await dio.get(
      'v4/seasons/upcoming',
      queryParameters: {
        'limit': '10',
      },
    );
    if (response.statusCode == 200) {
      return Anime.fromJson(response.data);
    } else {
      throw Exception();
    }
  }
}
