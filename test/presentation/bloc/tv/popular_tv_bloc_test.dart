import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tv_event.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tv_state.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late PopularTVBloc bloc;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    bloc = PopularTVBloc(getPopularTV: GetPopularTV(mockTVRepository));
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

  blocTest<PopularTVBloc, PopularTVState>(
    'emits [Loading, HasData] on success',
    build: () {
      when(mockTVRepository.getPopularTv())
          .thenAnswer((_) async => Right([tTV]));
      return bloc;
    },
    act: (b) => b.add(FetchPopularTVList()),
    expect: () => [isA<PopularTVLoading>(), isA<PopularTVLoaded>()],
  );

  blocTest<PopularTVBloc, PopularTVState>(
    'emits [Loading, Error] on failure',
    build: () {
      when(mockTVRepository.getPopularTv())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (b) => b.add(FetchPopularTVList()),
    expect: () => [isA<PopularTVLoading>(), isA<PopularTVError>()],
  );
}
