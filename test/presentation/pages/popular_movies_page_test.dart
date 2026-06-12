import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_event.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_state.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';

class MockPopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

void main() {
  late MockPopularMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularMoviesBloc();
  });

  tearDown(() => mockBloc.close());

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display CircularProgressIndicator when loading',
      (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([PopularMoviesLoading()]),
      initialState: PopularMoviesInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    final tMovies = <Movie>[
      Movie(
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
      ),
    ];

    whenListen(
      mockBloc,
      Stream.fromIterable([PopularMoviesLoaded(tMovies)]),
      initialState: PopularMoviesInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display error text when Error', (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([const PopularMoviesError('Error message')]),
      initialState: PopularMoviesInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));
    await tester.pump();

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });
}
