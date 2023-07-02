import 'package:bloc/bloc.dart';

import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';

enum RoundingMode {
  fullPoints,
  halfPoints,
  quarterPoints,
}

class GradingState {
  const GradingState({
    required this.mode,
    required this.results,
    required this.maxPoints,
  });

  final RoundingMode mode;
  final List<GradingScaleResult> results;
  final int maxPoints;
}

class GradingScaleCubit extends Cubit<GradingState> {
  GradingScaleCubit()
      : super(
          const GradingState(
            maxPoints: 0,
            results: [],
            mode: RoundingMode.fullPoints,
          ),
        );

  void setPoints(int points) => _calculate(
        GradingState(
          mode: state.mode,
          results: [],
          maxPoints: points,
        ),
      );

  void setMode(RoundingMode mode) => _calculate(
        GradingState(
          mode: mode,
          results: [],
          maxPoints: state.maxPoints,
        ),
      );

  void _calculate(GradingState state) {
    final results = gradingScalesNotes.map((e) {
      final pointsNeeded100 =
          (state.maxPoints.toDouble() * e.lowerBound.toDouble() * 100).round();
      return GradingScaleResult(
        grade: e.grade,
        pointsNeeded: pointsNeeded100.toDouble() / 100,
        pointsNeededRounded: (pointsNeeded100.toDouble() / 100).ceilToDouble(),
      );
    }).toList();
    emit(GradingState(
        mode: state.mode, results: results, maxPoints: state.maxPoints));
  }
}
