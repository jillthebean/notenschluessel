import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenschluessel/counter/counter.dart';
import 'package:notenschluessel/grading_scale/cubit/grading_scale_cubit.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: const Center(child: CounterText()),
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [],
      ),
    );
  }
}
