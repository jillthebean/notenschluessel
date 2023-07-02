import 'package:flutter_test/flutter_test.dart';
import 'package:notenschluessel/app/app.dart';
import 'package:notenschluessel/grading_scale/view/grading_scale_page.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(GradingScaleView), findsOneWidget);
    });
  });
}
