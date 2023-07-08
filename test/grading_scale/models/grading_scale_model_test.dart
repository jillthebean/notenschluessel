import 'package:flutter_test/flutter_test.dart';
import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';

void main() {
  group('GradingScaleResult', () {
    test('correctly stringifies', () {
      const gradingScaleResult = GradingScaleResult(
        grade: '15',
        percentNeeded: 95,
        pointsNeeded: 95,
        pointsNeededRounded: 95,
      );
      expect(
        gradingScaleResult.toString(),
        equals('GradingScaleResult(15, 95.0)'),
      );
      expect(gradingScaleResult.hashCode, greaterThan(0));
    });
  });
}
