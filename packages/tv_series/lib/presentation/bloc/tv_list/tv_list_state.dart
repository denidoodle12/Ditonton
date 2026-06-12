import 'package:core/common/state_enum.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

abstract class TVListState extends Equatable {
  const TVListState();

  @override
  List<Object> get props => [];
}

class TVListInitial extends TVListState {}

class TVListLoading extends TVListState {}

class TVListLoaded extends TVListState {
  final List<TV> onTheAirTv;
  final List<TV> popularTv;
  final List<TV> topRatedTv;
  final RequestState onTheAirState;
  final RequestState popularTvState;
  final RequestState topRatedTvState;
  final String message;

  const TVListLoaded({
    required this.onTheAirTv,
    required this.popularTv,
    required this.topRatedTv,
    required this.onTheAirState,
    required this.popularTvState,
    required this.topRatedTvState,
    this.message = '',
  });

  @override
  List<Object> get props => [
        onTheAirTv,
        popularTv,
        topRatedTv,
        onTheAirState,
        popularTvState,
        topRatedTvState,
        message,
      ];

  TVListLoaded copyWith({
    List<TV>? onTheAirTv,
    List<TV>? popularTv,
    List<TV>? topRatedTv,
    RequestState? onTheAirState,
    RequestState? popularTvState,
    RequestState? topRatedTvState,
    String? message,
  }) {
    return TVListLoaded(
      onTheAirTv: onTheAirTv ?? this.onTheAirTv,
      popularTv: popularTv ?? this.popularTv,
      topRatedTv: topRatedTv ?? this.topRatedTv,
      onTheAirState: onTheAirState ?? this.onTheAirState,
      popularTvState: popularTvState ?? this.popularTvState,
      topRatedTvState: topRatedTvState ?? this.topRatedTvState,
      message: message ?? this.message,
    );
  }
}

class TVListError extends TVListState {
  final String message;

  const TVListError(this.message);

  @override
  List<Object> get props => [message];
}
