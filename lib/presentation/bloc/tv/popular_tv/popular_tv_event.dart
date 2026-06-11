import 'package:equatable/equatable.dart';

abstract class PopularTVEvent extends Equatable {
  const PopularTVEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularTVList extends PopularTVEvent {}
