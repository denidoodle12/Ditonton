import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search/movie_search_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search/movie_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies}) : super(MovieSearchInitial()) {
    on<SearchMovieQuery>(_onSearchMovieQuery);
  }

  Future<void> _onSearchMovieQuery(
    SearchMovieQuery event,
    Emitter<MovieSearchState> emit,
  ) async {
    emit(MovieSearchLoading());

    final result = await searchMovies.execute(event.query);
    result.fold(
      (failure) {
        emit(MovieSearchError(failure.message));
      },
      (data) {
        emit(MovieSearchLoaded(data));
      },
    );
  }
}
