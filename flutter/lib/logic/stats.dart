import 'grading.dart';

class Stats {
  int correct;
  int partial;
  int wrong;
  int streak;
  int bestStreak;
  int skipped;

  Stats({
    this.correct = 0,
    this.partial = 0,
    this.wrong = 0,
    this.streak = 0,
    this.bestStreak = 0,
    this.skipped = 0,
  });

  int get total => correct + wrong;

  int get pct => total > 0 ? (correct / total * 100).round() : 0;

  Map<String, dynamic> toJson() => {
        'correct': correct,
        'partial': partial,
        'wrong': wrong,
        'streak': streak,
        'bestStreak': bestStreak,
        'skipped': skipped,
      };

  factory Stats.fromJson(Map<String, dynamic> j) => Stats(
        correct: (j['correct'] as num?)?.toInt() ?? 0,
        partial: (j['partial'] as num?)?.toInt() ?? 0,
        wrong: (j['wrong'] as num?)?.toInt() ?? 0,
        streak: (j['streak'] as num?)?.toInt() ?? 0,
        bestStreak: (j['bestStreak'] as num?)?.toInt() ?? 0,
        skipped: (j['skipped'] as num?)?.toInt() ?? 0,
      );
}

void applyGrade(
  Stats stats,
  Map<String, double> errorCounts,
  String lemma,
  GradeResult result,
) {
  switch (result) {
    case GradeResult.correct:
      stats.correct++;
      stats.streak++;
      if (stats.streak > stats.bestStreak) stats.bestStreak = stats.streak;
      final c = errorCounts[lemma] ?? 0;
      if (c > 0) errorCounts[lemma] = c - 1;
    case GradeResult.partial:
      stats.partial++;
      stats.streak = 0;
      errorCounts[lemma] = (errorCounts[lemma] ?? 0) + 0.5;
    case GradeResult.wrong:
      stats.wrong++;
      stats.streak = 0;
      errorCounts[lemma] = (errorCounts[lemma] ?? 0) + 1;
  }
}

void applySkip(Stats stats) {
  stats.skipped++;
  stats.streak = 0;
}
