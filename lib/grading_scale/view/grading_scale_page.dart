import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenschluessel/grading_scale/cubit/grading_scale_cubit.dart';
import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';
import 'package:notenschluessel/l10n/l10n.dart';

class GradingScalePage extends StatelessWidget {
  const GradingScalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GradingScaleCubit(),
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
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: Column(
        children: [
          PointsInput(
            onChange: grading.setPoints,
          ),
          RoundingModeInput(
            mode: grading.state.mode,
            onChanged: grading.setMode,
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
  final _controller = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(controller: _controller),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: RoundingMode.values.map(_buildListTile).toList(),
    );
  }

  Widget _buildListTile(RoundingMode roundingMode) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio<RoundingMode>(
          value: roundingMode,
          groupValue: mode,
          onChanged: onChanged,
        ),
        Text(roundingMode.name),
      ],
    );
  }
}

class ResultLine extends StatelessWidget {
  const ResultLine({
    required this.grade,
    required this.pointsNeeded,
    required this.pointsNeededRequired,
    super.key,
  });

  ResultLine.fromGradeResult(
    GradingScaleResult result, {
    super.key,
  })  : grade =
            result.grade < 10 ? '0${result.grade}' : result.grade.toString(),
        pointsNeeded = result.pointsNeeded.toStringAsFixed(2),
        pointsNeededRequired = result.pointsNeededRounded.toStringAsFixed(2);

  final String grade;
  final String pointsNeeded;
  final String pointsNeededRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ResultBox(grade),
        _ResultBox(pointsNeeded),
        _ResultBox(pointsNeededRequired),
      ],
    );
  }
}

class _ResultBox extends StatelessWidget {
  const _ResultBox(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(data, style: Theme.of(context).textTheme.bodyLarge);
  }
}
