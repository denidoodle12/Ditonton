import 'package:equatable/equatable.dart';

abstract class TVSearchEvent extends Equatable {
  const TVSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTVQuery extends TVSearchEvent {
  final String query;

  const SearchTVQuery(this.query);

  @override
  List<Object> get props => [query];
}
