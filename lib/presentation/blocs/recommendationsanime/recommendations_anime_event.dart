import 'package:equatable/equatable.dart';

abstract class RecommendationsAnimeEvent extends Equatable {
  const RecommendationsAnimeEvent();
}

class LoadRecommendationsAnimeEvent extends RecommendationsAnimeEvent {
  const LoadRecommendationsAnimeEvent();

  @override
  List<Object> get props => [];
}
