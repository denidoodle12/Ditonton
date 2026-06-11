import 'package:core/common/state_enum.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListInitial()) {
    on<FetchNowPlayingMovies>(_onFetchNowPlayingMovies);
    on<FetchPopularMovies>(_onFetchPopularMovies);
    on<FetchTopRatedMovies>(_onFetchTopRatedMovies);
  }

  /// Returns the current MovieListLoaded state, or creates a fresh one.
  MovieListLoaded _currentOrEmpty() {
    if (state is MovieListLoaded) {
      return state as MovieListLoaded;
    }
    return MovieListLoaded(
      nowPlayingMovies: [],
      popularMovies: [],
      topRatedMovies: [],
      nowPlayingState: RequestState.Empty,
      popularMoviesState: RequestState.Empty,
      topRatedMoviesState: RequestState.Empty,
    );
  }

  Future<void> _onFetchNowPlayingMovies(
    FetchNowPlayingMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(_currentOrEmpty().copyWith(nowPlayingState: RequestState.Loading));

    final result = await getNowPlayingMovies.execute();

    // Re-read state after await to avoid stale reference race condition
    result.fold(
      (failure) {
        emit(_currentOrEmpty().copyWith(
          nowPlayingState: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(_currentOrEmpty().copyWith(
          nowPlayingMovies: data,
          nowPlayingState: RequestState.Loaded,
        ));
      },
    );
  }

  Future<void> _onFetchPopularMovies(
    FetchPopularMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(_currentOrEmpty().copyWith(popularMoviesState: RequestState.Loading));

    final result = await getPopularMovies.execute();

    // Re-read state after await to avoid stale reference race condition
    result.fold(
      (failure) {
        emit(_currentOrEmpty().copyWith(
          popularMoviesState: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(_currentOrEmpty().copyWith(
          popularMovies: data,
          popularMoviesState: RequestState.Loaded,
        ));
      },
    );
  }

  Future<void> _onFetchTopRatedMovies(
    FetchTopRatedMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(
        _currentOrEmpty().copyWith(topRatedMoviesState: RequestState.Loading));

    final result = await getTopRatedMovies.execute();

    // Re-read state after await to avoid stale reference race condition
    result.fold(
      (failure) {
        emit(_currentOrEmpty().copyWith(
          topRatedMoviesState: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(_currentOrEmpty().copyWith(
          topRatedMovies: data,
          topRatedMoviesState: RequestState.Loaded,
        ));
      },
    );
  }
}
