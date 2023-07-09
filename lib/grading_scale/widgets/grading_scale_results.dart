import 'package:flutter/material.dart';
import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';

import 'package:notenschluessel/grading_scale/widgets/result_line.dart';
import 'package:notenschluessel/l10n/l10n.dart';

class GradingScaleResultWidget extends StatelessWidget {
  const GradingScaleResultWidget({
    required this.results,
    super.key,
  });

  final List<GradingScaleResult> results;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      child: Column(
        children: [
          ResultLine(
            grade: l10n.gradingScaleTitleGrade,
            percentNeeded: l10n.gradingScaleTitlePercent,
            pointsNeeded: l10n.gradingScaleTitlePoints,
            pointsNeededRequired: l10n.gradingScaleTitlePointsRounded,
          ),
          ...results.map(ResultLine.fromGradeResult),
        ],
      ),
    );
  }
}
