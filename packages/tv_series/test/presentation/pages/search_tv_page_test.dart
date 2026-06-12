import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_search/tv_search_event.dart';
import 'package:tv_series/presentation/bloc/tv_search/tv_search_state.dart';
import 'package:tv_series/presentation/pages/search_tv_page.dart';
import 'package:tv_series/domain/entities/tv.dart';

class MockTVSearchBloc extends MockBloc<TVSearchEvent, TVSearchState>
    implements TVSearchBloc {}

void main() {
  late MockTVSearchBloc mockBloc;

  setUp(() {
    mockBloc = MockTVSearchBloc();
  });

  tearDown(() => mockBloc.close());

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TVSearchBloc>.value(
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

  testWidgets('Page should display empty when initial state', (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([TVSearchInitial()]),
      initialState: TVSearchInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(SearchTVPage()));
    await tester.pump();

    expect(find.byType(ListView), findsNothing);
  });

  testWidgets('Page should display CircularProgressIndicator when loading',
      (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([TVSearchLoading()]),
      initialState: TVSearchInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(SearchTVPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([
        TVSearchLoaded([tTV])
      ]),
      initialState: TVSearchInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(SearchTVPage()));
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display error text when Error', (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([const TVSearchError('Error message')]),
      initialState: TVSearchInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(SearchTVPage()));
    await tester.pump();

    expect(find.text('Error message'), findsOneWidget);
  });
}
