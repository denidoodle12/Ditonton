import 'package:tv_series/domain/usecases/get_tv_season_detail.dart';
import 'package:tv_series/presentation/bloc/tv_season_detail/tv_season_detail_event.dart';
import 'package:tv_series/presentation/bloc/tv_season_detail/tv_season_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVSeasonDetailBloc
    extends Bloc<TVSeasonDetailEvent, TVSeasonDetailState> {
  final GetTVSeasonDetail getTVSeasonDetail;

  TVSeasonDetailBloc({required this.getTVSeasonDetail})
      : super(TVSeasonDetailInitial()) {
    on<FetchTVSeasonDetail>(_onFetchTVSeasonDetail);
  }

  Future<void> _onFetchTVSeasonDetail(
    FetchTVSeasonDetail event,
    Emitter<TVSeasonDetailState> emit,
  ) async {
    emit(TVSeasonDetailLoading());

    final result =
        await getTVSeasonDetail.execute(event.tvId, event.seasonNumber);
    result.fold(
      (failure) {
        emit(TVSeasonDetailError(failure.message));
      },
      (data) {
        emit(TVSeasonDetailLoaded(data));
      },
    );
  }
}
