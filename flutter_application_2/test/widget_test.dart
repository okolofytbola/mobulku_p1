import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_2/main.dart';

void main() {
  testWidgets('NotesApp test: add, edit, delete note', (WidgetTester tester) async {
    await tester.pumpWidget(const NotesApp());

    expect(find.text('Заметки'), findsOneWidget);
    expect(find.text('Заметок пока нет'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Купить хлеб');
    await tester.tap(find.text('Сохранить'));
    await tester.pump();

    expect(find.text('Купить хлеб'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    expect(find.text('Редактировать заметку'), findsOneWidget);
    await tester.enterText(find.descendant(of: find.byType(AlertDialog), matching: find.byType(TextField)), 'Купить молоко');
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.text('Сохранить')));
    await tester.pumpAndSettle();

    expect(find.text('Купить молоко'), findsOneWidget);
    expect(find.text('Купить хлеб'), findsNothing);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(find.text('Купить молоко'), findsNothing);
    expect(find.text('Заметок пока нет'), findsOneWidget);
  });
}
