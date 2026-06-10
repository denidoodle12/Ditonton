import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/presentation/pages/tv_season_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_season_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_season_detail_page_test.mocks.dart';

@GenerateMocks([TVSeasonDetailNotifier])
void main() {
  late MockTVSeasonDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTVSeasonDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TVSeasonDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.seasonState).thenReturn(RequestState.Loading);
    // Needed to avoid null exceptions during fetch
    when(mockNotifier.fetchTvSeasonDetail(1, 1)).thenAnswer((_) async {});

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
        _makeTestableWidget(TVSeasonDetailPage(tvId: 1, seasonNumber: 1)));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
    when(mockNotifier.episodes).thenReturn(<Episode>[
      Episode(
        id: 1,
        name: 'Episode 1',
        overview: 'Overview 1',
        stillPath: '/path.jpg',
        airDate: '2021-01-01',
        episodeNumber: 1,
        seasonNumber: 1,
        voteAverage: 1.0,
      )
    ]);
    when(mockNotifier.fetchTvSeasonDetail(1, 1)).thenAnswer((_) async {});

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
        _makeTestableWidget(TVSeasonDetailPage(tvId: 1, seasonNumber: 1)));

    expect(listViewFinder, findsOneWidget);
    expect(find.text('1. Episode 1'), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.seasonState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');
    when(mockNotifier.fetchTvSeasonDetail(1, 1)).thenAnswer((_) async {});

    final textFinder = find.text('Error message');

    await tester.pumpWidget(
        _makeTestableWidget(TVSeasonDetailPage(tvId: 1, seasonNumber: 1)));

    expect(textFinder, findsOneWidget);
  });
}
