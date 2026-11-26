// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Deklinationstrainer';

  @override
  String appSubtitle(int count, String version) {
    return 'Altgriechisch · $count Substantive v$version';
  }

  @override
  String get settingsTooltip => 'Einstellungen';

  @override
  String get statsCorrect => 'Richtig';

  @override
  String get statsPartial => 'Betonung';

  @override
  String get statsWrong => 'Falsch';

  @override
  String get statsStreak => 'Serie';

  @override
  String get statsAccuracy => 'Quote';

  @override
  String get statsSkipped => 'Übersprg.';

  @override
  String feedbackCorrect(String answer) {
    return '✓ Richtig! $answer';
  }

  @override
  String feedbackPartial(String answer) {
    return '◐ Fast! Richtige Deklination, aber die Betonung stimmt nicht.\nKorrekt: $answer';
  }

  @override
  String feedbackWrong(String answer) {
    return '✗ Leider falsch. Richtig wäre: $answer';
  }

  @override
  String feedbackSkipped(String answer) {
    return '» Übersprungen. Die Antwort wäre: $answer';
  }

  @override
  String get fullParadigm => 'Vollständiges Paradigma';

  @override
  String get singular => 'Singular';

  @override
  String get plural => 'Plural';

  @override
  String get insertLemma => 'Lemma einfügen';

  @override
  String get answerHint => 'Deine Antwort…';

  @override
  String get check => 'Prüfen';

  @override
  String get skip => 'Überspringen »';

  @override
  String get hideTable => 'Tabelle ausblenden';

  @override
  String get fullDeclension => 'Ganze Deklination';

  @override
  String get nextWord => 'Nächstes Wort →';

  @override
  String buildForm(String number, String articleHint, String gramCase) {
    return 'Bilde den $gramCase $number$articleHint:';
  }

  @override
  String get withArticleSuffix => ' (mit Artikel)';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get declensionsSection => 'Deklinationen';

  @override
  String declChip(String n) {
    return '$n. Dekl.';
  }

  @override
  String get casesSection => 'Kasus';

  @override
  String get articleToggle => 'Artikel mit abfragen';

  @override
  String get fullKeyboardToggle => 'Griechische Volltastatur';

  @override
  String get themeSection => 'Design';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeSystem => 'System';

  @override
  String get languageSection => 'Sprache';

  @override
  String get languageSystem => 'Systemsprache';

  @override
  String get shortcutsSection => 'Tastenkürzel';

  @override
  String get shortcutsText =>
      'Enter: Prüfen / Nächstes Wort · Tab: Überspringen · Esc: Paradigma ein/aus · Leertaste: Nächstes Wort (nach Antwort)';

  @override
  String get resetStatsButton => 'Statistik zurücksetzen';

  @override
  String get resetStatsTitle => 'Statistik zurücksetzen?';

  @override
  String get resetStatsBody =>
      'Alle Zähler und Lernfortschritte werden gelöscht.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get caseNom => 'Nominativ';

  @override
  String get caseGen => 'Genitiv';

  @override
  String get caseDat => 'Dativ';

  @override
  String get caseAcc => 'Akkusativ';

  @override
  String get caseVoc => 'Vokativ';

  @override
  String get caseAbbrNom => 'Nom.';

  @override
  String get caseAbbrGen => 'Gen.';

  @override
  String get caseAbbrDat => 'Dat.';

  @override
  String get caseAbbrAcc => 'Akk.';

  @override
  String get caseAbbrVoc => 'Vok.';

  @override
  String get genderM => 'maskulin';

  @override
  String get genderF => 'feminin';

  @override
  String get genderN => 'neutrum';

  @override
  String get decl1Eta => '1. Dekl. (η)';

  @override
  String get decl1AlphaLong => '1. Dekl. (ᾱ)';

  @override
  String get decl1AlphaShort => '1. Dekl. (ᾰ)';

  @override
  String get decl1MascHs => '1. Dekl. mask. (ης)';

  @override
  String get decl1MascAs => '1. Dekl. mask. (ας)';

  @override
  String get decl2Masc => '2. Dekl. (ος)';

  @override
  String get decl2Neut => '2. Dekl. (ον)';

  @override
  String get decl3Stop => '3. Dekl. (Verschlusslaut)';

  @override
  String get decl3Nasal => '3. Dekl. (Nasal)';

  @override
  String get decl3Liquid => '3. Dekl. (Liquida)';

  @override
  String get decl3Sigma => '3. Dekl. (σ-Stamm)';

  @override
  String get decl3VowelIs => '3. Dekl. (ι-Stamm)';

  @override
  String get decl3VowelEus => '3. Dekl. (ευ-Stamm)';

  @override
  String get decl3Nt => '3. Dekl. (ντ-Stamm)';
}
