enum GramGender { m, f, n }

extension GramGenderX on GramGender {
  String get id => name;

  static GramGender fromId(String id) =>
      GramGender.values.firstWhere((e) => e.name == id, orElse: () => GramGender.m);
}

enum GramCase { nom, gen, dat, acc, voc }

extension GramCaseX on GramCase {
  String get id => name;

  static GramCase fromId(String id) =>
      GramCase.values.firstWhere((e) => e.name == id, orElse: () => GramCase.nom);
}

enum GramNumber { sg, pl }

const List<String> caseIds = ['nom', 'gen', 'dat', 'acc', 'voc'];
const List<String> numberIds = ['sg', 'pl'];

class Noun {
  final String lemma;
  final GramGender gender;
  final String type;
  final String meaning;
  final Map<GramNumber, Map<GramCase, String>> forms;

  const Noun({
    required this.lemma,
    required this.gender,
    required this.type,
    required this.meaning,
    required this.forms,
  });

  String? form(GramNumber number, GramCase gramCase) => forms[number]?[gramCase];

  factory Noun.fromJson(Map<String, dynamic> json) {
    final forms = <GramNumber, Map<GramCase, String>>{};
    final rawForms = json['forms'] as Map<String, dynamic>;
    for (final n in numberIds) {
      final num = GramNumber.values.firstWhere((e) => e.name == n);
      final m = <GramCase, String>{};
      final rawNum = rawForms[n] as Map<String, dynamic>;
      for (final c in caseIds) {
        final gramCase = GramCaseX.fromId(c);
        final v = rawNum[c];
        if (v != null) m[gramCase] = v as String;
      }
      forms[num] = m;
    }
    return Noun(
      lemma: json['lemma'] as String,
      gender: GramGenderX.fromId(json['gender'] as String),
      type: json['type'] as String,
      meaning: json['meaning'] as String,
      forms: forms,
    );
  }
}

class ArticleTable {
  final Map<GramGender, Map<GramNumber, Map<GramCase, String>>> byGender;

  const ArticleTable(this.byGender);

  String? article(GramGender g, GramNumber n, GramCase c) => byGender[g]?[n]?[c];

  factory ArticleTable.fromJson(Map<String, dynamic> json) {
    final out = <GramGender, Map<GramNumber, Map<GramCase, String>>>{};
    for (final g in ['m', 'f', 'n']) {
      final gender = GramGenderX.fromId(g);
      final byNum = <GramNumber, Map<GramCase, String>>{};
      final rawGender = json[g] as Map<String, dynamic>;
      for (final n in numberIds) {
        final num = GramNumber.values.firstWhere((e) => e.name == n);
        final m = <GramCase, String>{};
        final rawNum = rawGender[n] as Map<String, dynamic>;
        for (final c in caseIds) {
          final gramCase = GramCaseX.fromId(c);
          m[gramCase] = (rawNum[c] as String?) ?? '';
        }
        byNum[num] = m;
      }
      out[gender] = byNum;
    }
    return ArticleTable(out);
  }
}

class NounCatalog {
  final List<Noun> nouns;
  final ArticleTable articles;

  const NounCatalog({required this.nouns, required this.articles});

  factory NounCatalog.fromJson(Map<String, dynamic> json) {
    final nouns = (json['nouns'] as List<dynamic>)
        .map((e) => Noun.fromJson(e as Map<String, dynamic>))
        .toList();
    final meta = json['meta'] as Map<String, dynamic>;
    final articles = ArticleTable.fromJson(meta['articles'] as Map<String, dynamic>);
    return NounCatalog(nouns: nouns, articles: articles);
  }
}

const Map<GramCase, String> caseNamesDe = {
  GramCase.nom: 'Nominativ',
  GramCase.gen: 'Genitiv',
  GramCase.dat: 'Dativ',
  GramCase.acc: 'Akkusativ',
  GramCase.voc: 'Vokativ',
};

const Map<GramNumber, String> numNamesDe = {
  GramNumber.sg: 'Singular',
  GramNumber.pl: 'Plural',
};

const Map<GramGender, String> genderNamesDe = {
  GramGender.m: 'maskulin',
  GramGender.f: 'feminin',
  GramGender.n: 'neutrum',
};

const Map<GramGender, String> genderArticle = {
  GramGender.m: 'ὁ',
  GramGender.f: 'ἡ',
  GramGender.n: 'τό',
};

const Map<String, String> declLabels = {
  '1_eta': '1. Dekl. (η)',
  '1_alpha_long': '1. Dekl. (ᾱ)',
  '1_alpha_short': '1. Dekl. (ᾰ)',
  '1_masc_hs': '1. Dekl. mask. (ης)',
  '1_masc_as': '1. Dekl. mask. (ας)',
  '2_masc': '2. Dekl. (ος)',
  '2_neut': '2. Dekl. (ον)',
  '3_stop': '3. Dekl. (Verschlusslaut)',
  '3_nasal': '3. Dekl. (Nasal)',
  '3_liquid': '3. Dekl. (Liquida)',
  '3_sigma': '3. Dekl. (σ-Stamm)',
  '3_vowel_is': '3. Dekl. (ι-Stamm)',
  '3_vowel_eus': '3. Dekl. (ευ-Stamm)',
  '3_nt': '3. Dekl. (ντ-Stamm)',
};
