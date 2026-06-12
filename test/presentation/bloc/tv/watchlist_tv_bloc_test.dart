import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv/watchlist_tv_event.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv/watchlist_tv_state.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistTVBloc bloc;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    bloc = WatchlistTVBloc(getWatchlistTV: GetWatchlistTV(mockTVRepository));
  });

  tearDown(() => bloc.close());

  final tTV = TV(
    backdropPath: '/muth.jpg',
    genreIds: const [14, 28],
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

  blocTest<WatchlistTVBloc, WatchlistTVState>(
    'emits [Loading, HasData] on success',
    build: () {
      when(mockTVRepository.getWatchlistTv())
          .thenAnswer((_) async => Right([tTV]));
      return bloc;
    },
    act: (b) => b.add(FetchWatchlistTV()),
    expect: () => [isA<WatchlistTVLoading>(), isA<WatchlistTVLoaded>()],
  );

  blocTest<WatchlistTVBloc, WatchlistTVState>(
    'emits [Loading, Error] on failure',
    build: () {
      when(mockTVRepository.getWatchlistTv())
          .thenAnswer((_) async => Left(DatabaseFailure('Database Error')));
      return bloc;
    },
    act: (b) => b.add(FetchWatchlistTV()),
    expect: () => [isA<WatchlistTVLoading>(), isA<WatchlistTVError>()],
  );
}
