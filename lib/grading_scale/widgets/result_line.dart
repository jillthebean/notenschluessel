import 'package:flutter/material.dart';

import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';

class ResultLine extends StatelessWidget {
  const ResultLine({
    required this.grade,
    required this.percentNeeded,
    required this.pointsNeeded,
    required this.pointsNeededRequired,
    super.key,
  });

  ResultLine.fromGradeResult(
    GradingScaleResult result, {
    super.key,
  })  : grade = result.grade,
        percentNeeded = '${result.percentNeeded}%',
        pointsNeeded = result.pointsNeeded.toStringAsFixed(2),
        pointsNeededRequired = result.pointsNeededRounded.toStringAsFixed(2);

  final String grade;
  final String percentNeeded;
  final String pointsNeeded;
  final String pointsNeededRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ResultBox(grade),
        _ResultBox(percentNeeded),
        _ResultBox(pointsNeeded),
        _ResultBox(pointsNeededRequired),
      ],
    );
  }
}

class _ResultBox extends StatelessWidget {
  const _ResultBox(this.data);
  final String data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 25,
      child: Text(
        data,
        textAlign: TextAlign.end,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
