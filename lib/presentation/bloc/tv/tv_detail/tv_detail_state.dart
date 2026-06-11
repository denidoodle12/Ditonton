import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TVDetailState extends Equatable {
  const TVDetailState();

  @override
  List<Object?> get props => [];
}

class TVDetailInitial extends TVDetailState {}

class TVDetailLoading extends TVDetailState {}

class TVDetailLoaded extends TVDetailState {
  final TVDetail tv;
  final List<TV> recommendations;
  final RequestState recommendationState;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final String message;

  const TVDetailLoaded({
    required this.tv,
    required this.recommendations,
    required this.recommendationState,
    required this.isAddedToWatchlist,
    this.watchlistMessage = '',
    this.message = '',
  });

  @override
  List<Object?> get props => [
        tv,
        recommendations,
        recommendationState,
        isAddedToWatchlist,
        watchlistMessage,
        message,
      ];

  TVDetailLoaded copyWith({
    TVDetail? tv,
    List<TV>? recommendations,
    RequestState? recommendationState,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
    String? message,
  }) {
    return TVDetailLoaded(
      tv: tv ?? this.tv,
      recommendations: recommendations ?? this.recommendations,
      recommendationState: recommendationState ?? this.recommendationState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      message: message ?? this.message,
    );
  }
}

class TVDetailError extends TVDetailState {
  final String message;

  const TVDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
