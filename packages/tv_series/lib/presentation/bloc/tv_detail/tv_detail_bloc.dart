import 'package:core/common/state_enum.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_event.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetWatchListStatusTV getWatchListStatusTV;
  final SaveWatchlistTV saveWatchlistTV;
  final RemoveWatchlistTV removeWatchlistTV;

  TVDetailBloc({
    required this.getTVDetail,
    required this.getTVRecommendations,
    required this.getWatchListStatusTV,
    required this.saveWatchlistTV,
    required this.removeWatchlistTV,
  }) : super(TVDetailInitial()) {
    on<FetchTVDetail>(_onFetchTVDetail);
    on<AddTVWatchlist>(_onAddTVWatchlist);
    on<RemoveTVWatchlist>(_onRemoveTVWatchlist);
    on<LoadTVWatchlistStatus>(_onLoadTVWatchlistStatus);
  }

  Future<void> _onFetchTVDetail(
    FetchTVDetail event,
    Emitter<TVDetailState> emit,
  ) async {
    emit(TVDetailLoading());

    final detailResult = await getTVDetail.execute(event.id);
    final recommendationResult = await getTVRecommendations.execute(event.id);

    detailResult.fold(
      (failure) {
        emit(TVDetailError(failure.message));
      },
      (tv) {
        String recMessage = '';
        var recState = RequestState.Loading;
        var recommendations = <dynamic>[];

        recommendationResult.fold(
          (failure) {
            recState = RequestState.Error;
            recMessage = failure.message;
          },
          (tvs) {
            recState = RequestState.Loaded;
            recommendations = tvs;
          },
        );

        emit(TVDetailLoaded(
          tv: tv,
          recommendations: List.from(recommendations),
          recommendationState: recState,
          isAddedToWatchlist: false,
          message: recMessage,
        ));

        add(LoadTVWatchlistStatus(event.id));
      },
    );
  }

  Future<void> _onAddTVWatchlist(
    AddTVWatchlist event,
    Emitter<TVDetailState> emit,
  ) async {
    final result = await saveWatchlistTV.execute(event.tv);
    final current = state as TVDetailLoaded;

    result.fold(
      (failure) {
        emit(current.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) {
        emit(current.copyWith(watchlistMessage: successMessage));
      },
    );

    add(LoadTVWatchlistStatus(event.tv.id));
  }

  Future<void> _onRemoveTVWatchlist(
    RemoveTVWatchlist event,
    Emitter<TVDetailState> emit,
  ) async {
    final result = await removeWatchlistTV.execute(event.tv);
    final current = state as TVDetailLoaded;

    result.fold(
      (failure) {
        emit(current.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) {
        emit(current.copyWith(watchlistMessage: successMessage));
      },
    );

    add(LoadTVWatchlistStatus(event.tv.id));
  }

  Future<void> _onLoadTVWatchlistStatus(
    LoadTVWatchlistStatus event,
    Emitter<TVDetailState> emit,
  ) async {
    final result = await getWatchListStatusTV.execute(event.id);
    if (state is TVDetailLoaded) {
      emit((state as TVDetailLoaded).copyWith(isAddedToWatchlist: result));
    }
  }
}
