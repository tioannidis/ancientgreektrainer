# 🏛️ Altgriechisch Deklinationstrainer

Eine Progressive Web App zum Üben altgriechischer Substantiv-Deklinationen — offline-fähig, mit Lernmodus und griechischer Bildschirmtastatur.

![Status](https://img.shields.io/badge/Status-v1.1-d4a853) ![Wörter](https://img.shields.io/badge/Wortschatz-122_Substantive-6bbd6b) ![Offline](https://img.shields.io/badge/Offline-fähig-6ba3d4)

---

## Features

**Quiz-Modus** — Zufällige Abfrage einer Kasusform (Nominativ bis Vokativ, Singular & Plural). Eingabe per physischer Tastatur oder Bildschirmtastatur.

**Dreistufige Bewertung**
- ✓ **Richtig** — Buchstaben und Betonung korrekt
- ◐ **Teilrichtig** — Deklination stimmt, aber Akzente/Spiritus falsch
- ✗ **Falsch** — Wortform nicht korrekt

**Lernmodus** — Fehler-Wörter erscheinen häufiger. Teilrichtige bekommen halbe Fehlerpunkte, komplett falsche volle.

**Griechische Volltastatur** — Zuschaltbar in den Einstellungen. Enthält alle Grundbuchstaben (α–ω), Diakritika-Kombinationen, Leertaste und Backspace. Ideal ohne griechisches Tastaturlayout. Passt sich dynamisch an die Bildschirmbreite an.

**Diakritika-Leiste** — Kompakte Standardansicht mit den häufigsten Akzenten, Spiritus und Iota subscriptum.

**Lemma einfügen** — Ein Klick kopiert das Wort ins Eingabefeld, sodass nur noch die Endung angepasst werden muss.

**Überspringen** — Wörter können übersprungen werden (eigene Statistik-Kategorie).

**Paradigma-Ansicht** — Nach jeder Antwort kann die vollständige Deklinationstabelle eingeblendet werden. Die abgefragte Form wird gold hervorgehoben.

**Artikel optional** — Der bestimmte Artikel (ὁ, ἡ, τό) kann zugeschaltet werden.

**Filter** — Einschränkung auf 1., 2. und/oder 3. Deklination sowie auf bestimmte Kasus (z.B. nur Genitiv und Dativ üben, Vokativ weglassen).

**Hell-/Dunkelmodus** — Umschaltbar in den Einstellungen. Dunkelmodus mit warmen Pergamenttönen (Standard), Hellmodus mit hellen Cremetönen.

**Statistik** — Richtig, Teilrichtig (Betonung), Falsch, Serie, Quote, Übersprungen.

**Einstellungen werden gespeichert** — Alle Filter, Tastatur-Modus und Theme bleiben über Sessions hinweg erhalten (localStorage).

---

## Tastaturbedienung

Die App lässt sich komplett per Tastatur bedienen:

| Taste | Funktion |
|---|---|
| `Enter` | Antwort prüfen · Nach Antwort: nächstes Wort |
| `Tab` | Frage überspringen |
| `Esc` | Paradigma-Tabelle ein-/ausblenden (nach Antwort) |
| `Leertaste` | Nächstes Wort (nach Antwort, wenn Eingabefeld nicht fokussiert) |

Die Kürzel sind auch innerhalb der App unter **Einstellungen → Tastenkürzel** aufgelistet.

> **Tipp:** Wer kein griechisches Tastaturlayout installiert hat, kann die **Griechische Volltastatur** in den Einstellungen aktivieren und per Maus/Touch tippen.

---

## Wortschatz

122 Substantive mit je 10 expliziten Formen (5 Kasus × 2 Numeri):

| Deklination | Typ | Anzahl | Beispiele |
|---|---|---|---|
| 1. Dekl. | Feminina auf -η | 14 | ψυχή, ἀρετή, τέχνη |
| 1. Dekl. | Feminina auf -ᾱ | 8 | χώρα, σοφία, ἀλήθεια |
| 1. Dekl. | Feminina auf -ᾰ | 5 | θάλαττα, δόξα, μοῦσα |
| 1. Dekl. | Maskulina (-ης/-ας) | 7 | πολίτης, ποιητής, νεανίας |
| 2. Dekl. | Mask./Fem. auf -ος | 19 | λόγος, ἄνθρωπος, ὁδός |
| 2. Dekl. | Neutra auf -ον | 8 | ἔργον, δῶρον, βιβλίον |
| 3. Dekl. | Verschlusslaute/τ-Stämme | 15 | σῶμα, φύλαξ, ἐλπίς, γυνή |
| 3. Dekl. | Nasale (ν-Stämme) | 8 | δαίμων, Ἕλλην, ποιμήν |
| 3. Dekl. | ντ-Stämme | 5 | γέρων, ἄρχων, λέων |
| 3. Dekl. | Liquida (ρ-Stämme) | 7 | ῥήτωρ, πατήρ, μήτηρ, ἀνήρ |
| 3. Dekl. | σ-Stämme | 9 | γένος, ἔτος, κράτος |
| 3. Dekl. | ι-Stämme | 9 | πόλις, φύσις, δύναμις |
| 3. Dekl. | ευ-Stämme | 8 | βασιλεύς, ἱερεύς, ἱππεύς |

---

## Installation & Start

### Lokal (empfohlen)

```bash
# Repository klonen oder Dateien herunterladen
cd greek-trainer

# Einfachen Webserver starten (nötig wegen fetch() für JSON)
python3 -m http.server 8000

# Browser öffnen
# → http://localhost:8000
```

Alternativ mit Node.js:
```bash
npx serve .
```

### Auf einem Webserver

Alle Dateien in ein Verzeichnis kopieren:

```
greek-trainer/
├── index.html
├── style.css
├── nouns.json
├── manifest.json
└── icon.svg        ← App-Icon
```

> **Hinweis:** Die Dateien können nicht direkt per `file://` geöffnet werden, da `fetch()` einen HTTP-Server benötigt.

### Als PWA installieren

Nach dem Öffnen im Browser kann die App über das Browser-Menü „Zum Startbildschirm hinzufügen" als PWA installiert werden. Sie funktioniert dann auch offline.

---

## Wortschatz erweitern

Neue Wörter werden in `nouns.json` ergänzt. Jeder Eintrag hat folgendes Format:

```json
{
  "lemma": "φιλόσοφος",
  "gender": "m",
  "type": "2_masc",
  "meaning": "Philosoph",
  "forms": {
    "sg": {
      "nom": "φιλόσοφος",
      "gen": "φιλοσόφου",
      "dat": "φιλοσόφῳ",
      "acc": "φιλόσοφον",
      "voc": "φιλόσοφε"
    },
    "pl": {
      "nom": "φιλόσοφοι",
      "gen": "φιλοσόφων",
      "dat": "φιλοσόφοις",
      "acc": "φιλοσόφους",
      "voc": "φιλόσοφοι"
    }
  }
}
```

### Verfügbare Typen

`1_eta` · `1_alpha_long` · `1_alpha_short` · `1_masc_hs` · `1_masc_as` · `2_masc` · `2_neut` · `3_stop` · `3_nasal` · `3_liquid` · `3_sigma` · `3_vowel_is` · `3_vowel_eus` · `3_nt`

### Geschlecht

`m` (maskulin) · `f` (feminin) · `n` (neutrum)

---

## Technologie

- **Vanilla JavaScript** — kein Framework, keine Build-Tools
- **CSS Custom Properties** — Hell- und Dunkelmodus über `data-theme`-Attribut
- **Google Fonts** — Literata (Body), Noto Serif (Griechisch), JetBrains Mono (Statistik)
- **PWA-Manifest** — installierbar auf mobilen Geräten
- **localStorage** — Statistik, Lernfortschritt und Einstellungen bleiben erhalten

---

## Dateistruktur

| Datei | Beschreibung |
|---|---|
| `index.html` | Hauptseite mit Quiz-Logik (Vanilla JS) |
| `style.css` | Stylesheet (Hell-/Dunkelmodus, Pergament-Design) |
| `nouns.json` | Wortschatz mit 122 × 10 expliziten Formen |
| `manifest.json` | PWA-Manifest |
| `icon.svg` | App-Icon (Säule mit Ω) |

---

## Lizenz

Frei verwendbar für Lernzwecke. Der Wortschatz basiert auf dem Standardvokabular klassischer Lehrbücher.
