import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:notenschluessel/grading_scale/grading_scale.dart';
import 'package:notenschluessel/grading_scale/model/grading_scale_model.dart';

import '../../helpers/helpers.dart';

class MockGradingScaleCubit extends MockCubit<GradingState>
    implements GradingScaleCubit {}

void main() {
  group('GradingScalePage', () {
    testWidgets('renders GradingScalePage', (tester) async {
      await tester.pumpApp(const GradingScalePage());
      expect(find.byType(GradingScalePage), findsOneWidget);
    });
  });

  group('GradingScaleView', () {
    late GradingScaleCubit gradingScaleCubit;

    setUp(() {
      gradingScaleCubit = MockGradingScaleCubit();
    });

    testWidgets('renders default points to 30', (tester) async {
      const state = GradingState(
        mode: RoundingMode.full,
        results: [],
        maxPoints: 30,
        gradingWeight: gradingScalesNotes,
      );
      when(() => gradingScaleCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: gradingScaleCubit,
          child: const GradingScaleView(),
        ),
      );
      expect(find.textContaining(state.maxPoints.toString()), findsOneWidget);
    });

    testWidgets('renders portrait mode', (tester) async {
      tester.view.physicalSize = const Size(600 * 3, 2000 * 3);
      await tester.pumpApp(const GradingScalePage());
      expect(find.byType(GradingScalePage), findsOneWidget);
      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
    });
  });
}
