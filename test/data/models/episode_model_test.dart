import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tEpisodeModel = EpisodeModel(
    id: 1,
    name: 'name',
    overview: 'overview',
    stillPath: 'stillPath',
    airDate: 'airDate',
    episodeNumber: 1,
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  final tEpisode = Episode(
    id: 1,
    name: 'name',
    overview: 'overview',
    stillPath: 'stillPath',
    airDate: 'airDate',
    episodeNumber: 1,
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  test('should be a subclass of Episode entity', () async {
    final result = tEpisodeModel.toEntity();
    expect(result, tEpisode);
  });
}
