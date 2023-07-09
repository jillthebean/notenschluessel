import 'package:flutter_test/flutter_test.dart';
import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';

void main() {
  group('GradingWeight', () {
    const gradingWeightExample = GradingWeight(
      grade: 15,
      lowerBound: 95,
      upperBound: 100,
    );

    const copiedWithAllValues =
        GradingWeight(grade: 14, lowerBound: 1, upperBound: 1);

    test('correctly stringifies', () {
      expect(
        gradingWeightExample.toString(),
        equals('GradingWeight(15, 95)'),
      );
      expect(gradingWeightExample.hashCode, greaterThan(0));
    });

    test('correctly copies with all values', () {
      final copy = gradingWeightExample.copyWith(
        grade: 14,
        lowerBound: 1,
        upperBound: 1,
      );
      expect(
        copy,
        equals(copiedWithAllValues),
      );
    });
    test('correctly copies without any values', () {
      final copy = gradingWeightExample.copyWith();
      expect(
        copy,
        equals(gradingWeightExample),
      );
    });
  });
}
