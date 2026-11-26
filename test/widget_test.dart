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

Future<TrainerApp> buildApp({String language = 'de'}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final service = PrefsService(prefs);
  return TrainerApp(
    service: service,
    settings: service.loadSettings()..language = language,
    catalog: loadCatalog(),
    appVersion: '1.0.0',
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Quiz-Screen rendert Titel, Eingabe und Prüfen-Button', (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pumpAndSettle();
    expect(find.text('Deklinationstrainer'), findsOneWidget);
    expect(find.textContaining('v1.0.0'), findsOneWidget);
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
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Deklinationstrainer'), findsOneWidget);
  });

  testWidgets('Systemsprache ist die Vorauswahl', (tester) async {
    tester.platformDispatcher.localesTestValue = const [Locale('en', 'US')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    await tester.pumpWidget(await buildApp(language: 'system'));
    await tester.pumpAndSettle();
    expect(find.text('Declension Trainer'), findsOneWidget);
    expect(find.text('Check'), findsOneWidget);
  });

  testWidgets('Englische Lokalisierung', (tester) async {
    await tester.pumpWidget(await buildApp(language: 'en'));
    await tester.pumpAndSettle();
    expect(find.text('Declension Trainer'), findsOneWidget);
    expect(find.text('Check'), findsOneWidget);
    expect(find.text('Skip »'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('Ask for article'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    await tester.tap(find.text('Light'));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsWidgets);
  });

  testWidgets('Statistik zurücksetzen verlangt Bestätigung', (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Statistik zurücksetzen'),
      200,
      scrollable: find.descendant(
        of: find.byType(ListView),
        matching: find.byType(Scrollable),
      ),
    );
    await tester.tap(find.text('Statistik zurücksetzen'));
    await tester.pumpAndSettle();
    expect(find.text('Statistik zurücksetzen?'), findsOneWidget);
    await tester.tap(find.text('Abbrechen'));
    await tester.pumpAndSettle();
    expect(find.text('Statistik zurücksetzen?'), findsNothing);
  });
}
