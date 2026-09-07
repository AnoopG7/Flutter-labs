// Basic widget test for Assignment 4.

import 'package:flutter_test/flutter_test.dart';

import 'package:assignment4/main.dart';

void main() {
  testWidgets('Home screen renders with three concept cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(const Assignment4App());

    expect(find.text('Flutter Assignment 4'), findsOneWidget);
    expect(find.text('User Input & Forms'), findsOneWidget);
    expect(find.text('Images, Assets & Fonts'), findsOneWidget);
    expect(find.text('Animations'), findsOneWidget);
  });
}