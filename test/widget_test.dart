import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_quiz_master_app/main.dart';

void main() {
  testWidgets('Quiz Master home screen loads with title and categories',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QuizMasterApp());
    await tester.pumpAndSettle();

    // AppBar title should be visible.
    expect(find.text('Quiz Master'), findsWidgets);

    // Welcome header should be visible.
    expect(find.text('Welcome to Quiz Master!'), findsOneWidget);

    // At least one category should be listed.
    expect(find.text('Sports'), findsOneWidget);
  });
}
