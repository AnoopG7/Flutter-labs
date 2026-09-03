import 'package:flutter_test/flutter_test.dart';

import 'package:play/main.dart';
import 'package:play/screens/listing_screen.dart';
import 'package:play/screens/watchlist_screen.dart';

void main() {
  testWidgets('Home screen renders core sections', (tester) async {
    await tester.pumpWidget(const MovieExplorerApp());

    expect(find.text('Movie Explorer'), findsWidgets);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Action'), findsOneWidget);
  });

  testWidgets('Browse tab opens the Movies listing', (tester) async {
    await tester.pumpWidget(const MovieExplorerApp());

    await tester.tap(find.text('Movies'));
    await tester.pumpAndSettle();

    expect(
      find.byType(ListingScreen),
      findsOneWidget,
    );
  });

  testWidgets('Watchlist tab shows empty state then updates',
      (tester) async {
    await tester.pumpWidget(const MovieExplorerApp());

    await tester.tap(find.text('Watchlist'));
    await tester.pumpAndSettle();

    expect(find.byType(WatchlistScreen), findsOneWidget);
    expect(find.text('Your watchlist is empty'), findsOneWidget);
  });
}