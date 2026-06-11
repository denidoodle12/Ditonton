import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movies/top_rated_movies_event.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movies/top_rated_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({required this.getTopRatedMovies})
      : super(TopRatedMoviesInitial()) {
    on<FetchTopRatedMoviesList>(_onFetchTopRatedMoviesList);
  }

  Future<void> _onFetchTopRatedMoviesList(
    FetchTopRatedMoviesList event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    emit(TopRatedMoviesLoading());

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(TopRatedMoviesError(failure.message));
      },
      (data) {
        emit(TopRatedMoviesLoaded(data));
      },
    );
  }
}
