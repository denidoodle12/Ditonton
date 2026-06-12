import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movies_event.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movies_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistMoviesBloc bloc;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    bloc = WatchlistMoviesBloc(
        getWatchlistMovies: GetWatchlistMovies(mockMovieRepository));
  });

  tearDown(() => bloc.close());

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview: 'overview',
    popularity: 60.441,
    posterPath: '/rweI.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  test('initial state is WatchlistMoviesInitial', () {
    expect(bloc.state, isA<WatchlistMoviesInitial>());
  });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'emits [Loading, HasData] on success',
    build: () {
      when(mockMovieRepository.getWatchlistMovies())
          .thenAnswer((_) async => Right([tMovie]));
      return bloc;
    },
    act: (b) => b.add(FetchWatchlistMovies()),
    expect: () => [isA<WatchlistMoviesLoading>(), isA<WatchlistMoviesLoaded>()],
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'emits [Loading, Error] on failure',
    build: () {
      when(mockMovieRepository.getWatchlistMovies())
          .thenAnswer((_) async => Left(DatabaseFailure('Database Error')));
      return bloc;
    },
    act: (b) => b.add(FetchWatchlistMovies()),
    expect: () => [isA<WatchlistMoviesLoading>(), isA<WatchlistMoviesError>()],
  );
}
