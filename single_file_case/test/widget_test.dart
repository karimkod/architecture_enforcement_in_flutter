import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:single_file_case/main.dart';
import 'package:single_file_case/trivia_quiz.dart';

void main() {
  testWidgets('test getting random question',
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
        home: MyHomePage(
            title: 'Random Question Quizz', quizzService: testCompose())));
    expect(find.text("Random Question Quizz"), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text("Push the play button to get a random question"),
        findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await widgetTester.tap(find.byIcon(Icons.arrow_right));
    await widgetTester.pump();

    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text("Push the play button to get a random question"),
        findsNothing);
    expect(find.text("Loading your question"), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await widgetTester.pumpAndSettle();
    expect(find.text("Loading your question"), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    expect(find.text("Where is Algeria Situated?"), findsOneWidget);
    expect(find.text("North Africa"), findsOneWidget);
    expect(find.text("South Africa"), findsOneWidget);
    expect(find.text("Eastern Europe"), findsOneWidget);
    expect(find.text("South America"), findsOneWidget);
  });
}
