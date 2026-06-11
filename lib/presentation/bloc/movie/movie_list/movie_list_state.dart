import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListInitial extends MovieListState {}

class MovieListLoaded extends MovieListState {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final RequestState nowPlayingState;
  final RequestState popularMoviesState;
  final RequestState topRatedMoviesState;
  final String message;

  const MovieListLoaded({
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.nowPlayingState,
    required this.popularMoviesState,
    required this.topRatedMoviesState,
    this.message = '',
  });

  @override
  List<Object> get props => [
        nowPlayingMovies,
        popularMovies,
        topRatedMovies,
        nowPlayingState,
        popularMoviesState,
        topRatedMoviesState,
        message,
      ];

  MovieListLoaded copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    RequestState? nowPlayingState,
    RequestState? popularMoviesState,
    RequestState? topRatedMoviesState,
    String? message,
  }) {
    return MovieListLoaded(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularMoviesState: popularMoviesState ?? this.popularMoviesState,
      topRatedMoviesState: topRatedMoviesState ?? this.topRatedMoviesState,
      message: message ?? this.message,
    );
  }
}

class MovieListError extends MovieListState {
  final String message;

  const MovieListError(this.message);

  @override
  List<Object> get props => [message];
}
