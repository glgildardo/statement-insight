import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:statement_insight/app/statement_insight_app.dart';

void main() {
  testWidgets('app boots', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: StatementInsightApp(),
      ),
    );

    expect(find.text('Statement Insight'), findsOneWidget);
  });
}
