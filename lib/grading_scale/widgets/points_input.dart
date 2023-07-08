import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notenschluessel/l10n/l10n.dart';

class PointsInput extends StatefulWidget {
  const PointsInput({
    required this.onChange,
    required this.initialValue,
    super.key,
  });

  final int initialValue;
  final void Function(int) onChange;

  @override
  State<PointsInput> createState() => _PointsInputState();
}

class _PointsInputState extends State<PointsInput> {
  late final _controller = TextEditingController(
    text: widget.initialValue.toString(),
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
      final newScore = int.tryParse(_controller.text);
      if (newScore != null) {
        widget.onChange(newScore);
      }
    });
  }

  bool validText(String? e) {
    if (e == null || e.isEmpty) return true;
    final input = int.tryParse(e);
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
          TextInputFormatter.withFunction(
            (oldValue, newValue) =>
                validText(newValue.text) ? newValue : oldValue,
          )
        ],
      ),
    );
  }
}
