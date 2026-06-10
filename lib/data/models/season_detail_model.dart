import 'package:ditonton/data/models/episode_model.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailModel extends Equatable {
  final String id;
  final String? airDate;
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final int seasonDetailModelId;
  final String? posterPath;
  final int seasonNumber;

  SeasonDetailModel({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonDetailModelId,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) {
    return SeasonDetailModel(
      id: json['_id'],
      airDate: json['air_date'],
      episodes: List<EpisodeModel>.from(
          json['episodes'].map((x) => EpisodeModel.fromJson(x))),
      name: json['name'],
      overview: json['overview'],
      seasonDetailModelId: json['id'],
      posterPath: json['poster_path'],
      seasonNumber: json['season_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'air_date': airDate,
      'episodes': List<dynamic>.from(episodes.map((x) => x.toJson())),
      'name': name,
      'overview': overview,
      'id': seasonDetailModelId,
      'poster_path': posterPath,
      'season_number': seasonNumber,
    };
  }

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        seasonDetailModelId,
        posterPath,
        seasonNumber,
      ];
}
