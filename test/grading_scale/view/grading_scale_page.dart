import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:notenschluessel/grading_scale/grading_scale.dart';

import '../../helpers/helpers.dart';

class MockGradingScaleCubit extends MockCubit<GradingState>
    implements GradingScaleCubit {}

void main() {
  group('CounterPage', () {
    testWidgets('renders CounterView', (tester) async {
      await tester.pumpApp(const GradingScaleView());
      expect(find.byType(GradingScaleView), findsOneWidget);
    });
  });

  group('CounterView', () {
    late GradingScaleCubit gradingScaleCubit;

    setUp(() {
      gradingScaleCubit = MockGradingScaleCubit();
    });

    testWidgets('renders current count', (tester) async {
      const state = GradingState(
        mode: RoundingMode.fullPoints,
        results: [],
        maxPoints: 100,
      );
      when(() => gradingScaleCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: gradingScaleCubit,
          child: const GradingScaleView(),
        ),
      );
      expect(find.text('$state'), findsOneWidget);
    });

    // testWidgets('calls increment when increment button is tapped',
    //     (tester) async {
    //   when(() => gradingScaleCubit.state).thenReturn(0);
    //   when(() => gradingScaleCubit.increment()).thenReturn(null);
    //   await tester.pumpApp(
    //     BlocProvider.value(
    //       value: gradingScaleCubit,
    //       child: const CounterView(),
    //     ),
    //   );
    //   await tester.tap(find.byIcon(Icons.add));
    //   verify(() => gradingScaleCubit.increment()).called(1);
    // });

    // testWidgets('calls decrement when decrement button is tapped',
    //     (tester) async {
    //   when(() => gradingScaleCubit.state).thenReturn(0);
    //   when(() => gradingScaleCubit.decrement()).thenReturn(null);
    //   await tester.pumpApp(
    //     BlocProvider.value(
    //       value: gradingScaleCubit,
    //       child: const CounterView(),
    //     ),
    //   );
    //   await tester.tap(find.byIcon(Icons.remove));
    //   verify(() => gradingScaleCubit.decrement()).called(1);
    // });
  });
}
