import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_application_4/main.dart';
import 'package:flutter_application_4/models/exercise.dart';
import 'package:flutter_application_4/services/exercise_service.dart';
import 'package:flutter_application_4/widgets/exercise_card.dart';

void main() {
  setUp(() {
    GetIt.instance.reset();
    setupService();
  });

  test('ExerciseService service test', () async {
    final service = GetIt.instance<ExerciseService>();
    final result = await service.fetchExercises();
    expect(result.isNotEmpty, true);
  });

  testWidgets('ExerciseCard detail dialog test', (WidgetTester tester) async {
    final testExercise = Exercise(
      name: 'Тестовое упражнение',
      type: 'strength',
      muscle: 'chest',
      equipment: 'none',
      difficulty: 'beginner',
      instructions: 'Тестовая подробная инструкция для проверки диалога.',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExerciseCard(exercise: testExercise),
        ),
      ),
    );

    expect(find.text('Тестовое упражнение'), findsOneWidget);
    expect(find.text('Начальный'), findsOneWidget);

    await tester.tap(find.text('Тестовое упражнение'));
    await tester.pumpAndSettle();

    expect(find.text('Техника выполнения:'), findsOneWidget);

    await tester.tap(find.text('Закрыть'));
    await tester.pumpAndSettle();
    expect(find.text('Техника выполнения:'), findsNothing);
  });

  testWidgets('ExerciseScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ExerciseScreen(),
      ),
    );
    await tester.pump();

    expect(find.text('Спортивные упражнения'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Все мышцы'), findsOneWidget);
    expect(find.text('Все типы'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
