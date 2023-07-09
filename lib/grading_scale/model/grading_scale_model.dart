import 'package:flutter/foundation.dart';

@immutable
class GradingWeight {
  const GradingWeight({
    required this.grade,
    required this.lowerBound,
    required this.upperBound,
  });
  final int grade;
  final int lowerBound;
  final int upperBound;

  String get gradeString => grade < 10 ? '0$grade' : grade.toString();

  GradingWeight copyWith({
    int? grade,
    int? lowerBound,
    int? upperBound,
  }) =>
      GradingWeight(
        grade: grade ?? this.grade,
        lowerBound: lowerBound ?? this.lowerBound,
        upperBound: upperBound ?? this.upperBound,
      );

  @override
  bool operator ==(Object other) {
    if (other is! GradingWeight) {
      return false;
    }
    return other.grade == grade &&
        other.lowerBound == lowerBound &&
        other.upperBound == upperBound;
  }

  @override
  int get hashCode =>
      grade.hashCode + lowerBound.hashCode + upperBound.hashCode;

  @override
  String toString() {
    return 'GradingWeight($grade, $lowerBound)';
  }
}

enum GradingCategory {
  sehrGut,
  gut,
  befriedigend,
  ausreichend,
  mangelhaft,
  ungenuegend,
}

const defaultGradingWeights = [
  GradingWeight(
    grade: 15,
    lowerBound: 95,
    upperBound: 100,
  ),
  GradingWeight(
    grade: 14,
    lowerBound: 90,
    upperBound: 95,
  ),
  GradingWeight(
    grade: 13,
    lowerBound: 85,
    upperBound: 90,
  ),
  GradingWeight(
    grade: 12,
    lowerBound: 80,
    upperBound: 85,
  ),
  GradingWeight(
    grade: 11,
    lowerBound: 75,
    upperBound: 80,
  ),
  GradingWeight(
    grade: 10,
    lowerBound: 70,
    upperBound: 75,
  ),
  GradingWeight(
    grade: 9,
    lowerBound: 65,
    upperBound: 70,
  ),
  GradingWeight(
    grade: 8,
    lowerBound: 60,
    upperBound: 65,
  ),
  GradingWeight(
    grade: 7,
    lowerBound: 55,
    upperBound: 60,
  ),
  GradingWeight(
    grade: 6,
    lowerBound: 50,
    upperBound: 55,
  ),
  GradingWeight(
    grade: 5,
    lowerBound: 45,
    upperBound: 50,
  ),
  GradingWeight(
    grade: 4,
    lowerBound: 40,
    upperBound: 45,
  ),
  GradingWeight(
    grade: 3,
    lowerBound: 33,
    upperBound: 40,
  ),
  GradingWeight(
    grade: 2,
    lowerBound: 27,
    upperBound: 33,
  ),
  GradingWeight(
    grade: 1,
    lowerBound: 20,
    upperBound: 27,
  ),
  GradingWeight(
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
