import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_season_detail.dart';
import 'package:tv_series/presentation/bloc/tv_season_detail/tv_season_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_season_detail/tv_season_detail_event.dart';
import 'package:tv_series/presentation/bloc/tv_season_detail/tv_season_detail_state.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeasonDetailBloc bloc;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    bloc = TVSeasonDetailBloc(
        getTVSeasonDetail: GetTVSeasonDetail(mockTVRepository));
  });

  tearDown(() => bloc.close());

  const tTvId = 1;
  const tSeasonNumber = 1;
  final tEpisodes = [
    Episode(
      id: 1,
      name: 'Episode 1',
      overview: 'overview',
      stillPath: '/still.jpg',
      airDate: '2021-01-01',
      episodeNumber: 1,
      seasonNumber: 1,
      voteAverage: 7.0,
    ),
  ];

  blocTest<TVSeasonDetailBloc, TVSeasonDetailState>(
    'emits [Loading, Loaded] when fetch season detail succeeds',
    build: () {
      when(mockTVRepository.getTvSeasonDetail(tTvId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodes));
      return bloc;
    },
    act: (b) => b.add(const FetchTVSeasonDetail(
      tvId: tTvId,
      seasonNumber: tSeasonNumber,
    )),
    expect: () => [
      isA<TVSeasonDetailLoading>(),
      isA<TVSeasonDetailLoaded>(),
    ],
  );

  blocTest<TVSeasonDetailBloc, TVSeasonDetailState>(
    'emits [Loading, Error] when fetch season detail fails',
    build: () {
      when(mockTVRepository.getTvSeasonDetail(tTvId, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (b) => b.add(const FetchTVSeasonDetail(
      tvId: tTvId,
      seasonNumber: tSeasonNumber,
    )),
    expect: () => [
      isA<TVSeasonDetailLoading>(),
      isA<TVSeasonDetailError>(),
    ],
  );
}
