import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/tv_season_detail/tv_season_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_season_detail/tv_season_detail_event.dart';
import 'package:tv_series/presentation/bloc/tv_season_detail/tv_season_detail_state.dart';
import 'package:tv_series/presentation/pages/tv_season_detail_page.dart';

class MockTVSeasonDetailBloc
    extends MockBloc<TVSeasonDetailEvent, TVSeasonDetailState>
    implements TVSeasonDetailBloc {}

void main() {
  late MockTVSeasonDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockTVSeasonDetailBloc();
  });

  tearDown(() => mockBloc.close());

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TVSeasonDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  final tEpisodes = [
    Episode(
      id: 1,
      name: 'Episode 1',
      overview: 'overview',
      stillPath: '/still.jpg',
      airDate: '2021-01-01',
      episodeNumber: 1,
      seasonNumber: 1,
      voteAverage: 7.0,
    ),
  ];

  testWidgets('Page should display CircularProgressIndicator when loading',
      (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([TVSeasonDetailLoading()]),
      initialState: TVSeasonDetailInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(
      TVSeasonDetailPage(tvId: 1, seasonNumber: 1),
    ));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display episode list when data is loaded',
      (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([TVSeasonDetailLoaded(tEpisodes)]),
      initialState: TVSeasonDetailInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(
      TVSeasonDetailPage(tvId: 1, seasonNumber: 1),
    ));
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display error text when Error', (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([const TVSeasonDetailError('Error message')]),
      initialState: TVSeasonDetailInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(
      TVSeasonDetailPage(tvId: 1, seasonNumber: 1),
    ));
    await tester.pump();

    expect(find.text('Error message'), findsOneWidget);
  });
}
