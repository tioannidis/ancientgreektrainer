import 'dart:convert';
import 'dart:io';

import 'package:ancientgreektrainer/main.dart';
import 'package:ancientgreektrainer/models/noun.dart';
import 'package:ancientgreektrainer/storage/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

NounCatalog loadCatalog() => NounCatalog.fromJson(
      jsonDecode(File('assets/nouns.json').readAsStringSync())
          as Map<String, dynamic>,
    );

Future<TrainerApp> buildApp() async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final service = PrefsService(prefs);
  return TrainerApp(
    service: service,
    settings: service.loadSettings(),
    catalog: loadCatalog(),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Quiz-Screen rendert Titel, Eingabe und Prüfen-Button', (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pumpAndSettle();
    expect(find.text('Deklinationstrainer'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Prüfen'), findsOneWidget);
    expect(find.text('Überspringen »'), findsOneWidget);
  });

  testWidgets('falsche Eingabe zeigt Feedback, dann nächstes Wort', (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'xyz');
    await tester.tap(find.text('Prüfen'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Leider falsch'), findsOneWidget);
    expect(find.text('Nächstes Wort →'), findsOneWidget);
    await tester.tap(find.text('Nächstes Wort →'));
    await tester.pumpAndSettle();
    expect(find.text('Prüfen'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Einstellungen: Artikel-Toggle und Theme-Wechsel', (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    expect(find.text('Einstellungen'), findsOneWidget);
    expect(find.text('Artikel mit abfragen'), findsOneWidget);
    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hell'));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Deklinationstrainer'), findsOneWidget);
  });

  testWidgets('Statistik zurücksetzen verlangt Bestätigung', (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Statistik zurücksetzen'));
    await tester.pumpAndSettle();
    expect(find.text('Statistik zurücksetzen?'), findsOneWidget);
    await tester.tap(find.text('Abbrechen'));
    await tester.pumpAndSettle();
    expect(find.text('Statistik zurücksetzen?'), findsNothing);
  });
}
