import 'dart:math';

import '../models/noun.dart';

class Question {
  final Noun noun;
  final GramCase gramCase;
  final GramNumber number;
  final String correctAnswer;

  const Question({
    required this.noun,
    required this.gramCase,
    required this.number,
    required this.correctAnswer,
  });
}

Question pickNext({
  required List<Noun> filtered,
  required Map<String, double> errorCounts,
  required List<GramCase> selectedCases,
  required bool includeArticle,
  required NounCatalog catalog,
  Noun? currentNoun,
  Random? rng,
}) {
  if (filtered.isEmpty) {
    throw ArgumentError('filtered must not be empty');
  }
  final r = rng ?? Random();
  final pool = <Noun>[];
  for (final n in filtered) {
    final errors = errorCounts[n.lemma] ?? 0;
    final weight = 1 + (errors < 5 ? errors : 5);
    for (var i = 0; i < weight; i++) {
      pool.add(n);
    }
  }
  var attempts = 0;
  Noun noun;
  do {
    noun = pool[r.nextInt(pool.length)];
    attempts++;
  } while (identical(noun, currentNoun) && pool.length > 1 && attempts < 10);

  for (var guard = 0; guard < 50; guard++) {
    final gramCase = selectedCases[r.nextInt(selectedCases.length)];
    final number = r.nextBool() ? GramNumber.sg : GramNumber.pl;
    var answer = noun.form(number, gramCase);
    if (answer == null || answer.isEmpty) continue;
    if (includeArticle && gramCase != GramCase.voc) {
      final art = catalog.articles.article(noun.gender, number, gramCase);
      if (art != null && art.isNotEmpty) answer = '$art $answer';
    }
    return Question(
      noun: noun,
      gramCase: gramCase,
      number: number,
      correctAnswer: answer,
    );
  }
  throw StateError('no valid form found for noun $noun');
}
