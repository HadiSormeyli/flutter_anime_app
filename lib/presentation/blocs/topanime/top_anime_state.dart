import 'package:equatable/equatable.dart';

import '../../../data/model/anime/Data.dart';

abstract class TopAnimeState extends Equatable {
  const TopAnimeState();

  @override
  List<Object> get props => [];
}

class InitialTopAnimeState extends TopAnimeState {}

class LoadingTopAnimeState extends TopAnimeState {}

class LoadedTopAnimeState extends TopAnimeState {
  final List<Data> topAnimeList;

  const LoadedTopAnimeState({required this.topAnimeList});

  @override
  List<Object> get props => [topAnimeList];

  @override
  String toString() {
    return 'LoadedTopAnimeState{listArticles: ${topAnimeList[0].trailer!.url}}';
  }
}

class FailureTopAnimeState extends TopAnimeState {
  final String errorMessage;

  const FailureTopAnimeState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureTopAnimeState{errorMessage: $errorMessage}';
  }
}
