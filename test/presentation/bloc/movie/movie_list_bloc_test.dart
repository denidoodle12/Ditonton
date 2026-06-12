import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_state.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieListBloc bloc;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    bloc = MovieListBloc(
      getNowPlayingMovies: GetNowPlayingMovies(mockMovieRepository),
      getPopularMovies: GetPopularMovies(mockMovieRepository),
      getTopRatedMovies: GetTopRatedMovies(mockMovieRepository),
    );
  });

  tearDown(() {
    bloc.close();
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41v-yJkfP7bFJTsO.jpg',
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
  final tMovieList = [tMovie];

  void stubAll() {
    when(mockMovieRepository.getNowPlayingMovies())
        .thenAnswer((_) async => Right(tMovieList));
    when(mockMovieRepository.getPopularMovies())
        .thenAnswer((_) async => Right(tMovieList));
    when(mockMovieRepository.getTopRatedMovies())
        .thenAnswer((_) async => Right(tMovieList));
  }

  group('FetchNowPlayingMovies', () {
    blocTest<MovieListBloc, MovieListState>(
      'emits MovieListLoaded on success',
      build: () {
        stubAll();
        return bloc;
      },
      act: (b) => b.add(FetchNowPlayingMovies()),
      expect: () => [isA<MovieListLoaded>(), isA<MovieListLoaded>()],
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits MovieListLoaded with error sub-state when now playing fails',
      build: () {
        when(mockMovieRepository.getNowPlayingMovies())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockMovieRepository.getPopularMovies())
            .thenAnswer((_) async => Right(tMovieList));
        when(mockMovieRepository.getTopRatedMovies())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (b) => b.add(FetchNowPlayingMovies()),
      expect: () => [isA<MovieListLoaded>(), isA<MovieListLoaded>()],
    );
  });

  group('FetchPopularMovies', () {
    blocTest<MovieListBloc, MovieListState>(
      'emits MovieListLoaded on success',
      build: () {
        stubAll();
        return bloc;
      },
      act: (b) => b.add(FetchPopularMovies()),
      expect: () => [isA<MovieListLoaded>(), isA<MovieListLoaded>()],
    );
  });

  group('FetchTopRatedMovies', () {
    blocTest<MovieListBloc, MovieListState>(
      'emits MovieListLoaded on success',
      build: () {
        stubAll();
        return bloc;
      },
      act: (b) => b.add(FetchTopRatedMovies()),
      expect: () => [isA<MovieListLoaded>(), isA<MovieListLoaded>()],
    );
  });
}
