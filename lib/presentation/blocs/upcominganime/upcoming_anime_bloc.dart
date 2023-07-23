import 'package:bloc/bloc.dart';
import 'package:flutter_anime_app/presentation/blocs/upcominganime/upcoming_anime_event.dart';
import 'package:flutter_anime_app/presentation/blocs/upcominganime/upcoming_anime_state.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase.dart';
import '../../../domain/usecases/getupcominganime/upcoming_anime_use_case.dart';

class UpComingAnimeBloc extends Bloc<UpComingAnimeEvent, UpComingAnimeState> {
  final GetUpComingAnimeUseCase getUpComingAnimeUseCase;

  UpComingAnimeBloc(this.getUpComingAnimeUseCase)
      : super(InitialUpComingAnimeState()) {
    on<LoadUpComingAnimeEvent>((event, emit) async {
      emit(LoadingUpComingAnimeState());
      var response = await getUpComingAnimeUseCase(NoParams());
      emit(response.fold(
        (failure) {
          if (failure is ServerFailure) {
            return FailureUpComingAnimeState(
                errorMessage: failure.errorMessage);
          } else {
            return FailureUpComingAnimeState(errorMessage: failure.toString());
          }
        },
        (data) => LoadedUpComingAnimeState(upComingAnimeList: data.data ?? []),
      ));
    });
  }
}
