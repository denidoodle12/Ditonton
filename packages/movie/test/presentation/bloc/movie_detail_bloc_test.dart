import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieDetailBloc bloc;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    bloc = MovieDetailBloc(
      getMovieDetail: GetMovieDetail(mockMovieRepository),
      getMovieRecommendations: GetMovieRecommendations(mockMovieRepository),
      getWatchListStatus: GetWatchListStatus(mockMovieRepository),
      saveWatchlist: SaveWatchlist(mockMovieRepository),
      removeWatchlist: RemoveWatchlist(mockMovieRepository),
    );
  });

  tearDown(() => bloc.close());

  final tId = 1;
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  group('FetchMovieDetail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Loading, Loaded] when fetch succeeds',
      build: () {
        when(mockMovieRepository.getMovieDetail(tId))
            .thenAnswer((_) async => Right(tMovieDetail));
        when(mockMovieRepository.getMovieRecommendations(tId))
            .thenAnswer((_) async => Right([tMovie]));
        when(mockMovieRepository.isAddedToWatchlist(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (b) => b.add(FetchMovieDetail(tId)),
      expect: () => [
        isA<MovieDetailLoading>(),
        isA<MovieDetailLoaded>(),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Loading, Error] when detail fetch fails',
      build: () {
        when(mockMovieRepository.getMovieDetail(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockMovieRepository.getMovieRecommendations(tId))
            .thenAnswer((_) async => Right([tMovie]));
        return bloc;
      },
      act: (b) => b.add(FetchMovieDetail(tId)),
      expect: () => [
        isA<MovieDetailLoading>(),
        isA<MovieDetailError>(),
      ],
    );
  });

  group('AddMovieWatchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits updated state with success message when added to watchlist',
      build: () {
        when(mockMovieRepository.getMovieDetail(tId))
            .thenAnswer((_) async => Right(tMovieDetail));
        when(mockMovieRepository.getMovieRecommendations(tId))
            .thenAnswer((_) async => Right([tMovie]));
        when(mockMovieRepository.isAddedToWatchlist(tId))
            .thenAnswer((_) async => false);
        when(mockMovieRepository.saveWatchlist(tMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return bloc;
      },
      act: (b) async {
        b.add(FetchMovieDetail(tId));
        await Future.delayed(const Duration(milliseconds: 500));
        b.add(AddMovieWatchlist(tMovieDetail));
      },
      skip: 2,
      expect: () => [isA<MovieDetailLoaded>()],
    );
  });

  group('RemoveMovieWatchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits updated state with success message when removed from watchlist',
      build: () {
        when(mockMovieRepository.getMovieDetail(tId))
            .thenAnswer((_) async => Right(tMovieDetail));
        when(mockMovieRepository.getMovieRecommendations(tId))
            .thenAnswer((_) async => Right([tMovie]));
        when(mockMovieRepository.isAddedToWatchlist(tId))
            .thenAnswer((_) async => true);
        when(mockMovieRepository.removeWatchlist(tMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return bloc;
      },
      act: (b) async {
        b.add(FetchMovieDetail(tId));
        await Future.delayed(const Duration(milliseconds: 500));
        b.add(RemoveMovieWatchlist(tMovieDetail));
      },
      skip: 2,
      expect: () => [isA<MovieDetailLoaded>(), isA<MovieDetailLoaded>()],
    );
  });
}
