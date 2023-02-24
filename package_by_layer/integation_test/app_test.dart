import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:package_by_layer/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test getting random question',
      (WidgetTester widgetTester) async {
    app.main();
    await widgetTester.pumpAndSettle();

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

    expect(find.byKey(const ValueKey("question")), findsOneWidget);
    expect(find.byKey(const ValueKey("suggestion 1")), findsOneWidget);
    expect(find.byKey(const ValueKey("suggestion 2")), findsOneWidget);
    expect(find.byKey(const ValueKey("suggestion 3")), findsOneWidget);
    expect(find.byKey(const ValueKey("suggestion 4")), findsOneWidget);
  });
}
