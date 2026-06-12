import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/movie_search/movie_search_event.dart';
import 'package:movie/presentation/bloc/movie_search/movie_search_state.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieSearchBloc bloc;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    bloc = MovieSearchBloc(searchMovies: SearchMovies(mockMovieRepository));
  });

  tearDown(() => bloc.close());

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview: 'overview',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  test('initial state is MovieSearchInitial', () {
    expect(bloc.state, isA<MovieSearchInitial>());
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'emits [Loading, Loaded] when search is successful',
    build: () {
      when(mockMovieRepository.searchMovies('spiderman'))
          .thenAnswer((_) async => Right([tMovie]));
      return bloc;
    },
    act: (b) => b.add(const SearchMovieQuery('spiderman')),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      isA<MovieSearchLoading>(),
      isA<MovieSearchLoaded>(),
    ],
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'emits [Loading, Error] when search fails',
    build: () {
      when(mockMovieRepository.searchMovies('spiderman')).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (b) => b.add(const SearchMovieQuery('spiderman')),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      isA<MovieSearchLoading>(),
      isA<MovieSearchError>(),
    ],
  );
}
