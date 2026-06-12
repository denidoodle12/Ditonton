import 'package:core/data/models/genre_model.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVDetailResponse extends Equatable {
  TVDetailResponse({
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String firstAirDate;
  final String? lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<SeasonModel> seasons;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  factory TVDetailResponse.fromJson(Map<String, dynamic> json) {
    return TVDetailResponse(
      backdropPath: json["backdrop_path"],
      genres: List<GenreModel>.from(
          json["genres"].map((x) => GenreModel.fromJson(x))),
      homepage: json["homepage"],
      id: json["id"],
      originalLanguage: json["original_language"],
      originalName: json["original_name"],
      overview: json["overview"],
      popularity: json["popularity"].toDouble(),
      posterPath: json["poster_path"],
      firstAirDate: json["first_air_date"],
      lastAirDate: json["last_air_date"],
      name: json["name"],
      numberOfEpisodes: json["number_of_episodes"],
      numberOfSeasons: json["number_of_seasons"],
      seasons: List<SeasonModel>.from(
          json["seasons"].map((x) => SeasonModel.fromJson(x))),
      status: json["status"],
      tagline: json["tagline"],
      type: json["type"],
      voteAverage: json["vote_average"].toDouble(),
      voteCount: json["vote_count"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "backdrop_path": backdropPath,
      "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      "homepage": homepage,
      "id": id,
      "original_language": originalLanguage,
      "original_name": originalName,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      "first_air_date": firstAirDate,
      "last_air_date": lastAirDate,
      "name": name,
      "number_of_episodes": numberOfEpisodes,
      "number_of_seasons": numberOfSeasons,
      "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
      "status": status,
      "tagline": tagline,
      "type": type,
      "vote_average": voteAverage,
      "vote_count": voteCount,
    };
  }

  TVDetail toEntity() {
    return TVDetail(
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      name: this.name,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      firstAirDate: this.firstAirDate,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      numberOfSeasons: this.numberOfSeasons,
      numberOfEpisodes: this.numberOfEpisodes,
      seasons: this.seasons.map((season) => season.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        homepage,
        id,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        seasons,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
