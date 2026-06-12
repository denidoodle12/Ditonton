import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_event.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_state.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';

class MockTVDetailBloc extends MockBloc<TVDetailEvent, TVDetailState>
    implements TVDetailBloc {}

void main() {
  late MockTVDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockTVDetailBloc();
  });

  tearDown(() => mockBloc.close());

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TVDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  final tTVDetail = TVDetail(
    backdropPath: '/path.jpg',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    name: 'Test TV',
    originalName: 'Test TV',
    overview: 'overview',
    posterPath: '/poster.jpg',
    firstAirDate: '2021-01-01',
    voteAverage: 7.0,
    voteCount: 100,
    numberOfSeasons: 1,
    numberOfEpisodes: 10,
    seasons: [
      Season(
        id: 1,
        airDate: '2021-01-01',
        episodeCount: 10,
        name: 'Season 1',
        overview: 'overview',
        posterPath: '/poster.jpg',
        seasonNumber: 1,
      ),
    ],
  );

  final tLoadedState = TVDetailLoaded(
    tv: tTVDetail,
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
      Stream.fromIterable([TVDetailLoading()]),
      initialState: TVDetailInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(TVDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display detail content when data is loaded',
      (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([tLoadedState]),
      initialState: TVDetailInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(TVDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(SafeArea), findsWidgets);
  });

  testWidgets('Page should display error text when Error', (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([const TVDetailError('Error message')]),
      initialState: TVDetailInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(TVDetailPage(id: 1)));
    await tester.pump();

    expect(find.text('Error message'), findsOneWidget);
  });
}
