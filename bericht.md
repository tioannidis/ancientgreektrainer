# Bericht: Prüfung des Grammatik-Regelwerks

**Projekt:** Altgriechisch Deklinationstrainer (Flutter)
**Datum:** 2026-11-25
**Umfang:** Datenbasis `assets/nouns.json`, Artikeltabelle sowie Antwortprüfung in `lib/logic/grading.dart`

## 1. Ziel

Geprüft werden sollte, ob das grammatische Regelwerk der App korrekt ist:

1. Sind alle Substantiv-Formen (Kasus, Numerus, Genus) grammatisch richtig?
2. Ist die Artikeltabelle korrekt und wird sie korrekt angewendet?
3. Ist die Antwortprüfung (Akzente, Spiritus, Sigma-Varianten) grammatisch sinnvoll?

## 2. Vorgehen

- Vollständige Auswertung aller 122 Substantive aus `assets/nouns.json`.
- Prüfung jeder der 10 Formen (Singular/Plural × Nominativ, Genitiv, Dativ, Akkusativ, Vokativ) auf Vollständigkeit.
- Abgleich von Genus, Deklinationstyp und Formen mit den Standardparadigmen der attischen Prosa.
- Automatische Prüfung auf:
  - fehlende oder leere Formen,
  - doppelte Lemmata,
  - Anzahl der Akzente je Form,
  - vorhandene Spiritus (Psili/Dasia) bei vokal- und rho-anlautenden Wörtern,
  - Akzentlage (Antepenultima, Penultima, Zirkumflex).
- Prüfung der Artikeltabelle (`meta.articles`) je Genus, Numerus und Kasus.
- Prüfung der Prüf- und Anwendungslogik (`normalize`, `stripAccents`, `grade`, Artikeleinbindung).

## 3. Ergebnis der Inhaltsprüfung

**Die Deklinationsdaten sind grammatisch korrekt.**

- Alle 122 Substantive besitzen alle 10 Formen; keine fehlenden, leeren oder doppelten Einträge.
- Die 14 Deklinationstypen sind konsistent belegt und passend benannt:

| Typ | Anzahl | Genus |
|---|---:|---|
| `1_alpha_long` | 8 | f |
| `1_alpha_short` | 5 | f |
| `1_eta` | 14 | f |
| `1_masc_as` | 1 | m |
| `1_masc_hs` | 6 | m |
| `2_masc` | 19 | m (17), f (2: ὁδός, νῆσος) |
| `2_neut` | 8 | n |
| `3_liquid` | 7 | m (5), f (2: μήτηρ, θυγάτηρ) |
| `3_nasal` | 8 | m (7), f (1: εἰκών) |
| `3_nt` | 5 | m |
| `3_sigma` | 9 | n |
| `3_stop` | 15 | m (2), f (5), n (8) |
| `3_vowel_eus` | 8 | m |
| `3_vowel_is` | 9 | f |

- Die Klassifikation der 1. Deklination ist korrekt:
  - langes Alpha nach ε, ι, ρ (`χώρα`, `οἰκία`, `θεά`, `στρατιά`),
  - kurzes Alpha nach anderen Konsonanten (`θάλαττα`, `δόξα`, `μοῦσα`),
  - Maskulina auf -ης und -ας (`πολίτης`, `νεανίας`).
- Die 3. Deklination ist nach Stammtypen korrekt getrennt (Liquida, Nasal, ντ, σ-, ι-, ευ- und Verschlusslaut-/τ-Stämme).
- Genusangaben sind korrekt, einschließlich der Ausnahmen Femininum in der 2. Deklination (`ἡ ὁδός`, `ἡ νῆσος`) und `ἡ εἰκών`, `ἡ χάρις`, `ἡ γυνή`, `ἡ νύξ`.
- Die Stichproben der Paradigmen stimmen mit den Standardformen überein, u. a.:
  - `πολίτης` → Vok. Sg. `πολῖτα`, Nom. Pl. `πολῖται`
  - `βασιλεύς` → Gen. Sg. `βασιλέως`, Dat. Pl. `βασιλεῦσι`, Vok. Sg. `βασιλεῦ`
  - `πόλις` → Gen. Sg. `πόλεως`, Dat. Pl. `πόλεσι`
  - `γέρων` → Gen. Sg. `γέροντος`, Dat. Pl. `γέρουσι`
  - `σῶμα` → Gen. Sg. `σώματος`, Dat. Pl. `σώμασι`
  - `ἀνήρ` → Gen. Sg. `ἀνδρός`, Dat. Pl. `ἀνδράσι`
  - `ὀδούς` → Gen. Sg. `ὀδόντος`, Dat. Pl. `ὀδοῦσι`

### Akzente und Spiritus

