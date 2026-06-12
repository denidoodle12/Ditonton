import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies/top_rated_movies_event.dart';
import 'package:movie/presentation/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

class MockTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

void main() {
  late MockTopRatedMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedMoviesBloc();
  });

  tearDown(() => mockBloc.close());

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display CircularProgressIndicator when loading',
      (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([TopRatedMoviesLoading()]),
      initialState: TopRatedMoviesInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    final tMovies = <Movie>[
      Movie(
        adult: false, backdropPath: '/muth.jpg', genreIds: const [14, 28],
        id: 557, originalTitle: 'Spider-Man', overview: 'overview',
        popularity: 60.441, posterPath: '/rweI.jpg', releaseDate: '2002-05-01',
        title: 'Spider-Man', video: false, voteAverage: 7.2, voteCount: 13507,
      ),
    ];

    whenListen(
      mockBloc,
      Stream.fromIterable([TopRatedMoviesLoaded(tMovies)]),
      initialState: TopRatedMoviesInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display error text when Error', (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([const TopRatedMoviesError('Error message')]),
      initialState: TopRatedMoviesInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));
    await tester.pump();

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });
}
