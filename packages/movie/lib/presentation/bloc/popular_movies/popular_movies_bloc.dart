import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_event.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesBloc
    extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies})
      : super(PopularMoviesInitial()) {
    on<FetchPopularMoviesList>(_onFetchPopularMoviesList);
  }

  Future<void> _onFetchPopularMoviesList(
    FetchPopularMoviesList event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(PopularMoviesLoading());

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        emit(PopularMoviesError(failure.message));
      },
      (data) {
        emit(PopularMoviesLoaded(data));
      },
    );
  }
}
