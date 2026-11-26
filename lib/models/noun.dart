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
  final Map<String, String> meanings;
  final Map<GramNumber, Map<GramCase, String>> forms;

  const Noun({
    required this.lemma,
    required this.gender,
    required this.type,
    required this.meanings,
    required this.forms,
  });

  String? form(GramNumber number, GramCase gramCase) => forms[number]?[gramCase];

  String meaningFor(String languageCode) =>
      meanings[languageCode] ??
      meanings['en'] ??
      (meanings.isEmpty ? '' : meanings.values.first);

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
      meanings: _parseMeanings(json),
      forms: forms,
    );
  }

  static Map<String, String> _parseMeanings(Map<String, dynamic> json) {
    final raw = json['meanings'] ?? json['meaning'];
    if (raw is Map) {
      return raw.map((key, value) => MapEntry(key as String, value as String));
    }
    if (raw is String) return {'de': raw};
    return const {};
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

const Map<GramGender, String> genderArticle = {
  GramGender.m: 'ὁ',
  GramGender.f: 'ἡ',
  GramGender.n: 'τό',
};
