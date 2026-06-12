import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_event.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_state.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late PopularMoviesBloc bloc;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    bloc = PopularMoviesBloc(getPopularMovies: GetPopularMovies(mockMovieRepository));
  });

  tearDown(() => bloc.close());

  final tMovie = Movie(
    adult: false, backdropPath: '/muth.jpg', genreIds: const [14, 28],
    id: 557, originalTitle: 'Spider-Man', overview: 'overview',
    popularity: 60.441, posterPath: '/rweI.jpg', releaseDate: '2002-05-01',
    title: 'Spider-Man', video: false, voteAverage: 7.2, voteCount: 13507,
  );

  test('initial state is PopularMoviesInitial', () {
    expect(bloc.state, isA<PopularMoviesInitial>());
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'emits [Loading, HasData] on success',
    build: () {
      when(mockMovieRepository.getPopularMovies())
          .thenAnswer((_) async => Right([tMovie]));
      return bloc;
    },
    act: (b) => b.add(FetchPopularMoviesList()),
    expect: () => [isA<PopularMoviesLoading>(), isA<PopularMoviesLoaded>()],
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'emits [Loading, Error] on failure',
    build: () {
      when(mockMovieRepository.getPopularMovies()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (b) => b.add(FetchPopularMoviesList()),
    expect: () => [isA<PopularMoviesLoading>(), isA<PopularMoviesError>()],
  );
}
