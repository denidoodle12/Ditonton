import 'package:equatable/equatable.dart';

abstract class TVListEvent extends Equatable {
  const TVListEvent();

  @override
  List<Object> get props => [];
}

class FetchOnTheAirTV extends TVListEvent {}

class FetchPopularTV extends TVListEvent {}

class FetchTopRatedTV extends TVListEvent {}
