import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notenschluessel/l10n/l10n.dart';

class PointsInput extends StatefulWidget {
  const PointsInput({
    required this.onChange,
    required this.initialValue,
    super.key,
  });

  final double initialValue;
  final void Function(double) onChange;

  @override
  State<PointsInput> createState() => _PointsInputState();
}

class _PointsInputState extends State<PointsInput> {
  late final _controller = TextEditingController(
    text: widget.initialValue.roundToDouble().toString(),
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final newScore = double.tryParse(_controller.text);
      if (newScore != null) {
        widget.onChange(newScore);
      }
    });
  }

  bool validText(String? e) {
    if (e == null || e.isEmpty) return true;
    final input = double.tryParse(e);
    return input != null && input > 0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: TextFormField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: context.l10n.gradingScaleInputMaxPoints,
          labelStyle: Theme.of(context).textTheme.labelLarge,
        ),
        inputFormatters: [
          // DecimalTextInputFormatter(decimalRange: 2),
          TextInputFormatter.withFunction(
            (oldValue, newValue) =>
                validText(newValue.text) ? newValue : oldValue,
          ),
        ],
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange});

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var newSelection = newValue.selection;
    var truncated = newValue.text;

    final value = newValue.text;

    if (value.contains('.') &&
        value.substring(value.indexOf('.') + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == '.') {
      truncated = '0.';

      newSelection = newValue.selection.copyWith(
        baseOffset: min(truncated.length, truncated.length + 1),
        extentOffset: min(truncated.length, truncated.length + 1),
      );
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
  }
}
