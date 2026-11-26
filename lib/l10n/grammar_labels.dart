import '../models/noun.dart';
import 'generated/app_localizations.dart';

String caseName(AppLocalizations l10n, GramCase gramCase) => switch (gramCase) {
      GramCase.nom => l10n.caseNom,
      GramCase.gen => l10n.caseGen,
      GramCase.dat => l10n.caseDat,
      GramCase.acc => l10n.caseAcc,
      GramCase.voc => l10n.caseVoc,
    };

String caseAbbr(AppLocalizations l10n, GramCase gramCase) =>
    switch (gramCase) {
      GramCase.nom => l10n.caseAbbrNom,
      GramCase.gen => l10n.caseAbbrGen,
      GramCase.dat => l10n.caseAbbrDat,
      GramCase.acc => l10n.caseAbbrAcc,
      GramCase.voc => l10n.caseAbbrVoc,
    };

String numberName(AppLocalizations l10n, GramNumber number) =>
    number == GramNumber.sg ? l10n.singular : l10n.plural;

String genderName(AppLocalizations l10n, GramGender gender) =>
    switch (gender) {
      GramGender.m => l10n.genderM,
      GramGender.f => l10n.genderF,
      GramGender.n => l10n.genderN,
    };

String declensionLabel(AppLocalizations l10n, String type) =>
    switch (type) {
      '1_eta' => l10n.decl1Eta,
      '1_alpha_long' => l10n.decl1AlphaLong,
      '1_alpha_short' => l10n.decl1AlphaShort,
      '1_masc_hs' => l10n.decl1MascHs,
      '1_masc_as' => l10n.decl1MascAs,
      '2_masc' => l10n.decl2Masc,
      '2_neut' => l10n.decl2Neut,
      '3_stop' => l10n.decl3Stop,
      '3_nasal' => l10n.decl3Nasal,
      '3_liquid' => l10n.decl3Liquid,
      '3_sigma' => l10n.decl3Sigma,
      '3_vowel_is' => l10n.decl3VowelIs,
      '3_vowel_eus' => l10n.decl3VowelEus,
      '3_nt' => l10n.decl3Nt,
      _ => type,
    };
