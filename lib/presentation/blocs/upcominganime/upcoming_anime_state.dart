import 'package:equatable/equatable.dart';

import '../../../data/model/anime/Data.dart';

abstract class UpComingAnimeState extends Equatable {
  const UpComingAnimeState();

  @override
  List<Object> get props => [];
}

class InitialUpComingAnimeState extends UpComingAnimeState {}

class LoadingUpComingAnimeState extends UpComingAnimeState {}

class LoadedUpComingAnimeState extends UpComingAnimeState {
  final List<Data> upComingAnimeList;

  const LoadedUpComingAnimeState({required this.upComingAnimeList});

  @override
  List<Object> get props => [upComingAnimeList];

  @override
  String toString() {
    return 'LoadedUpComingAnimeState{listArticles: ${upComingAnimeList[0].trailer!.url}}';
  }
}

class FailureUpComingAnimeState extends UpComingAnimeState {
  final String errorMessage;

  const FailureUpComingAnimeState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureUpComingAnimeState{errorMessage: $errorMessage}';
  }
}
