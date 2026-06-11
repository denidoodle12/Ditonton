import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistTVState extends Equatable {
  const WatchlistTVState();

  @override
  List<Object> get props => [];
}

class WatchlistTVInitial extends WatchlistTVState {}

class WatchlistTVLoading extends WatchlistTVState {}

class WatchlistTVLoaded extends WatchlistTVState {
  final List<TV> tvList;

  const WatchlistTVLoaded(this.tvList);

  @override
  List<Object> get props => [tvList];
}

class WatchlistTVError extends WatchlistTVState {
  final String message;

  const WatchlistTVError(this.message);

  @override
  List<Object> get props => [message];
}
