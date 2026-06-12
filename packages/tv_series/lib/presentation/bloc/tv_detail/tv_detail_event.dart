import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TVDetailEvent extends Equatable {
  const TVDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTVDetail extends TVDetailEvent {
  final int id;

  const FetchTVDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddTVWatchlist extends TVDetailEvent {
  final TVDetail tv;

  const AddTVWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveTVWatchlist extends TVDetailEvent {
  final TVDetail tv;

  const RemoveTVWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadTVWatchlistStatus extends TVDetailEvent {
  final int id;

  const LoadTVWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