- Jede Form enthält genau einen Akzent; keine Form ohne oder mit doppeltem Akzent.
- Alle vokal- und rho-anlautenden Wörter besitzen einen Spiritus (Psili oder Dasia), z. B. `Ἕλλην` mit Dasia, `εἰρήνη` und `ἀλήθεια` mit Psili, `ῥήτωρ` und `ὕδωρ` korrekt.
- Automatische Akzentprüfung ergab keine echten Verstöße. Die 18 auffälligen Formen (`πόλεως`, `φύσεως`, `δυνάμεως`, `πίστεως` usw.) sind korrekte attische ι-Stämme, bei denen die Endung -εως/-εων für die Akzentuierung als kurz gilt.

## 4. Artikeltabelle

Die Tabelle in `meta.articles` ist vollständig und korrekt:

| Genus | Sg. Nom. | Gen. | Dat. | Akk. | Pl. Nom. | Gen. | Dat. | Akk. |
|---|---|---|---|---|---|---|---|---|
| m | ὁ | τοῦ | τῷ | τόν | οἱ | τῶν | τοῖς | τούς |
| f | ἡ | τῆς | τῇ | τήν | αἱ | τῶν | ταῖς | τάς |
| n | τό | τοῦ | τῷ | τό | τά | τῶν | τοῖς | τά |

- Der Vokativ ist erwartungsgemäß ohne Artikel belegt.
- Die Artikel werden in `lib/logic/picker.dart` nur außerhalb des Vokativs vorangestellt; das ist grammatisch korrekt.
- Die Anzeige des Lemmas mit Artikel (`genderArticle` in `lib/models/noun.dart`) verwendet korrekt ὁ/ἡ/τό nach dem Genus, auch bei Femininformen der 2. Deklination.

## 5. Gefundener Fehler in der Prüflogik

Die **Deklinationsformen sind korrekt**, aber die Antwortprüfung behandelt die beiden Sigma-Varianten `σ` und `ς` als unterschiedliche Buchstaben.

Reproduktion (`lib/logic/grading.dart:33`):

| Eingabe | Richtige Antwort | Ergebnis | Erwartet |
|---|---|---|---|
| `λογοσ` | `λόγος` | `wrong` | `partial` (nur Akzent fehlt) |
| `πολιτησ` | `πολίτης` | `wrong` | `partial` |
| `ταῖσ` | `ταῖς` | `wrong` | `partial` |
| `ΛΟΓΟΣ` | `λόγος` | `partial` | `partial` (korrekt) |

**Ursache:** `σ` (U+03C3) und `ς` (U+03C2) sind derselbe Buchstabe; `normalize` und `stripAccents` bewahren die jeweilige Variante. `grade` vergleicht sie daher als verschieden.

**Auswirkung:** Wer am Wortende die Taste `σ` statt `ς` benutzt, bekommt die Antwort als „falsch“ statt als „teilweise richtig“ gewertet.

**Empfohlene Korrektur:** Vor dem Vergleich ausschließlich in `grade` ein Sigma-Folding durchführen (`ς` → `σ`), ohne den Rückgabewert von `stripAccents` zu verändern:

```dart
String _foldSigma(String s) => s.replaceAll('ς', 'σ');

GradeResult grade(String input, String correctAnswer) {
  final u = _foldSigma(normalize(input));
  final c = _foldSigma(normalize(correctAnswer));
  if (u == c) return GradeResult.correct;
  if (_foldSigma(stripAccents(u)) == _foldSigma(stripAccents(c))) {
    return GradeResult.partial;
  }
  return GradeResult.wrong;
}
```

Damit bleiben die bestehenden Tests zu `stripAccents` und `normalize` unverändert gültig.

## 6. Hinweis zur Architektur

Ein generatives Deklinations-Regelwerk existiert nicht. Die Formen sind explizit in `assets/nouns.json` hinterlegt und werden unverändert geladen. Die grammatische Korrektheit hängt somit an der Datenbasis; diese wurde geprüft und ist korrekt. Lediglich die Antwortbewertung sollte um das Sigma-Folding ergänzt werden.

## 7. Zusammenfassung

| Prüfpunkt | Bewertung |
|---|---|
| Formenbildung (122 Substantive × 10 Formen) | korrekt |
| Genus und Deklinationstyp | korrekt |
| Artikeltabelle und Artikelanwendung | korrekt |
| Akzente und Spiritus | korrekt |
| Sonderfälle (2. Dekl. Fem., attische ι-Stämme, unregelmäßige Stämme) | korrekt |
| Sigma-Varianten in der Prüflogik | fehlerhaft, Korrektur empfohlen |

**Gesamtfazit:** Das Grammatik-Regelwerk ist inhaltlich korrekt. Einziger Handlungsbedarf besteht in der Gleichbehandlung von `σ` und `ς` bei der Antwortprüfung.
