import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:ditonton/presentation/provider/tv_season_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_season_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeasonDetail])
void main() {
  late TvSeasonDetailNotifier provider;
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;

  setUp(() {
    mockGetTvSeasonDetail = MockGetTvSeasonDetail();
    provider = TvSeasonDetailNotifier(getTvSeasonDetail: mockGetTvSeasonDetail);
  });

  final tTvId = 1;
  final tSeasonNumber = 1;
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
  final tEpisodes = [tEpisode];

  group('Get Tv Season Detail', () {
    test('should change state to Loading when usecase is called', () async {
      // arrange
      when(mockGetTvSeasonDetail.execute(tTvId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodes));
      // act
      provider.fetchTvSeasonDetail(tTvId, tSeasonNumber);
      // assert
      expect(provider.seasonState, RequestState.Loading);
    });

    test('should change episodes when data is gotten successfully', () async {
      // arrange
      when(mockGetTvSeasonDetail.execute(tTvId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodes));
      // act
      await provider.fetchTvSeasonDetail(tTvId, tSeasonNumber);
      // assert
      expect(provider.seasonState, RequestState.Loaded);
      expect(provider.episodes, tEpisodes);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeasonDetail.execute(tTvId, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeasonDetail(tTvId, tSeasonNumber);
      // assert
      expect(provider.seasonState, RequestState.Error);
      expect(provider.message, 'Server Failure');
    });
  });
}
