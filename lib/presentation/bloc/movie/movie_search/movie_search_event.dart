import 'package:equatable/equatable.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMovieQuery extends MovieSearchEvent {
  final String query;

  const SearchMovieQuery(this.query);

  @override
  List<Object> get props => [query];
}
