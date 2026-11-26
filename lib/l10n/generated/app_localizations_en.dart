// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Declension Trainer';

  @override
  String appSubtitle(int count, String version) {
    return 'Ancient Greek · $count nouns v$version';
  }

  @override
  String get settingsTooltip => 'Settings';

  @override
  String get statsCorrect => 'Correct';

  @override
  String get statsPartial => 'Accent';

  @override
  String get statsWrong => 'Wrong';

  @override
  String get statsStreak => 'Streak';

  @override
  String get statsAccuracy => 'Accuracy';

  @override
  String get statsSkipped => 'Skipped';

  @override
  String feedbackCorrect(String answer) {
    return '✓ Correct! $answer';
  }

  @override
  String feedbackPartial(String answer) {
    return '◐ Almost! The declension is right, but the accent is wrong.\nCorrect: $answer';
  }

  @override
  String feedbackWrong(String answer) {
    return '✗ Wrong. The correct answer is: $answer';
  }

  @override
  String feedbackSkipped(String answer) {
    return '» Skipped. The answer would be: $answer';
  }

  @override
  String get fullParadigm => 'Full paradigm';

  @override
  String get singular => 'Singular';

  @override
  String get plural => 'Plural';

  @override
  String get insertLemma => 'Insert lemma';

  @override
  String get answerHint => 'Your answer…';

  @override
  String get check => 'Check';

  @override
  String get skip => 'Skip »';

  @override
  String get hideTable => 'Hide table';

  @override
  String get fullDeclension => 'Full declension';

  @override
  String get nextWord => 'Next word →';

  @override
  String buildForm(String number, String articleHint, String gramCase) {
    return 'Form the $gramCase $number$articleHint:';
  }

  @override
  String get withArticleSuffix => ' (with article)';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get declensionsSection => 'Declensions';

  @override
  String declChip(String n) {
    String _temp0 = intl.Intl.selectLogic(
      n,
      {
        '1': '1st decl.',
        '2': '2nd decl.',
        '3': '3rd decl.',
        'other': '$n. decl.',
      },
    );
    return '$_temp0';
  }

  @override
  String get casesSection => 'Cases';

  @override
  String get articleToggle => 'Ask for article';

  @override
  String get fullKeyboardToggle => 'Full Greek keyboard';

  @override
  String get themeSection => 'Theme';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'System';

  @override
  String get languageSection => 'Language';

  @override
  String get languageSystem => 'System language';

  @override
  String get shortcutsSection => 'Keyboard shortcuts';

  @override
  String get shortcutsText =>
      'Enter: Check / Next word · Tab: Skip · Esc: Toggle paradigm · Space: Next word (after answering)';

  @override
  String get resetStatsButton => 'Reset statistics';

  @override
  String get resetStatsTitle => 'Reset statistics?';

  @override
  String get resetStatsBody =>
      'All counters and learning progress will be deleted.';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get caseNom => 'Nominative';

  @override
  String get caseGen => 'Genitive';

  @override
  String get caseDat => 'Dative';

  @override
  String get caseAcc => 'Accusative';

  @override
  String get caseVoc => 'Vocative';

  @override
  String get caseAbbrNom => 'Nom.';

  @override
  String get caseAbbrGen => 'Gen.';

  @override
  String get caseAbbrDat => 'Dat.';

  @override
  String get caseAbbrAcc => 'Acc.';

  @override
  String get caseAbbrVoc => 'Voc.';

  @override
  String get genderM => 'masculine';

  @override
  String get genderF => 'feminine';

  @override
  String get genderN => 'neuter';

  @override
  String get decl1Eta => '1st decl. (η)';

  @override
  String get decl1AlphaLong => '1st decl. (ᾱ)';

  @override
  String get decl1AlphaShort => '1st decl. (ᾰ)';

  @override
  String get decl1MascHs => '1st decl. masc. (ης)';

  @override
  String get decl1MascAs => '1st decl. masc. (ας)';

  @override
  String get decl2Masc => '2nd decl. (ος)';

  @override
  String get decl2Neut => '2nd decl. (ον)';

  @override
  String get decl3Stop => '3rd decl. (stop)';

  @override
  String get decl3Nasal => '3rd decl. (nasal)';

  @override
  String get decl3Liquid => '3rd decl. (liquid)';

  @override
  String get decl3Sigma => '3rd decl. (σ-stem)';

  @override
  String get decl3VowelIs => '3rd decl. (ι-stem)';

  @override
  String get decl3VowelEus => '3rd decl. (ευ-stem)';

  @override
  String get decl3Nt => '3rd decl. (ντ-stem)';
}
