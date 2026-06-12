import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/season.dart';

class TVDetail extends Equatable {
  TVDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.seasons,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final double voteAverage;
  final int voteCount;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final List<Season> seasons;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        name,
        originalName,
        overview,
        posterPath,
        firstAirDate,
        voteAverage,
        voteCount,
        numberOfSeasons,
        numberOfEpisodes,
        seasons,
      ];
}
