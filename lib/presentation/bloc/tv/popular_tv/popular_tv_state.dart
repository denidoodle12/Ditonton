import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

abstract class PopularTVState extends Equatable {
  const PopularTVState();

  @override
  List<Object> get props => [];
}

class PopularTVInitial extends PopularTVState {}

class PopularTVLoading extends PopularTVState {}

class PopularTVLoaded extends PopularTVState {
  final List<TV> tvList;

  const PopularTVLoaded(this.tvList);

  @override
  List<Object> get props => [tvList];
}

class PopularTVError extends PopularTVState {
  final String message;

  const PopularTVError(this.message);

  @override
  List<Object> get props => [message];
}
