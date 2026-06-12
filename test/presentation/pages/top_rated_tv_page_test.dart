import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rated_tv_event.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rated_tv_state.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_page.dart';

class MockTopRatedTVBloc extends MockBloc<TopRatedTVEvent, TopRatedTVState>
    implements TopRatedTVBloc {}

void main() {
  late MockTopRatedTVBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedTVBloc();
  });

  tearDown(() => mockBloc.close());

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

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

  testWidgets('Page should display CircularProgressIndicator when loading',
      (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([TopRatedTVLoading()]),
      initialState: TopRatedTVInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(TopRatedTVPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([TopRatedTVLoaded([tTV])]),
      initialState: TopRatedTVInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(TopRatedTVPage()));
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display error text when Error', (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([const TopRatedTVError('Error message')]),
      initialState: TopRatedTVInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(TopRatedTVPage()));
    await tester.pump();

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });
}
