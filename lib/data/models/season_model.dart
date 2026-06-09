import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  SeasonModel({
    required this.id,
    required this.airDate,
    required this.episodeCount,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final int id;
  final String? airDate;
  final int episodeCount;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["id"],
        airDate: json["air_date"],
        episodeCount: json["episode_count"],
        name: json["name"],
        overview: json["overview"] ?? '',
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "air_date": airDate,
        "episode_count": episodeCount,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  Season toEntity() {
    return Season(
      id: this.id,
      airDate: this.airDate,
      episodeCount: this.episodeCount,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodeCount,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
