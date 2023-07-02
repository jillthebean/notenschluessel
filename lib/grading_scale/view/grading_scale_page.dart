import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenschluessel/grading_scale/cubit/grading_scale_cubit.dart';
import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';
import 'package:notenschluessel/grading_scale/widgets/widgets.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text(l10n.gradingScaleAppBarTitle)),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildLandscape(context);
            }
            return _buildPortrait(context);
          },
        ),
      ),
    );
  }

  Widget _buildPortrait(BuildContext context) {
    final l10n = context.l10n;
    final grading = context.watch<GradingScaleCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildInputs(grading, l10n, context, false),
            ..._buildResults(l10n, grading),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscape(BuildContext context) {
    final l10n = context.l10n;
    final grading = context.watch<GradingScaleCubit>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildInputs(grading, l10n, context, true),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: _buildResults(l10n, grading),
          ),
        )
      ],
    );
  }

  List<Widget> _buildResults(AppLocalizations l10n, GradingScaleCubit grading) {
    return [
      ResultLine(
        grade: l10n.gradingScaleTitleGrade,
        percentNeeded: l10n.gradingScaleTitlePercent,
        pointsNeeded: l10n.gradingScaleTitlePoints,
        pointsNeededRequired: l10n.gradingScaleTitlePointsRounded,
      ),
      ...grading.state.results.map(ResultLine.fromGradeResult),
    ];
  }

  List<Widget> _buildInputs(
    GradingScaleCubit grading,
    AppLocalizations l10n,
    BuildContext context,
    bool vertical,
  ) {
    return [
      PointsInput(
        onChange: grading.setPoints,
        initialValue: grading.state.maxPoints,
      ),
      Text(
        l10n.gradingScaleInputRoundMode,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      RoundingModeInput(
        mode: grading.state.mode,
        onChanged: grading.setMode,
        vertical: vertical,
      ),
    ];
  }
}
