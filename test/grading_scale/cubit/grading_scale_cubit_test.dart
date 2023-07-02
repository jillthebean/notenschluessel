import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notenschluessel/grading_scale/grading_scale.dart';
import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';

const gradingResultsFor100Points = [
  GradingScaleResult(
    grade: 15,
    pointsNeeded: 95,
    pointsNeededRounded: 95,
  ),
  GradingScaleResult(
    grade: 14,
    pointsNeeded: 90,
    pointsNeededRounded: 90,
  ),
  GradingScaleResult(
    grade: 13,
    pointsNeeded: 85,
    pointsNeededRounded: 85,
  ),
  GradingScaleResult(
    grade: 12,
    pointsNeeded: 80,
    pointsNeededRounded: 80,
  ),
  GradingScaleResult(
    grade: 11,
    pointsNeeded: 75,
    pointsNeededRounded: 75,
  ),
  GradingScaleResult(
    grade: 10,
    pointsNeeded: 70,
    pointsNeededRounded: 70,
  ),
  GradingScaleResult(
    grade: 9,
    pointsNeeded: 65,
    pointsNeededRounded: 65,
  ),
  GradingScaleResult(
    grade: 8,
    pointsNeeded: 60,
    pointsNeededRounded: 60,
  ),
  GradingScaleResult(
    grade: 7,
    pointsNeeded: 55,
    pointsNeededRounded: 55,
  ),
  GradingScaleResult(
    grade: 6,
    pointsNeeded: 50,
    pointsNeededRounded: 50,
  ),
  GradingScaleResult(
    grade: 5,
    pointsNeeded: 45,
    pointsNeededRounded: 45,
  ),
  GradingScaleResult(
    grade: 4,
    pointsNeeded: 40,
    pointsNeededRounded: 40,
  ),
  GradingScaleResult(
    grade: 3,
    pointsNeeded: 33,
    pointsNeededRounded: 33,
  ),
  GradingScaleResult(
    grade: 2,
    pointsNeeded: 27,
    pointsNeededRounded: 27,
  ),
  GradingScaleResult(
    grade: 1,
    pointsNeeded: 20,
    pointsNeededRounded: 20,
  ),
  GradingScaleResult(
    grade: 0,
    pointsNeeded: 0,
    pointsNeededRounded: 0,
  ),
];

void main() {
  group('GradingScaleCubit', () {
    test('initial state is 0', () {
      expect(
        GradingScaleCubit().state,
        equals(
          const GradingState(
            results: [],
            maxPoints: 0,
            mode: RoundingMode.fullPoints,
          ),
        ),
      );
    });

    blocTest<GradingScaleCubit, GradingState>(
      'emits GradingScaleResults when set points is called',
      build: GradingScaleCubit.new,
      act: (cubit) => cubit.setPoints(10),
      verify: (bloc) {
        expect(bloc.state.maxPoints, equals(10));
        expect(bloc.state.results, isNotEmpty);
      },
    );

    blocTest<GradingScaleCubit, GradingState>(
      'emits correct grading scales',
      build: GradingScaleCubit.new,
      act: (cubit) => cubit.setPoints(100),
      verify: (bloc) {
        expect(bloc.state.mode, equals(RoundingMode.fullPoints));
        expect(bloc.state.maxPoints, equals(100));
        expect(bloc.state.results, orderedEquals(gradingResultsFor100Points));
      },
    );
  });
}
