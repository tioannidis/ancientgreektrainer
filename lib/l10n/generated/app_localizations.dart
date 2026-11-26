import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Declension Trainer'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ancient Greek · {count} nouns v{version}'**
  String appSubtitle(int count, String version);

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// No description provided for @statsCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get statsCorrect;

  /// No description provided for @statsPartial.
  ///
  /// In en, this message translates to:
  /// **'Accent'**
  String get statsPartial;

  /// No description provided for @statsWrong.
  ///
  /// In en, this message translates to:
  /// **'Wrong'**
  String get statsWrong;

  /// No description provided for @statsStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get statsStreak;

  /// No description provided for @statsAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get statsAccuracy;

  /// No description provided for @statsSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get statsSkipped;

  /// No description provided for @feedbackCorrect.
  ///
  /// In en, this message translates to:
  /// **'✓ Correct! {answer}'**
  String feedbackCorrect(String answer);

  /// No description provided for @feedbackPartial.
  ///
  /// In en, this message translates to:
  /// **'◐ Almost! The declension is right, but the accent is wrong.\nCorrect: {answer}'**
  String feedbackPartial(String answer);

  /// No description provided for @feedbackWrong.
  ///
  /// In en, this message translates to:
  /// **'✗ Wrong. The correct answer is: {answer}'**
  String feedbackWrong(String answer);

  /// No description provided for @feedbackSkipped.
  ///
  /// In en, this message translates to:
  /// **'» Skipped. The answer would be: {answer}'**
  String feedbackSkipped(String answer);

  /// No description provided for @fullParadigm.
  ///
  /// In en, this message translates to:
  /// **'Full paradigm'**
  String get fullParadigm;

  /// No description provided for @singular.
  ///
  /// In en, this message translates to:
  /// **'Singular'**
  String get singular;

  /// No description provided for @plural.
  ///
  /// In en, this message translates to:
  /// **'Plural'**
  String get plural;

  /// No description provided for @insertLemma.
  ///
  /// In en, this message translates to:
  /// **'Insert lemma'**
  String get insertLemma;

  /// No description provided for @answerHint.
  ///
  /// In en, this message translates to:
  /// **'Your answer…'**
  String get answerHint;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip »'**
  String get skip;

  /// No description provided for @hideTable.
  ///
  /// In en, this message translates to:
  /// **'Hide table'**
  String get hideTable;

  /// No description provided for @fullDeclension.
  ///
  /// In en, this message translates to:
  /// **'Full declension'**
  String get fullDeclension;

  /// No description provided for @nextWord.
  ///
  /// In en, this message translates to:
  /// **'Next word →'**
  String get nextWord;

  /// No description provided for @buildForm.
  ///
  /// In en, this message translates to:
  /// **'Form the {gramCase} {number}{articleHint}:'**
  String buildForm(String number, String articleHint, String gramCase);

  /// No description provided for @withArticleSuffix.
  ///
  /// In en, this message translates to:
  /// **' (with article)'**
  String get withArticleSuffix;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @declensionsSection.
  ///
  /// In en, this message translates to:
  /// **'Declensions'**
  String get declensionsSection;

  /// No description provided for @declChip.
  ///
  /// In en, this message translates to:
  /// **'{n, select, 1{1st decl.} 2{2nd decl.} 3{3rd decl.} other{{n}. decl.}}'**
  String declChip(String n);

  /// No description provided for @casesSection.
  ///
  /// In en, this message translates to:
  /// **'Cases'**
  String get casesSection;

  /// No description provided for @articleToggle.
  ///
  /// In en, this message translates to:
  /// **'Ask for article'**
  String get articleToggle;

  /// No description provided for @fullKeyboardToggle.
  ///
  /// In en, this message translates to:
  /// **'Full Greek keyboard'**
  String get fullKeyboardToggle;

  /// No description provided for @themeSection.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeSection;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @languageSection.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSection;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System language'**
  String get languageSystem;

  /// No description provided for @shortcutsSection.
  ///
  /// In en, this message translates to:
  /// **'Keyboard shortcuts'**
  String get shortcutsSection;

  /// No description provided for @shortcutsText.
  ///
  /// In en, this message translates to:
  /// **'Enter: Check / Next word · Tab: Skip · Esc: Toggle paradigm · Space: Next word (after answering)'**
  String get shortcutsText;

  /// No description provided for @resetStatsButton.
  ///
  /// In en, this message translates to:
  /// **'Reset statistics'**
  String get resetStatsButton;

  /// No description provided for @resetStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset statistics?'**
  String get resetStatsTitle;

  /// No description provided for @resetStatsBody.
  ///
  /// In en, this message translates to:
  /// **'All counters and learning progress will be deleted.'**
  String get resetStatsBody;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @caseNom.
  ///
  /// In en, this message translates to:
  /// **'Nominative'**
  String get caseNom;

  /// No description provided for @caseGen.
  ///
  /// In en, this message translates to:
  /// **'Genitive'**
  String get caseGen;

  /// No description provided for @caseDat.
  ///
  /// In en, this message translates to:
  /// **'Dative'**
  String get caseDat;

  /// No description provided for @caseAcc.
  ///
  /// In en, this message translates to:
  /// **'Accusative'**
  String get caseAcc;

  /// No description provided for @caseVoc.
  ///
  /// In en, this message translates to:
  /// **'Vocative'**
  String get caseVoc;

  /// No description provided for @caseAbbrNom.
  ///
  /// In en, this message translates to:
  /// **'Nom.'**
  String get caseAbbrNom;

  /// No description provided for @caseAbbrGen.
  ///
  /// In en, this message translates to:
  /// **'Gen.'**
  String get caseAbbrGen;

  /// No description provided for @caseAbbrDat.
  ///
  /// In en, this message translates to:
  /// **'Dat.'**
  String get caseAbbrDat;

  /// No description provided for @caseAbbrAcc.
  ///
  /// In en, this message translates to:
  /// **'Acc.'**
  String get caseAbbrAcc;

  /// No description provided for @caseAbbrVoc.
  ///
  /// In en, this message translates to:
  /// **'Voc.'**
  String get caseAbbrVoc;

  /// No description provided for @genderM.
  ///
  /// In en, this message translates to:
  /// **'masculine'**
  String get genderM;

  /// No description provided for @genderF.
  ///
  /// In en, this message translates to:
  /// **'feminine'**
  String get genderF;

  /// No description provided for @genderN.
  ///
  /// In en, this message translates to:
  /// **'neuter'**
  String get genderN;

  /// No description provided for @decl1Eta.
  ///
  /// In en, this message translates to:
  /// **'1st decl. (η)'**
  String get decl1Eta;

  /// No description provided for @decl1AlphaLong.
  ///
  /// In en, this message translates to:
  /// **'1st decl. (ᾱ)'**
  String get decl1AlphaLong;

  /// No description provided for @decl1AlphaShort.
  ///
  /// In en, this message translates to:
  /// **'1st decl. (ᾰ)'**
  String get decl1AlphaShort;

  /// No description provided for @decl1MascHs.
  ///
  /// In en, this message translates to:
  /// **'1st decl. masc. (ης)'**
  String get decl1MascHs;

  /// No description provided for @decl1MascAs.
  ///
  /// In en, this message translates to:
  /// **'1st decl. masc. (ας)'**
  String get decl1MascAs;

  /// No description provided for @decl2Masc.
  ///
  /// In en, this message translates to:
  /// **'2nd decl. (ος)'**
  String get decl2Masc;

  /// No description provided for @decl2Neut.
  ///
  /// In en, this message translates to:
  /// **'2nd decl. (ον)'**
  String get decl2Neut;

  /// No description provided for @decl3Stop.
  ///
  /// In en, this message translates to:
  /// **'3rd decl. (stop)'**
  String get decl3Stop;

  /// No description provided for @decl3Nasal.
  ///
  /// In en, this message translates to:
  /// **'3rd decl. (nasal)'**
  String get decl3Nasal;

  /// No description provided for @decl3Liquid.
  ///
  /// In en, this message translates to:
  /// **'3rd decl. (liquid)'**
  String get decl3Liquid;

  /// No description provided for @decl3Sigma.
  ///
  /// In en, this message translates to:
  /// **'3rd decl. (σ-stem)'**
  String get decl3Sigma;

  /// No description provided for @decl3VowelIs.
  ///
  /// In en, this message translates to:
  /// **'3rd decl. (ι-stem)'**
  String get decl3VowelIs;

  /// No description provided for @decl3VowelEus.
  ///
  /// In en, this message translates to:
  /// **'3rd decl. (ευ-stem)'**
  String get decl3VowelEus;

  /// No description provided for @decl3Nt.
  ///
  /// In en, this message translates to:
  /// **'3rd decl. (ντ-stem)'**
  String get decl3Nt;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
