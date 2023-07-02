import 'package:flutter/material.dart';
import 'package:notenschluessel/grading_scale/grading_scale.dart';
import 'package:notenschluessel/l10n/l10n.dart';

class RoundingModeInput extends StatelessWidget {
  const RoundingModeInput({
    required this.mode,
    required this.onChanged,
    this.vertical = false,
    super.key,
  });

  final RoundingMode mode;
  final void Function(RoundingMode?) onChanged;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final inputs = RoundingMode.values
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
        .toList();
    return vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: inputs,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: inputs,
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
