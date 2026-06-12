import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

void main() {
  late MockMovieDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieDetailBloc();
  });

  tearDown(() => mockBloc.close());

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

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

  final tLoadedState = MovieDetailLoaded(
    movie: tMovieDetail,
    recommendations: const [],
    recommendationState: RequestState.Loaded,
    isAddedToWatchlist: false,
    message: '',
    watchlistMessage: '',
  );

  testWidgets('Page should display CircularProgressIndicator when loading',
      (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([MovieDetailLoading()]),
      initialState: MovieDetailInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display detail content when data is loaded',
      (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([tLoadedState]),
      initialState: MovieDetailInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(SafeArea), findsOneWidget);
  });

  testWidgets('Page should display error text when Error', (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([const MovieDetailError('Error message')]),
      initialState: MovieDetailInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));
    await tester.pump();

    expect(find.text('Error message'), findsOneWidget);
  });
}
