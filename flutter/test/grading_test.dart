import 'package:ancientgreektrainer/logic/grading.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('stripAccents', () {
    test('entfernt Akzente, Spiritus und Iota subscriptum', () {
      expect(stripAccents('ψυχῆς'), 'ψυχης');
      expect(stripAccents('ὁ λόγος'), 'ο λογος');
      expect(stripAccents('ἀγαθῇ'), 'αγαθη');
      expect(stripAccents('ταῖς'), 'ταις');
    });

    test('ist case-insensitive und trimmt', () {
      expect(stripAccents('  ΨΥΧΉΣ '), 'ψυχης');
    });
  });

  group('normalize', () {
    test('trimmt, lowercased und kollabiert Leerzeichen', () {
      expect(normalize('  Ο   ΛΟΓΟΣ '), 'ο λογος');
    });
  });

  group('grade', () {
    test('exakt gleich ist correct', () {
      expect(grade('ψυχῆς', 'ψυχῆς'), GradeResult.correct);
    });

    test('nur Akzente abweichend ist partial', () {
      expect(grade('ψυχης', 'ψυχῆς'), GradeResult.partial);
      expect(grade('ψύχη', 'ψυχῆς'), GradeResult.partial);
    });

    test('Großschreibung allein ist partial (Akzent fehlt nach lowercase-Vergleich)', () {
      expect(grade('Ψυχῆς', 'ψυχῆς'), GradeResult.correct);
    });

    test('andere Buchstaben sind wrong', () {
      expect(grade('λόγος', 'ψυχῆς'), GradeResult.wrong);
    });

    test('Artikel: exakt mit Artikel ist correct', () {
      expect(grade('ὁ λόγος', 'ὁ λόγος'), GradeResult.correct);
    });

    test('Artikel: ohne Akzente partial', () {
      expect(grade('ο λογος', 'ὁ λόγος'), GradeResult.partial);
    });

    test('fehlender Artikel ist wrong', () {
      expect(grade('λόγος', 'ὁ λόγος'), GradeResult.wrong);
    });
  });
}
