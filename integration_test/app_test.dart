import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'End-to-end: Movies & TV Series — Home → item → detail → `watchlist → drawer → watchlist page',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('Now Playing'), findsOneWidget);
      expect(find.text('Popular'), findsOneWidget);
      expect(find.text('Top Rated'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 8));

      final horizontalListView = find.byWidgetPredicate(
        (widget) =>
            widget is ListView && widget.scrollDirection == Axis.horizontal,
      );

      bool tappedMovie = false;
      if (horizontalListView.evaluate().isNotEmpty) {
        final movieInkWells = find.descendant(
          of: horizontalListView.first,
          matching: find.byType(InkWell),
        );
        if (movieInkWells.evaluate().isNotEmpty) {
          await tester.tap(movieInkWells.first);
          tappedMovie = true;
          await tester.pumpAndSettle(const Duration(seconds: 5));
        }
      }
      if (!tappedMovie) {
        final allInkWells = find.byType(InkWell);
        if (allInkWells.evaluate().isNotEmpty) {
          await tester.tap(allInkWells.first);
          await tester.pumpAndSettle(const Duration(seconds: 5));
        }
      }

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final movieWatchlistBtn = find.byType(FilledButton);
      if (movieWatchlistBtn.evaluate().isNotEmpty) {
        await tester.tap(movieWatchlistBtn.first);
        await tester.pumpAndSettle(const Duration(seconds: 3));

        final dialogOk = find.text('OK');
        if (dialogOk.evaluate().isNotEmpty) {
          await tester.tap(dialogOk.first);
          await tester.pumpAndSettle();
        }
      }

      final backBtn = find.byIcon(Icons.arrow_back);
      if (backBtn.evaluate().isNotEmpty) {
        await tester.tap(backBtn.first);
      } else {
        await tester.pageBack();
      }
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Ditonton'), findsOneWidget);

      final drawerBtn = find.byTooltip('Open navigation menu');
      if (drawerBtn.evaluate().isNotEmpty) {
        await tester.tap(drawerBtn.first);
      } else {
        await tester.dragFrom(const Offset(0, 300), const Offset(300, 300));
      }
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('Movies'), findsWidgets);
      expect(find.text('TV Series'), findsOneWidget);
      expect(find.text('Watchlist'), findsWidgets);
      expect(find.text('About'), findsOneWidget);

      final watchlistTile = find.ancestor(
        of: find.text('Watchlist'),
        matching: find.byType(ListTile),
      );
      if (watchlistTile.evaluate().isNotEmpty) {
        await tester.tap(watchlistTile.first);
      } else {
        await tester.tap(find.text('Watchlist').first);
      }
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(Scaffold), findsOneWidget);

      final backFromWatchlist = find.byType(BackButton);
      if (backFromWatchlist.evaluate().isNotEmpty) {
        await tester.tap(backFromWatchlist.first);
      } else {
        await tester.pageBack();
      }
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final drawerBtn2 = find.byTooltip('Open navigation menu');
      if (drawerBtn2.evaluate().isNotEmpty) {
        await tester.tap(drawerBtn2.first);
      } else {
        await tester.dragFrom(const Offset(0, 300), const Offset(300, 300));
      }
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.tap(find.text('TV Series').first);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('On The Air'), findsOneWidget);
      expect(find.text('Popular'), findsWidgets);
      expect(find.text('Top Rated'), findsWidgets);

      await tester.pumpAndSettle(const Duration(seconds: 8));

      final tvHorizontalListView = find.byWidgetPredicate(
        (widget) =>
            widget is ListView && widget.scrollDirection == Axis.horizontal,
      );

      bool tappedTV = false;
      if (tvHorizontalListView.evaluate().isNotEmpty) {
        final tvInkWells = find.descendant(
          of: tvHorizontalListView.first,
          matching: find.byType(InkWell),
        );
        if (tvInkWells.evaluate().isNotEmpty) {
          await tester.tap(tvInkWells.first);
          tappedTV = true;
          await tester.pumpAndSettle(const Duration(seconds: 5));
        }
      }
      if (!tappedTV) {
        final allInkWells = find.byType(InkWell);
        if (allInkWells.evaluate().isNotEmpty) {
          await tester.tap(allInkWells.first);
          await tester.pumpAndSettle(const Duration(seconds: 5));
        }
      }

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final tvWatchlistBtn = find.byType(FilledButton);
      if (tvWatchlistBtn.evaluate().isNotEmpty) {
        await tester.tap(tvWatchlistBtn.first);
        await tester.pumpAndSettle(const Duration(seconds: 3));

        final dialogOkTV = find.text('OK');
        if (dialogOkTV.evaluate().isNotEmpty) {
          await tester.tap(dialogOkTV.first);
          await tester.pumpAndSettle();
        }
      }

      final tvBackBtn = find.byIcon(Icons.arrow_back);
      if (tvBackBtn.evaluate().isNotEmpty) {
        await tester.tap(tvBackBtn.first);
      } else {
        await tester.pageBack();
      }
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Ditonton - TV Series'), findsOneWidget);

      final tvDrawerBtn = find.byTooltip('Open navigation menu');
      if (tvDrawerBtn.evaluate().isNotEmpty) {
        await tester.tap(tvDrawerBtn.first);
      } else {
        await tester.dragFrom(const Offset(0, 300), const Offset(300, 300));
      }
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('Watchlist TV'), findsOneWidget);

      await tester.tap(find.text('Watchlist TV').first);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(Scaffold), findsOneWidget);
    },
    timeout: const Timeout(Duration(minutes: 5)),
  );
}
