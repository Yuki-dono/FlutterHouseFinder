import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:safe_stay/main.dart';

void main() {
  testWidgets('Safe Stay title is displayed', (WidgetTester tester) async {
    // Build the app.
    await tester.pumpWidget(const MyApp());

    // Verify that the "Safe Stay" text is present.
    expect(find.text('Safe Stay'), findsOneWidget);
  });

  testWidgets('Navigates to Login page on LOGIN button tap',
      (WidgetTester tester) async {
    // Build the app.
    await tester.pumpWidget(const MyApp());

    // Tap the LOGIN button.
    await tester.tap(find.text('LOGIN'));
    await tester.pumpAndSettle();

    // Verify that the "Login / Sign Up" text is present.
    expect(find.text('Login / Sign Up'), findsOneWidget);
  });
}
