import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ancientgreektrainer/logic/filters.dart';
import 'package:ancientgreektrainer/logic/grading.dart';
import 'package:ancientgreektrainer/logic/picker.dart';
import 'package:ancientgreektrainer/logic/stats.dart';
import 'package:ancientgreektrainer/models/noun.dart';
import 'package:flutter_test/flutter_test.dart';

NounCatalog loadCatalog() => NounCatalog.fromJson(
      jsonDecode(File('assets/nouns.json').readAsStringSync())
          as Map<String, dynamic>,
    );

void main() {
  final catalog = loadCatalog();

  group('Katalog', () {
    test('lädt 122 Substantive und Artikeltabelle', () {
      expect(catalog.nouns.length, 122);
      expect(catalog.articles.article(GramGender.m, GramNumber.sg, GramCase.nom), 'ὁ');
      expect(catalog.articles.article(GramGender.f, GramNumber.pl, GramCase.dat), 'ταῖς');
      expect(catalog.articles.article(GramGender.n, GramNumber.sg, GramCase.voc), '');
    });

    test('ψυχή hat explizite Formen', () {
      final psy = catalog.nouns.firstWhere((n) => n.lemma == 'ψυχή');
      expect(psy.form(GramNumber.sg, GramCase.gen), 'ψυχῆς');
      expect(psy.form(GramNumber.pl, GramCase.nom), 'ψυχαί');
    });
  });

  group('applyFilters', () {
    test('nur 1. Deklination', () {
      final f = applyFilters(catalog.nouns, {'1'});
      expect(f, isNotEmpty);
      expect(f.every((n) => n.type.startsWith('1_')), isTrue);
    });

    test('leere Auswahl fällt auf alle Wörter zurück', () {
      expect(applyFilters(catalog.nouns, <String>{}).length, 122);
    });

    test('1+3 ohne 2', () {
      final f = applyFilters(catalog.nouns, {'1', '3'});
      expect(f.every((n) => !n.type.startsWith('2_')), isTrue);
    });
  });

  group('pickNext', () {
    test('liefert Frage mit zur Form passender Antwort', () {
      final q = pickNext(
        filtered: catalog.nouns,
        errorCounts: {},
        selectedCases: GramCase.values,
        includeArticle: false,
        catalog: catalog,
        rng: Random(42),
      );
      expect(q.noun.form(q.number, q.gramCase), q.correctAnswer);
    });

    test('Artikel wird außer beim Vokativ vorangestellt', () {
      final rng = Random(7);
      for (var i = 0; i < 100; i++) {
        final q = pickNext(
          filtered: catalog.nouns,
          errorCounts: {},
          selectedCases: GramCase.values,
          includeArticle: true,
          catalog: catalog,
          rng: rng,
        );
        final art = catalog.articles.article(q.noun.gender, q.number, q.gramCase);
        final form = q.noun.form(q.number, q.gramCase);
        if (q.gramCase == GramCase.voc) {
          expect(q.correctAnswer, form);
        } else if (art != null && art.isNotEmpty) {
          expect(q.correctAnswer, '$art $form');
        }
      }
    });

    test('Fehlergewichtung: Wort mit 5 Fehlern ca. 6x häufiger', () {
      final errors = <String, double>{};
      errors[catalog.nouns.first.lemma] = 5;
      final counts = <String, int>{};
      final rng = Random(1);
      const n = 4000;
      for (var i = 0; i < n; i++) {
        final q = pickNext(
          filtered: catalog.nouns,
          errorCounts: errors,
          selectedCases: [GramCase.nom],
          includeArticle: false,
          catalog: catalog,
          rng: rng,
        );
        counts[q.noun.lemma] = (counts[q.noun.lemma] ?? 0) + 1;
      }
      final share = counts[catalog.nouns.first.lemma]! / n;
      expect(share, greaterThan(0.04));
      expect(share, lessThan(0.06));
    });

    test('nie dasselbe Wort zweimal direkt hintereinander (bei pool > 1)', () {
      final rng = Random(3);
      Noun? prev;
      for (var i = 0; i < 200; i++) {
        final q = pickNext(
          filtered: catalog.nouns,
          errorCounts: {},
          selectedCases: [GramCase.nom],
          includeArticle: false,
          catalog: catalog,
          currentNoun: prev,
          rng: rng,
        );
        expect(identical(q.noun, prev), isFalse);
        prev = q.noun;
      }
    });
  });

  group('stats', () {
    test('applyGrade und applySkip wie in der PWA', () {
      final s = Stats();
      final e = <String, double>{};
      applyGrade(s, e, 'ψυχή', GradeResult.correct);
      expect(s.correct, 1);
      expect(s.streak, 1);
      expect(s.bestStreak, 1);
      expect(e.containsKey('ψυχή'), isFalse);
      applyGrade(s, e, 'ψυχή', GradeResult.wrong);
      expect(s.wrong, 1);
      expect(s.streak, 0);
      expect(e['ψυχή'], 1.0);
      applyGrade(s, e, 'ψυχή', GradeResult.partial);
      expect(s.partial, 1);
      expect(e['ψυχή'], 1.5);
      applyGrade(s, e, 'ψυχή', GradeResult.correct);
      expect(e['ψυχή'], 0.5);
      expect(s.bestStreak, 1);
      applySkip(s);
      expect(s.skipped, 1);
      expect(s.streak, 0);
      expect(s.pct, 67);
    });

    test('Stats-JSON rundet sich', () {
      final s = Stats(correct: 2, wrong: 1, streak: 0, bestStreak: 3, skipped: 1, partial: 1);
      final back = Stats.fromJson(s.toJson());
      expect(back.correct, 2);
      expect(back.bestStreak, 3);
      expect(back.pct, 67);
    });
  });
}
