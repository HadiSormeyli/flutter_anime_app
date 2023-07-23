import 'package:bloc/bloc.dart';
import 'package:flutter_anime_app/domain/usecases/gettopanime/top_anime_use_case.dart';
import 'package:flutter_anime_app/presentation/blocs/topanime/top_anime_event.dart';
import 'package:flutter_anime_app/presentation/blocs/topanime/top_anime_state.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase.dart';

class TopAnimeBloc extends Bloc<TopAnimeEvent, TopAnimeState> {
  final GetTopAnimeUseCase getTopAnimeUseCase;

  TopAnimeBloc(this.getTopAnimeUseCase) : super(InitialTopAnimeState()) {
    on<LoadTopAnimeEvent>((event, emit) async {
      emit(LoadingTopAnimeState());
      var response = await getTopAnimeUseCase(NoParams());
      emit(response.fold(
        (failure) {
          if (failure is ServerFailure) {
            return FailureTopAnimeState(errorMessage: failure.errorMessage);
          } else {
            return FailureTopAnimeState(errorMessage: failure.toString());
          }
        },
        (data) => LoadedTopAnimeState(
            topAnimeList: data.data!
                    .where((element) {
                      for (var genres in element.genres!) {
                        if (genres.name == "Action" &&
                            element.trailer != null &&
                            element.trailer!.youtubeId != null &&
                            element.year != null &&
                            element.year! > 2018) {
                          return true;
                        }
                      }
                      return false;
                    })
                    .toList()
                    .sublist(0, 3) ??
                []),
      ));
    });
  }
}
