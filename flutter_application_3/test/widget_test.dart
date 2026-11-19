import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_3/main.dart';

void main() {
  testWidgets('NotesApp gesture tests', (WidgetTester tester) async {
    await tester.pumpWidget(const NotesApp());

    expect(find.text('Заметки'), findsOneWidget);
    expect(find.text('Заметок пока нет'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Купить хлеб');
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    expect(find.text('Купить хлеб'), findsOneWidget);
    expect(find.text('Заметок пока нет'), findsNothing);

    
    await tester.tap(find.text('Купить хлеб'));
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();

    expect(find.text('Просмотр заметки'), findsOneWidget);
    await tester.tap(find.text('Закрыть'));
    await tester.pumpAndSettle();
    expect(find.text('Просмотр заметки'), findsNothing);

    
    await tester.tap(find.text('Купить хлеб'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Купить хлеб'));
    await tester.pumpAndSettle();

    expect(find.text('⭐'), findsOneWidget);

    
    await tester.longPress(find.text('Купить хлеб'));
    await tester.pumpAndSettle();

    expect(find.text('Редактировать заметку'), findsOneWidget);
    await tester.enterText(
      find.descendant(of: find.byType(AlertDialog), matching: find.byType(TextField)),
      'Купить батон',
    );
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.text('Сохранить')));
    await tester.pumpAndSettle();

    expect(find.text('Купить батон'), findsOneWidget);
    expect(find.text('Купить хлеб'), findsNothing);
    expect(find.text('⭐'), findsOneWidget);

    
    await tester.drag(find.text('Купить батон'), const Offset(500.0, 0.0));
    await tester.pumpAndSettle();

    expect(find.text('⭐'), findsNothing);

    
    await tester.drag(find.text('Купить батон'), const Offset(-500.0, 0.0));
    await tester.pumpAndSettle();

    expect(find.text('Купить батон'), findsNothing);
    expect(find.text('Заметок пока нет'), findsOneWidget);
  });
}
