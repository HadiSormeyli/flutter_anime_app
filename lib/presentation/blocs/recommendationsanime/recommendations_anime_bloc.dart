import 'package:bloc/bloc.dart';
import 'package:flutter_anime_app/presentation/blocs/recommendationsanime/recommendations_anime_event.dart';
import 'package:flutter_anime_app/presentation/blocs/recommendationsanime/recommendations_anime_state.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase.dart';
import '../../../domain/usecases/getrecommendationsanime/recommendations_anime_use_case.dart';

class RecommendationsAnimeBloc extends Bloc<RecommendationsAnimeEvent, RecommendationsAnimeState> {
  final GetRecommendationsAnimeUseCase getRecommendationsAnimeUseCase;

  RecommendationsAnimeBloc(this.getRecommendationsAnimeUseCase) : super(InitialRecommendationsAnimeState()) {
    on<LoadRecommendationsAnimeEvent>((event, emit) async {
      emit(LoadingRecommendationsAnimeState());
      var response = await getRecommendationsAnimeUseCase(NoParams());
      emit(response.fold(
            (failure) {
          if (failure is ServerFailure) {
            return FailureRecommendationsAnimeState(errorMessage: failure.errorMessage);
          } else {
            return FailureRecommendationsAnimeState(errorMessage: failure.toString());
          }
        },
            (data) => LoadedRecommendationsAnimeState(recommendationsAnimeList: data.data?.sublist(0,10) ?? []),
      ));
    });
  }
}
