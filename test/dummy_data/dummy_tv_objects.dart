import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testTv = Tv(
  backdropPath: '/path.jpg',
  genreIds: [1, 2, 3],
  id: 1,
  name: 'Name',
  originalName: 'Original Name',
  overview: 'Overview',
  popularity: 1.0,
  posterPath: '/path.jpg',
  firstAirDate: '2020-05-05',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: '/path.jpg',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  name: 'Name',
  originalName: 'Original Name',
  overview: 'Overview',
  posterPath: '/path.jpg',
  firstAirDate: '2020-05-05',
  voteAverage: 1.0,
  voteCount: 1,
  numberOfSeasons: 1,
  numberOfEpisodes: 10,
  seasons: [
    Season(
      id: 1,
      airDate: '2020-05-05',
      episodeCount: 10,
      name: 'Season 1',
      overview: 'Season Overview',
      posterPath: '/path.jpg',
      seasonNumber: 1,
    ),
  ],
);

final testTvDetailResponse = TvDetailResponse(
  backdropPath: '/path.jpg',
  genres: [GenreModel(id: 1, name: 'Action')],
  homepage: 'https://example.com',
  id: 1,
  originalLanguage: 'en',
  originalName: 'Original Name',
  overview: 'Overview',
  popularity: 1.0,
  posterPath: '/path.jpg',
  firstAirDate: '2020-05-05',
  lastAirDate: '2020-05-05',
  name: 'Name',
  numberOfEpisodes: 10,
  numberOfSeasons: 1,
  seasons: [
    SeasonModel(
      id: 1,
      airDate: '2020-05-05',
      episodeCount: 10,
      name: 'Season 1',
      overview: 'Season Overview',
      posterPath: '/path.jpg',
      seasonNumber: 1,
    ),
  ],
  status: 'Returning Series',
  tagline: 'Tagline',
  type: 'Scripted',
  voteAverage: 1.0,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'Name',
  posterPath: '/path.jpg',
  overview: 'Overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'Name',
  posterPath: '/path.jpg',
  overview: 'Overview',
);

final testTvMap = {
  'id': 1,
  'name': 'Name',
  'posterPath': '/path.jpg',
  'overview': 'Overview',
};

final testTvModel = TvModel(
  backdropPath: '/path.jpg',
  genreIds: [1, 2, 3],
  id: 1,
  name: 'Name',
  originalName: 'Original Name',
  overview: 'Overview',
  popularity: 1.0,
  posterPath: '/path.jpg',
  firstAirDate: '2020-05-05',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvModelList = [testTvModel];

