import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_event.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVListBloc bloc;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    bloc = TVListBloc(
      getOnTheAirTV: GetOnTheAirTV(mockTVRepository),
      getPopularTV: GetPopularTV(mockTVRepository),
      getTopRatedTV: GetTopRatedTV(mockTVRepository),
    );
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
  final tTVList = [tTV];

  group('FetchOnTheAirTV', () {
    blocTest<TVListBloc, TVListState>(
      'emits [TVListLoaded(Loading), TVListLoaded(Loaded)] on success',
      build: () {
        when(mockTVRepository.getOnTheAirTv())
            .thenAnswer((_) async => Right(tTVList));
        return bloc;
      },
      act: (b) => b.add(FetchOnTheAirTV()),
      expect: () => [isA<TVListLoaded>(), isA<TVListLoaded>()],
    );

    blocTest<TVListBloc, TVListState>(
      'emits [TVListLoaded(Loading), TVListLoaded(Error)] on failure',
      build: () {
        when(mockTVRepository.getOnTheAirTv())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (b) => b.add(FetchOnTheAirTV()),
      expect: () => [isA<TVListLoaded>(), isA<TVListLoaded>()],
    );
  });

  group('FetchPopularTV', () {
    blocTest<TVListBloc, TVListState>(
      'emits [TVListLoaded(Loading), TVListLoaded(Loaded)] on success',
      build: () {
        when(mockTVRepository.getPopularTv())
            .thenAnswer((_) async => Right(tTVList));
        return bloc;
      },
      act: (b) => b.add(FetchPopularTV()),
      expect: () => [isA<TVListLoaded>(), isA<TVListLoaded>()],
    );
  });

  group('FetchTopRatedTV', () {
    blocTest<TVListBloc, TVListState>(
      'emits [TVListLoaded(Loading), TVListLoaded(Loaded)] on success',
      build: () {
        when(mockTVRepository.getTopRatedTv())
            .thenAnswer((_) async => Right(tTVList));
        return bloc;
      },
      act: (b) => b.add(FetchTopRatedTV()),
      expect: () => [isA<TVListLoaded>(), isA<TVListLoaded>()],
    );
  });
}
