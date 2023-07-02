import 'package:bloc/bloc.dart';

import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';

double roundToFull(num toRound) => toRound.ceilToDouble();
double roundToHalf(num toRound) => (toRound * 2).ceil() / 2;
double roundToQuarter(num toRound) => (toRound * 4).ceil() / 4;

enum RoundingMode {
  full(roundToFull),
  half(roundToHalf),
  quarter(roundToQuarter);

  const RoundingMode(double Function(num) ceilingFn) : _ceil = ceilingFn;
  final double Function(num) _ceil;
  double ceil(num toRound) => _ceil(toRound);
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
            mode: RoundingMode.full,
          ),
        );

  void setPoints(int points) => _calculate(
        GradingState(
          mode: state.mode,
          results: [],
          maxPoints: points,
        ),
      );

  void setMode(RoundingMode? mode) => mode != null
      ? _calculate(
          GradingState(
            mode: mode,
            results: [],
            maxPoints: state.maxPoints,
          ),
        )
      : null;

  void _calculate(GradingState state) {
    final results = state.maxPoints > 0
        ? gradingScalesNotes.map((e) {
            final pointsNeeded100 =
                state.maxPoints.toDouble() * e.lowerBound.toDouble() / 100;
            return GradingScaleResult(
              grade: e.grade < 10 ? '0${e.grade}' : e.grade.toString(),
              pointsNeeded: pointsNeeded100,
              pointsNeededRounded: state.mode.ceil(pointsNeeded100),
              percentNeeded: e.lowerBound,
            );
          }).toList()
        : const <GradingScaleResult>[];
    emit(
      GradingState(
        mode: state.mode,
        results: results,
        maxPoints: state.maxPoints,
      ),
    );
  }
}
