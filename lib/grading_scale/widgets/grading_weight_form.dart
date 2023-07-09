import 'package:flutter/material.dart';
import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';

class GradingWeightForm extends StatelessWidget {
  const GradingWeightForm({
    required this.weights,
    required this.onChange,
    super.key,
  });

  final List<GradingScaleNoteSetup> weights;
  final void Function(GradingScaleNoteSetup setup) onChange;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [...weights.map(_buildWeightInput)],
      ),
    );
  }

  Widget _buildWeightInput(GradingScaleNoteSetup setup) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(setup.grade.toString()),
        Text(setup.lowerBound.toString())
      ],
    );
  }
}
