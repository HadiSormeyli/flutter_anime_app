import 'package:equatable/equatable.dart';

import '../../../data/model/recommendations/Data.dart';


abstract class RecommendationsAnimeState extends Equatable {
  const RecommendationsAnimeState();

  @override
  List<Object> get props => [];
}

class InitialRecommendationsAnimeState extends RecommendationsAnimeState {}

class LoadingRecommendationsAnimeState extends RecommendationsAnimeState {}

class LoadedRecommendationsAnimeState extends RecommendationsAnimeState {
  final List<Data> recommendationsAnimeList;

  const LoadedRecommendationsAnimeState({required this.recommendationsAnimeList});

  @override
  List<Object> get props => [recommendationsAnimeList];

  @override
  String toString() {
    return 'LoadedRecommendationsAnimeState{listArticles: ${recommendationsAnimeList[0]}}';
  }
}

class FailureRecommendationsAnimeState extends RecommendationsAnimeState {
  final String errorMessage;

  const FailureRecommendationsAnimeState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureRecommendationsAnimeState{errorMessage: $errorMessage}';
  }
}
