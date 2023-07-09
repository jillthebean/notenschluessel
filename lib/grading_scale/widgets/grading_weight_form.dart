import 'package:flutter/material.dart';
import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';

class GradingWeightForm extends StatelessWidget {
  const GradingWeightForm({
    required this.weights,
    required this.onChange,
    super.key,
  });

  final List<GradingWeight> weights;
  final void Function(GradingWeight setup) onChange;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _buildWeightInputs(),
      ),
    );
  }

  List<Widget> _buildWeightInputs() {
    var upperBound = 100;
    var lowerBound = 0;
    final inputs = <Widget>[];

    for (final (idx, setup) in weights.indexed) {
      if (idx + 1 < weights.length) {
        lowerBound = weights[idx + 1].lowerBound;
        inputs.add(
          _WeightInput(
            weight: setup,
            max: upperBound,
            min: lowerBound,
            onChange: onChange,
          ),
        );
        upperBound = setup.lowerBound;
      }
    }
    return inputs;
  }
}

class _WeightInput extends StatelessWidget {
  const _WeightInput({
    required this.weight,
    required this.max,
    required this.min,
    required this.onChange,
  });
  final GradingWeight weight;
  final int min;
  final int max;
  final void Function(GradingWeight setup) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 75, height: 25, child: Text(weight.gradeString)),
        SizedBox(
          width: 75,
          height: 25,
          child: Text('≧${weight.lowerBound.toStringAsFixed(2)}%'),
        ),
        SizedBox(
          width: 250,
          height: 25,
          child: Slider(
            value: weight.lowerBound.toDouble(),
            max: max.toDouble(),
            min: min.toDouble(),
            onChanged: (double value) {
              onChange(weight.copyWith(lowerBound: value.round()));
            },
          ),
        ),
      ],
    );
  }
}
