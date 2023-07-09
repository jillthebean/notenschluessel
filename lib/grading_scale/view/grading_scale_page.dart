import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenschluessel/grading_scale/cubit/grading_scale_cubit.dart';
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

class GradingScaleView extends StatefulWidget {
  const GradingScaleView({super.key});

  @override
  State<GradingScaleView> createState() => _GradingScaleViewState();
}

class _GradingScaleViewState extends State<GradingScaleView> {
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final grading = context.watch<GradingScaleCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.gradingScaleAppBarTitle)),
      body: SafeArea(
        child: isEdit
            ? GradingWeightForm(
                weights: grading.state.gradingWeight,
                onChange: grading.setWeight,
              )
            : const _GradingScaleResultsView(),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          setState(() {
            isEdit = !isEdit;
          });
        },
      ),
    );
  }
}

class _GradingScaleResultsView extends StatelessWidget {
  const _GradingScaleResultsView();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildLandscape(context);
        }
        return _buildPortrait(context);
      },
    );
  }

  Widget _buildPortrait(BuildContext context) {
    final l10n = context.l10n;
    final grading = context.watch<GradingScaleCubit>();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildInputs(grading, l10n, context, false),
          Expanded(
            child: GradingScaleResultWidget(
              results: grading.state.results,
            ),
          )
        ],
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
        GradingScaleResultWidget(
          results: grading.state.results,
        )
      ],
    );
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
