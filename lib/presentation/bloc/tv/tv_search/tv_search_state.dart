import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

abstract class TVSearchState extends Equatable {
  const TVSearchState();

  @override
  List<Object> get props => [];
}

class TVSearchInitial extends TVSearchState {}

class TVSearchLoading extends TVSearchState {}

class TVSearchLoaded extends TVSearchState {
  final List<TV> result;

  const TVSearchLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TVSearchError extends TVSearchState {
  final String message;

  const TVSearchError(this.message);

  @override
  List<Object> get props => [message];
}
