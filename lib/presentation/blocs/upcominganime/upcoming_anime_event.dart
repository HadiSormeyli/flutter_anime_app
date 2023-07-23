import 'package:equatable/equatable.dart';

abstract class UpComingAnimeEvent extends Equatable {
  const UpComingAnimeEvent();
}

class LoadUpComingAnimeEvent extends UpComingAnimeEvent {
  const LoadUpComingAnimeEvent();

  @override
  List<Object> get props => [];
}
