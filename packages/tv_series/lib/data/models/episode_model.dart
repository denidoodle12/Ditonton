import 'package:core/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';
class EpisodeModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? stillPath;
  final String? airDate;
  final int episodeNumber;
  final int seasonNumber;
  final double voteAverage;
  EpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.stillPath,
    required this.airDate,
    required this.episodeNumber,
    required this.seasonNumber,
    required this.voteAverage,
  });
  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      stillPath: json['still_path'],
      airDate: json['air_date'],
      episodeNumber: json['episode_number'],
      seasonNumber: json['season_number'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'still_path': stillPath,
      'air_date': airDate,
      'episode_number': episodeNumber,
      'season_number': seasonNumber,
      'vote_average': voteAverage,
    };
  }
  Episode toEntity() {
    return Episode(
      id: this.id,
      name: this.name,
      overview: this.overview,
      stillPath: this.stillPath,
      airDate: this.airDate,
      episodeNumber: this.episodeNumber,
      seasonNumber: this.seasonNumber,
      voteAverage: this.voteAverage,
    );
  }
  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        stillPath,
        airDate,
        episodeNumber,
        seasonNumber,
        voteAverage,
      ];
}
