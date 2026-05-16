import 'package:flutter_test/flutter_test.dart';
import 'package:questfit_app/main.dart';

void main() {
  testWidgets('QuestFit app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const QuestFitApp());
    expect(find.text('QUESTFIT'), findsOneWidget);
  });
}
