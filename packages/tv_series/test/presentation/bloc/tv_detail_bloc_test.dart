import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_event.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVDetailBloc bloc;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    bloc = TVDetailBloc(
      getTVDetail: GetTVDetail(mockTVRepository),
      getTVRecommendations: GetTVRecommendations(mockTVRepository),
      getWatchListStatusTV: GetWatchListStatusTV(mockTVRepository),
      saveWatchlistTV: SaveWatchlistTV(mockTVRepository),
      removeWatchlistTV: RemoveWatchlistTV(mockTVRepository),
    );
  });

  tearDown(() => bloc.close());

  const tId = 1;
  final tTV = TV(
    backdropPath: '/path.jpg',
    genreIds: const [1],
    id: 1,
    name: 'Test TV',
    originalName: 'Test TV',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/poster.jpg',
    firstAirDate: '2021-01-01',
    voteAverage: 7.0,
    voteCount: 100,
  );
  final tTVDetail = TVDetail(
    backdropPath: '/path.jpg',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    name: 'Test TV',
    originalName: 'Test TV',
    overview: 'overview',
    posterPath: '/poster.jpg',
    firstAirDate: '2021-01-01',
    voteAverage: 7.0,
    voteCount: 100,
    numberOfSeasons: 1,
    numberOfEpisodes: 10,
    seasons: [
      Season(
        id: 1,
        airDate: '2021-01-01',
        episodeCount: 10,
        name: 'Season 1',
        overview: 'overview',
        posterPath: '/poster.jpg',
        seasonNumber: 1,
      ),
    ],
  );

  group('FetchTVDetail', () {
    blocTest<TVDetailBloc, TVDetailState>(
      'emits [Loading, Loaded] when fetch succeeds',
      build: () {
        when(mockTVRepository.getTVDetail(tId))
            .thenAnswer((_) async => Right(tTVDetail));
        when(mockTVRepository.getTvRecommendations(tId))
            .thenAnswer((_) async => Right([tTV]));
        when(mockTVRepository.isAddedToWatchlistTv(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (b) => b.add(const FetchTVDetail(tId)),
      expect: () => [
        isA<TVDetailLoading>(),
        isA<TVDetailLoaded>(),
      ],
    );

    blocTest<TVDetailBloc, TVDetailState>(
      'emits [Loading, Error] when detail fetch fails',
      build: () {
        when(mockTVRepository.getTVDetail(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockTVRepository.getTvRecommendations(tId))
            .thenAnswer((_) async => Right([tTV]));
        return bloc;
      },
      act: (b) => b.add(const FetchTVDetail(tId)),
      expect: () => [isA<TVDetailLoading>(), isA<TVDetailError>()],
    );
  });

  group('AddTVWatchlist', () {
    blocTest<TVDetailBloc, TVDetailState>(
      'emits updated state with success message when added',
      build: () {
        when(mockTVRepository.getTVDetail(tId))
            .thenAnswer((_) async => Right(tTVDetail));
        when(mockTVRepository.getTvRecommendations(tId))
            .thenAnswer((_) async => Right([tTV]));
        when(mockTVRepository.isAddedToWatchlistTv(tId))
            .thenAnswer((_) async => false);
        when(mockTVRepository.saveWatchlistTv(tTVDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return bloc;
      },
      act: (b) async {
        b.add(const FetchTVDetail(tId));
        await Future.delayed(const Duration(milliseconds: 500));
        b.add(AddTVWatchlist(tTVDetail));
      },
      skip: 2,
      expect: () => [isA<TVDetailLoaded>()],
    );
  });

  group('RemoveTVWatchlist', () {
    blocTest<TVDetailBloc, TVDetailState>(
      'emits updated state with success message when removed',
      build: () {
        when(mockTVRepository.getTVDetail(tId))
            .thenAnswer((_) async => Right(tTVDetail));
        when(mockTVRepository.getTvRecommendations(tId))
            .thenAnswer((_) async => Right([tTV]));
        when(mockTVRepository.isAddedToWatchlistTv(tId))
            .thenAnswer((_) async => true);
        when(mockTVRepository.removeWatchlistTv(tTVDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return bloc;
      },
      act: (b) async {
        b.add(const FetchTVDetail(tId));
        await Future.delayed(const Duration(milliseconds: 500));
        b.add(RemoveTVWatchlist(tTVDetail));
      },
      skip: 2,
      expect: () => [isA<TVDetailLoaded>(), isA<TVDetailLoaded>()],
    );
  });
}
