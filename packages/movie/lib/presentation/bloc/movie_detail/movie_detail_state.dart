import 'package:core/common/state_enum.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final RequestState recommendationState;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final String message;

  const MovieDetailLoaded({
    required this.movie,
    required this.recommendations,
    required this.recommendationState,
    required this.isAddedToWatchlist,
    this.watchlistMessage = '',
    this.message = '',
  });

  @override
  List<Object?> get props => [
        movie,
        recommendations,
        recommendationState,
        isAddedToWatchlist,
        watchlistMessage,
        message,
      ];

  MovieDetailLoaded copyWith({
    MovieDetail? movie,
    List<Movie>? recommendations,
    RequestState? recommendationState,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
    String? message,
  }) {
    return MovieDetailLoaded(
      movie: movie ?? this.movie,
      recommendations: recommendations ?? this.recommendations,
      recommendationState: recommendationState ?? this.recommendationState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      message: message ?? this.message,
    );
  }
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
