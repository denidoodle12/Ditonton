import 'package:core/common/state_enum.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailInitial()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
    on<AddMovieWatchlist>(_onAddMovieWatchlist);
    on<RemoveMovieWatchlist>(_onRemoveMovieWatchlist);
    on<LoadMovieWatchlistStatus>(_onLoadMovieWatchlistStatus);
  }

  Future<void> _onFetchMovieDetail(
    FetchMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());

    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult =
        await getMovieRecommendations.execute(event.id);

    detailResult.fold(
      (failure) {
        emit(MovieDetailError(failure.message));
      },
      (movie) {
        String recMessage = '';
        var recState = RequestState.Loading;
        var recommendations = <dynamic>[];

        recommendationResult.fold(
          (failure) {
            recState = RequestState.Error;
            recMessage = failure.message;
          },
          (movies) {
            recState = RequestState.Loaded;
            recommendations = movies;
          },
        );

        emit(MovieDetailLoaded(
          movie: movie,
          recommendations: List.from(recommendations),
          recommendationState: recState,
          isAddedToWatchlist: false,
          message: recMessage,
        ));

        add(LoadMovieWatchlistStatus(event.id));
      },
    );
  }

  Future<void> _onAddMovieWatchlist(
    AddMovieWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.movie);
    final current = state as MovieDetailLoaded;

    result.fold(
      (failure) {
        emit(current.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) {
        emit(current.copyWith(watchlistMessage: successMessage));
      },
    );

    add(LoadMovieWatchlistStatus(event.movie.id));
  }

  Future<void> _onRemoveMovieWatchlist(
    RemoveMovieWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.movie);
    final current = state as MovieDetailLoaded;

    result.fold(
      (failure) {
        emit(current.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) {
        emit(current.copyWith(watchlistMessage: successMessage));
      },
    );

    add(LoadMovieWatchlistStatus(event.movie.id));
  }

  Future<void> _onLoadMovieWatchlistStatus(
    LoadMovieWatchlistStatus event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await getWatchListStatus.execute(event.id);
    if (state is MovieDetailLoaded) {
      emit((state as MovieDetailLoaded)
          .copyWith(isAddedToWatchlist: result));
    }
  }
}
