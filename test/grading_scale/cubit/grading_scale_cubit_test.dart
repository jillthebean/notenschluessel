import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notenschluessel/grading_scale/grading_scale.dart';
import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';

const gradingResultsFor100Points = [
  GradingScaleResult(
    grade: '15',
    pointsNeeded: 95,
    percentNeeded: 95,
    pointsNeededRounded: 95,
  ),
  GradingScaleResult(
    grade: '14',
    pointsNeeded: 90,
    percentNeeded: 90,
    pointsNeededRounded: 90,
  ),
  GradingScaleResult(
    grade: '13',
    pointsNeeded: 85,
    percentNeeded: 85,
    pointsNeededRounded: 85,
  ),
  GradingScaleResult(
    grade: '12',
    pointsNeeded: 80,
    percentNeeded: 80,
    pointsNeededRounded: 80,
  ),
  GradingScaleResult(
    grade: '11',
    pointsNeeded: 75,
    percentNeeded: 75,
    pointsNeededRounded: 75,
  ),
  GradingScaleResult(
    grade: '10',
    pointsNeeded: 70,
    percentNeeded: 70,
    pointsNeededRounded: 70,
  ),
  GradingScaleResult(
    grade: '09',
    pointsNeeded: 65,
    percentNeeded: 65,
    pointsNeededRounded: 65,
  ),
  GradingScaleResult(
    grade: '08',
    pointsNeeded: 60,
    percentNeeded: 60,
    pointsNeededRounded: 60,
  ),
  GradingScaleResult(
    grade: '07',
    pointsNeeded: 55,
    percentNeeded: 55,
    pointsNeededRounded: 55,
  ),
  GradingScaleResult(
    grade: '06',
    pointsNeeded: 50,
    percentNeeded: 50,
    pointsNeededRounded: 50,
  ),
  GradingScaleResult(
    grade: '05',
    pointsNeeded: 45,
    percentNeeded: 45,
    pointsNeededRounded: 45,
  ),
  GradingScaleResult(
    grade: '04',
    pointsNeeded: 40,
    percentNeeded: 40,
    pointsNeededRounded: 40,
  ),
  GradingScaleResult(
    grade: '03',
    pointsNeeded: 33,
    percentNeeded: 33,
    pointsNeededRounded: 33,
  ),
  GradingScaleResult(
    grade: '02',
    pointsNeeded: 27,
    percentNeeded: 27,
    pointsNeededRounded: 27,
  ),
  GradingScaleResult(
    grade: '01',
    pointsNeeded: 20,
    percentNeeded: 20,
    pointsNeededRounded: 20,
  ),
  GradingScaleResult(
    grade: '00',
    pointsNeeded: 0,
    percentNeeded: 0,
    pointsNeededRounded: 0,
  ),
];

const gradingResultsFor25PointsRoundedToHalf = [
  GradingScaleResult(
    grade: '15',
    pointsNeeded: 95 / 4,
    percentNeeded: 95,
    pointsNeededRounded: 24,
  ),
  GradingScaleResult(
    grade: '14',
    pointsNeeded: 90 / 4,
    percentNeeded: 90,
    pointsNeededRounded: 22.5,
  ),
  GradingScaleResult(
    grade: '13',
    pointsNeeded: 85 / 4,
    percentNeeded: 85,
    pointsNeededRounded: 21.5,
  ),
  GradingScaleResult(
    grade: '12',
    pointsNeeded: 80 / 4,
    percentNeeded: 80,
    pointsNeededRounded: 20,
  ),
  GradingScaleResult(
    grade: '11',
    pointsNeeded: 75 / 4,
    percentNeeded: 75,
    pointsNeededRounded: 19,
  ),
  GradingScaleResult(
    grade: '10',
    pointsNeeded: 70 / 4,
    percentNeeded: 70,
    pointsNeededRounded: 17.5,
  ),
  GradingScaleResult(
    grade: '09',
    pointsNeeded: 65 / 4,
    percentNeeded: 65,
    pointsNeededRounded: 16.5,
  ),
  GradingScaleResult(
    grade: '08',
    pointsNeeded: 60 / 4,
    percentNeeded: 60,
    pointsNeededRounded: 15,
  ),
  GradingScaleResult(
    grade: '07',
    pointsNeeded: 55 / 4,
    percentNeeded: 55,
    pointsNeededRounded: 14,
  ),
  GradingScaleResult(
    grade: '06',
    pointsNeeded: 50 / 4,
    percentNeeded: 50,
    pointsNeededRounded: 12.5,
  ),
  GradingScaleResult(
    grade: '05',
    pointsNeeded: 45 / 4,
    percentNeeded: 45,
    pointsNeededRounded: 11.5,
  ),
  GradingScaleResult(
    grade: '04',
    pointsNeeded: 40 / 4,
    percentNeeded: 40,
    pointsNeededRounded: 10,
  ),
  GradingScaleResult(
    grade: '03',
    pointsNeeded: 33 / 4,
    percentNeeded: 33,
    pointsNeededRounded: 8.5,
  ),
  GradingScaleResult(
    grade: '02',
    pointsNeeded: 27 / 4,
    percentNeeded: 27,
    pointsNeededRounded: 7,
  ),
  GradingScaleResult(
    grade: '01',
    pointsNeeded: 20 / 4,
    percentNeeded: 20,
    pointsNeededRounded: 5,
  ),
  GradingScaleResult(
    grade: '00',
    pointsNeeded: 0 / 4,
    percentNeeded: 0,
    pointsNeededRounded: 0,
  ),
];

void main() {
  group('RoundingMode', () {
    test('rounds full correctly', () {
      const mode = RoundingMode.full;
      expect(mode.ceil(0.0001), equals(1));
      expect(mode.ceil(0.9), equals(1));
      expect(mode.ceil(0), equals(0));
    });
    test('rounds half correctly correctly', () {
      const mode = RoundingMode.half;
      expect(mode.ceil(0.0001), equals(0.5));
      expect(mode.ceil(0.9), equals(1));
      expect(mode.ceil(0), equals(0));
    });
    test('rounds quarter correctly correctly', () {
      const mode = RoundingMode.quarter;
      expect(mode.ceil(0.0001), equals(0.25));
      expect(mode.ceil(0.9), equals(1));
      expect(mode.ceil(0.25001), equals(0.5));
      expect(mode.ceil(0.50001), equals(0.75));
      expect(mode.ceil(0.75001), equals(1));
    });
  });
  group('GradingScaleCubit', () {
    test('initial state is 0', () {
      expect(
        GradingScaleCubit().state,
        equals(
          const GradingState(
            results: [],
            maxPoints: 0,
            mode: RoundingMode.full,
            gradingWeight: gradingScalesNotes,
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
        expect(bloc.state.mode, equals(RoundingMode.full));
        expect(bloc.state.maxPoints, equals(100));
        expect(bloc.state.results, orderedEquals(gradingResultsFor100Points));
      },
    );

    blocTest<GradingScaleCubit, GradingState>(
      'emits correct grading scales for rounding mode half',
      build: GradingScaleCubit.new,
      act: (cubit) => cubit
        ..setPoints(25)
        ..setMode(RoundingMode.half),
      verify: (bloc) {
        expect(bloc.state.mode, equals(RoundingMode.half));
        expect(bloc.state.maxPoints, equals(25));
        expect(
          bloc.state.results,
          orderedEquals(gradingResultsFor25PointsRoundedToHalf),
        );
      },
    );
  });
}
