import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenschluessel/grading_scale/cubit/grading_scale_cubit.dart';
import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';
import 'package:notenschluessel/l10n/l10n.dart';

class GradingScalePage extends StatelessWidget {
  const GradingScalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GradingScaleCubit()..setPoints(30),
      child: const GradingScaleView(),
    );
  }
}

class GradingScaleView extends StatelessWidget {
  const GradingScaleView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final grading = context.watch<GradingScaleCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.gradingScaleAppBarTitle)),
      body: Column(
        children: [
          PointsInput(
            onChange: grading.setPoints,
          ),
          Text(
            l10n.gradingScaleInputRoundMode,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          RoundingModeInput(
            mode: grading.state.mode,
            onChanged: grading.setMode,
          ),
          ResultLine(
            grade: l10n.gradingScaleTitleGrade,
            percentNeeded: l10n.gradingScaleTitlePercent,
            pointsNeeded: l10n.gradingScaleTitlePoints,
            pointsNeededRequired: l10n.gradingScaleTitlePointsRounded,
          ),
          ...grading.state.results.map(ResultLine.fromGradeResult),
        ],
      ),
    );
  }
}

class PointsInput extends StatefulWidget {
  const PointsInput({
    required this.onChange,
    super.key,
  });

  final void Function(int) onChange;

  @override
  State<PointsInput> createState() => _PointsInputState();
}

class _PointsInputState extends State<PointsInput> {
  late final _controller = TextEditingController(text: '0');

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final newScore = int.tryParse(_controller.text);
      if (newScore != null) {
        widget.onChange(newScore);
      }
    });
  }

  bool validText(String? e) {
    if (e == null || e.isEmpty) return true;
    final input = int.tryParse(e);
    return input != null && input > 1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: context.l10n.gradingScaleInputMaxPoints,
        ),
        inputFormatters: [
          TextInputFormatter.withFunction(
            (oldValue, newValue) =>
                validText(newValue.text) ? newValue : oldValue,
          )
        ],
        validator: (e) {
          if (validText(e)) {
            return context.l10n.gradingScaleInputMaxPointsError;
          }
          return null;
        },
      ),
    );
  }
}

class RoundingModeInput extends StatelessWidget {
  const RoundingModeInput({
    required this.mode,
    required this.onChanged,
    super.key,
  });

  final RoundingMode mode;
  final void Function(RoundingMode?) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: RoundingMode.values
          .map(
            (e) => _buildListTile(
              e,
              switch (e) {
                (RoundingMode.full) => l10n.roundingModeFull,
                (RoundingMode.half) => l10n.roundingModeHalf,
                (RoundingMode.quarter) => l10n.roundingModeQuarter,
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildListTile(RoundingMode roundingMode, String label) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<RoundingMode>(
            value: roundingMode,
            groupValue: mode,
            onChanged: onChanged,
          ),
          Text(label),
        ],
      ),
    );
  }
}

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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
