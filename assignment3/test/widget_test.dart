import 'package:flutter_test/flutter_test.dart';

import 'package:assignment3/main.dart';

void main() {
  testWidgets('Identity card renders personal info', (WidgetTester tester) async {
    await tester.pumpWidget(const ProfileApp());

    expect(find.text('Your Name'), findsOneWidget);
    expect(find.text('Software Developer'), findsOneWidget);
    expect(find.text('21 Years'), findsOneWidget);
    expect(find.text('ID2026001'), findsOneWidget);
    expect(find.text('O+'), findsOneWidget);
    expect(find.text('Mumbai, India'), findsOneWidget);
    expect(find.text('your@email.com'), findsOneWidget);
  });
}