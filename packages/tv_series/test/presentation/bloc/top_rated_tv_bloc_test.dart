import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rated_tv_event.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rated_tv_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedTVBloc bloc;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    bloc = TopRatedTVBloc(getTopRatedTV: GetTopRatedTV(mockTVRepository));
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

  blocTest<TopRatedTVBloc, TopRatedTVState>(
    'emits [Loading, HasData] on success',
    build: () {
      when(mockTVRepository.getTopRatedTv())
          .thenAnswer((_) async => Right([tTV]));
      return bloc;
    },
    act: (b) => b.add(FetchTopRatedTVList()),
    expect: () => [isA<TopRatedTVLoading>(), isA<TopRatedTVLoaded>()],
  );

  blocTest<TopRatedTVBloc, TopRatedTVState>(
    'emits [Loading, Error] on failure',
    build: () {
      when(mockTVRepository.getTopRatedTv())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (b) => b.add(FetchTopRatedTVList()),
    expect: () => [isA<TopRatedTVLoading>(), isA<TopRatedTVError>()],
  );
}
