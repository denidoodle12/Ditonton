import 'package:core/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

abstract class TVSeasonDetailState extends Equatable {
  const TVSeasonDetailState();

  @override
  List<Object> get props => [];
}

class TVSeasonDetailInitial extends TVSeasonDetailState {}

class TVSeasonDetailLoading extends TVSeasonDetailState {}

class TVSeasonDetailLoaded extends TVSeasonDetailState {
  final List<Episode> episodes;

  const TVSeasonDetailLoaded(this.episodes);

  @override
  List<Object> get props => [episodes];
}

class TVSeasonDetailError extends TVSeasonDetailState {
  final String message;

  const TVSeasonDetailError(this.message);

  @override
  List<Object> get props => [message];
}
