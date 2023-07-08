import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notenschluessel/grading_scale/widgets/widgets.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PointsInput', () {
    testWidgets('renders PointsInput', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: PointsInput(
            initialValue: 30,
            onChange: (_) {},
          ),
        ),
      );
      expect(find.byType(PointsInput), findsOneWidget);
    });

    testWidgets('does not allow text input', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: PointsInput(
            initialValue: 30,
            onChange: (_) {},
          ),
        ),
      );
      await tester.enterText(find.byType(TextFormField), 'abcdef');
      expect(find.text('30'), findsOneWidget);
    });

    testWidgets('does not allow 0 points', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: PointsInput(
            initialValue: 0,
            onChange: (_) {},
          ),
        ),
      );
      await tester.showKeyboard(find.byType(TextFormField));
      tester.testTextInput.updateEditingValue(TextEditingValue.empty);
      await tester.idle();
      await tester.enterText(find.byType(TextFormField), '0000');
      expect(find.text(''), findsOneWidget);
    });
  });
}
