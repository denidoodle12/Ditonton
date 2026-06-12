import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/search_tv.dart';
import 'package:tv_series/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_search/tv_search_event.dart';
import 'package:tv_series/presentation/bloc/tv_search/tv_search_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSearchBloc bloc;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    bloc = TVSearchBloc(searchTV: SearchTV(mockTVRepository));
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

  test('initial state is TVSearchInitial', () {
    expect(bloc.state, isA<TVSearchInitial>());
  });

  blocTest<TVSearchBloc, TVSearchState>(
    'emits [Loading, Loaded] when search is successful',
    build: () {
      when(mockTVRepository.searchTv('test'))
          .thenAnswer((_) async => Right([tTV]));
      return bloc;
    },
    act: (b) => b.add(const SearchTVQuery('test')),
    wait: const Duration(milliseconds: 500),
    expect: () => [isA<TVSearchLoading>(), isA<TVSearchLoaded>()],
  );

  blocTest<TVSearchBloc, TVSearchState>(
    'emits [Loading, Error] when search fails',
    build: () {
      when(mockTVRepository.searchTv('test'))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (b) => b.add(const SearchTVQuery('test')),
    wait: const Duration(milliseconds: 500),
    expect: () => [isA<TVSearchLoading>(), isA<TVSearchError>()],
  );
}
