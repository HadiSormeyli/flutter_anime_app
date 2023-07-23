import 'package:equatable/equatable.dart';

abstract class TopAnimeEvent extends Equatable {
  const TopAnimeEvent();
}

class LoadTopAnimeEvent extends TopAnimeEvent {
  const LoadTopAnimeEvent();

  @override
  List<Object> get props => [];
}
