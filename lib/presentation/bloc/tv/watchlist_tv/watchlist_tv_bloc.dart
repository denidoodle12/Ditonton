import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv/watchlist_tv_event.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv/watchlist_tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTVBloc extends Bloc<WatchlistTVEvent, WatchlistTVState> {
  final GetWatchlistTV getWatchlistTV;

  WatchlistTVBloc({required this.getWatchlistTV}) : super(WatchlistTVInitial()) {
    on<FetchWatchlistTV>(_onFetchWatchlistTV);
  }

  Future<void> _onFetchWatchlistTV(
    FetchWatchlistTV event,
    Emitter<WatchlistTVState> emit,
  ) async {
    emit(WatchlistTVLoading());

    final result = await getWatchlistTV.execute();
    result.fold(
      (failure) {
        emit(WatchlistTVError(failure.message));
      },
      (data) {
        emit(WatchlistTVLoaded(data));
      },
    );
  }
}
