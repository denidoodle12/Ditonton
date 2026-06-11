import 'package:core/common/state_enum.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_event.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVListBloc extends Bloc<TVListEvent, TVListState> {
  final GetOnTheAirTV getOnTheAirTV;
  final GetPopularTV getPopularTV;
  final GetTopRatedTV getTopRatedTV;

  TVListBloc({
    required this.getOnTheAirTV,
    required this.getPopularTV,
    required this.getTopRatedTV,
  }) : super(TVListInitial()) {
    on<FetchOnTheAirTV>(_onFetchOnTheAirTV);
    on<FetchPopularTV>(_onFetchPopularTV);
    on<FetchTopRatedTV>(_onFetchTopRatedTV);
  }

  /// Returns the current TVListLoaded state, or creates a fresh one.
  TVListLoaded _currentOrEmpty() {
    if (state is TVListLoaded) {
      return state as TVListLoaded;
    }
    return TVListLoaded(
      onTheAirTv: [],
      popularTv: [],
      topRatedTv: [],
      onTheAirState: RequestState.Empty,
      popularTvState: RequestState.Empty,
      topRatedTvState: RequestState.Empty,
    );
  }

  Future<void> _onFetchOnTheAirTV(
    FetchOnTheAirTV event,
    Emitter<TVListState> emit,
  ) async {
    emit(_currentOrEmpty().copyWith(onTheAirState: RequestState.Loading));

    final result = await getOnTheAirTV.execute();

    // Re-read state after await to avoid stale reference race condition
    result.fold(
      (failure) {
        emit(_currentOrEmpty().copyWith(
          onTheAirState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvData) {
        emit(_currentOrEmpty().copyWith(
          onTheAirTv: tvData,
          onTheAirState: RequestState.Loaded,
        ));
      },
    );
  }

  Future<void> _onFetchPopularTV(
    FetchPopularTV event,
    Emitter<TVListState> emit,
  ) async {
    emit(_currentOrEmpty().copyWith(popularTvState: RequestState.Loading));

    final result = await getPopularTV.execute();

    // Re-read state after await to avoid stale reference race condition
    result.fold(
      (failure) {
        emit(_currentOrEmpty().copyWith(
          popularTvState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvData) {
        emit(_currentOrEmpty().copyWith(
          popularTv: tvData,
          popularTvState: RequestState.Loaded,
        ));
      },
    );
  }

  Future<void> _onFetchTopRatedTV(
    FetchTopRatedTV event,
    Emitter<TVListState> emit,
  ) async {
    emit(_currentOrEmpty().copyWith(topRatedTvState: RequestState.Loading));

    final result = await getTopRatedTV.execute();

    // Re-read state after await to avoid stale reference race condition
    result.fold(
      (failure) {
        emit(_currentOrEmpty().copyWith(
          topRatedTvState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvData) {
        emit(_currentOrEmpty().copyWith(
          topRatedTv: tvData,
          topRatedTvState: RequestState.Loaded,
        ));
      },
    );
  }
}
