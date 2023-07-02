import 'package:flutter/foundation.dart';

class _GradingScaleNoteSetup {
  const _GradingScaleNoteSetup({
    required this.grade,
    required this.lowerBound,
    required this.upperBound,
  });
  final int grade;
  final int lowerBound;
  final int upperBound;
}

enum GradingCategory {
  sehrGut,
  gut,
  befriedigend,
  ausreichend,
  mangelhaft,
  ungenuegend,
}

const gradingScalesNotes = [
  _GradingScaleNoteSetup(
    grade: 15,
    lowerBound: 95,
    upperBound: 100,
  ),
  _GradingScaleNoteSetup(
    grade: 14,
    lowerBound: 90,
    upperBound: 95,
  ),
  _GradingScaleNoteSetup(
    grade: 13,
    lowerBound: 85,
    upperBound: 90,
  ),
  _GradingScaleNoteSetup(
    grade: 12,
    lowerBound: 80,
    upperBound: 85,
  ),
  _GradingScaleNoteSetup(
    grade: 11,
    lowerBound: 75,
    upperBound: 80,
  ),
  _GradingScaleNoteSetup(
    grade: 10,
    lowerBound: 70,
    upperBound: 75,
  ),
  _GradingScaleNoteSetup(
    grade: 9,
    lowerBound: 65,
    upperBound: 70,
  ),
  _GradingScaleNoteSetup(
    grade: 8,
    lowerBound: 60,
    upperBound: 65,
  ),
  _GradingScaleNoteSetup(
    grade: 7,
    lowerBound: 55,
    upperBound: 60,
  ),
  _GradingScaleNoteSetup(
    grade: 6,
    lowerBound: 50,
    upperBound: 55,
  ),
  _GradingScaleNoteSetup(
    grade: 5,
    lowerBound: 45,
    upperBound: 50,
  ),
  _GradingScaleNoteSetup(
    grade: 4,
    lowerBound: 40,
    upperBound: 45,
  ),
  _GradingScaleNoteSetup(
    grade: 3,
    lowerBound: 33,
    upperBound: 40,
  ),
  _GradingScaleNoteSetup(
    grade: 2,
    lowerBound: 27,
    upperBound: 33,
  ),
  _GradingScaleNoteSetup(
    grade: 1,
    lowerBound: 20,
    upperBound: 27,
  ),
  _GradingScaleNoteSetup(
    grade: 0,
    lowerBound: 0,
    upperBound: 20,
  ),
];

@immutable
class GradingScaleResult {
  const GradingScaleResult({
    required this.grade,
    required this.percentNeeded,
    required this.pointsNeeded,
    required this.pointsNeededRounded,
  });

  final String grade;
  final double pointsNeeded;
  final int percentNeeded;
  final double pointsNeededRounded;

  @override
  bool operator ==(Object other) {
    if (other is! GradingScaleResult) {
      return false;
    }
    return other.grade == grade &&
        other.pointsNeeded == pointsNeeded &&
        other.pointsNeededRounded == pointsNeededRounded;
  }

  @override
  int get hashCode =>
      grade.hashCode + pointsNeeded.hashCode + pointsNeededRounded.hashCode;

  @override
  String toString() {
    return 'GradingScaleResult($grade, $pointsNeeded)';
  }
}
