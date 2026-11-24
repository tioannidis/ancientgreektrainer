 UX-Optimierungsplan: Altgriechisch Deklinationstrainer

## Problem
Die App funktioniert inhaltlich gut, hat aber mehrere UX-Schwächen: volles DOM-Rerendering bei jeder Interaktion (Focus-Verlust, Flackern), fehlendes visuelles Feedback, mobile Schwächen, fehlende Accessibility und wenig Motivation/Gamification-Elemente.

## Ansatz
Schrittweise Verbesserung der UX in 6 Kategorien, von kritisch (DOM-Rerendering) bis nice-to-have (Gamification). Alle Änderungen erfolgen in `index.html` und `style.css` (Vanilla JS, kein Framework).

---

## Workplan

### Phase 1: Kritische Interaktions-Bugs
- [x] **1.1 Focus-Erhalt nach Render** – Nach `render()` den Cursor zuverlässig ins Eingabefeld setzen, auch nach Diacritics/Keyboard-Klick
- [x] **1.2 Filter-Änderung ohne Fragenverlust** – Deklinationsfilter- und Kasusfilter-Chips sollen die aktuelle Frage NICHT verwerfen, sondern erst beim nächsten Wort greifen (kein `pickNext()` beim Toggle)
- [x] **1.3 Leeres Eingabefeld nach "Nächstes Wort"** – Sicherstellen, dass das Eingabefeld nach Fragewechsel leer und fokussiert ist

- Hinweis: Zusätzliche Korrekturen umgesetzt: Fokus wird nicht auf das Eingabefeld gesetzt, wenn das Einstellungen-Panel geöffnet ist; kleinere Template-Syntaxfixes behoben.

### Phase 2: Visuelles Feedback & Animationen
- [x] **2.1 Card-Transition bei neuem Wort** – Sanfte fade/slide-Animation beim Wechsel zur nächsten Frage (CSS `@keyframes`) 
- [x] **2.2 Feedback-Animation** – Richtig/Falsch/Partial-Feedback mit kurzem Pulse/Shake-Effekt
(Entfernt) - **2.3 Streak-Feier** – Bei Streak-Meilensteinen (5, 10, 25…) kurze visuelle Hervorhebung des Streak-Zählers
(Entfernt) - **2.4 Button-Feedback** – "Prüfen"-Button zeigt kurzes visuelles Feedback (disable + Ladeindikator) gegen Doppelklick
- [x] **2.5 Diacritics/Keyboard-Buttons** – Aktives visuelles Feedback beim Drücken (`:active`-State verbessern)

### Phase 3: Mobile UX
- [ ] **3.1 Stats-Leiste responsiver** – Auf kleinen Screens (< 380px) die Stats in 2 Zeilen oder als scrollbare Leiste
- [ ] **3.2 Touch-Optimierung** – Größere Touch-Targets für Chips und Toggle-Switches (min. 44px)
- [ ] **3.3 Viewport-Anpassung bei Tastatur** – `visualViewport`-API nutzen um Scroll-Verhalten bei eingeblendeter Soft-Keyboard zu verbessern
- [ ] **3.4 Swipe-Geste** – Nach Beantwortung: Swipe-Right für "Nächstes Wort" (optional, nur wenn natürlich integrierbar)

### Phase 4: Accessibility
- [ ] **4.1 ARIA-Labels** – Semantische Labels für Quiz-Card, Input, Buttons, Stats
- [ ] **4.2 Live-Regions** – `aria-live="polite"` für Feedback-Bereich, damit Screen-Reader Ergebnisse vorlesen
- [ ] **4.3 Focus-Management** – Nach Antwort: Focus auf Feedback oder "Nächstes Wort"-Button
- [ ] **4.4 Farb-Kontrast prüfen** – Sicherstellen, dass alle Text/Hintergrund-Kombinationen WCAG AA erfüllen
- [ ] **4.5 Keyboard-Navigation** – Sicherstellen, dass alle interaktiven Elemente per Tab erreichbar sind

### Phase 5: Motivation & Gamification
- [ ] **5.1 Best-Streak-Anzeige** – `bestStreak` in der Stats-Leiste anzeigen (existiert bereits im State, wird aber nicht angezeigt)
- [ ] **5.2 Session-Zusammenfassung** – Optionaler Button "Session beenden" mit Zusammenfassung (Richtig/Falsch/Quote dieser Session)
- [ ] **5.3 Fortschrittsindikator** – Visueller Hinweis, wie viele Wörter bereits geübt wurden (z.B. "42/122 geübt")
- [ ] **5.4 Ermutigung bei Fehlern** – Nach mehreren Fehlern in Folge einen ermutigenden Hinweis ("Tipp: Schau dir das Paradigma an!")

### Phase 6: Kleinere UX-Verbesserungen
- [ ] **6.1 Smooth Scroll zu Paradigma** – Paradigma-Tabelle sanft einblenden statt nur einblenden
- [ ] **6.2 Einstellungen-Panel Animation** – Sanftes Slide-Down/Up statt harter Toggle
- [ ] **6.3 Bestätigungsdialog bei "Statistik zurücksetzen"** – Ungewolltes Zurücksetzen verhindern
- [ ] **6.4 Copy-Button Feedback** – Nach "📋 einfügen" kurzes visuelles Feedback ("✓ eingefügt")
- [ ] **6.5 Letztes Ergebnis merken** – Bei Seitenneuladung die letzte Frage nicht verlieren (optional)

---

## Technische Hinweise
- Alle Änderungen in `index.html` (JS) und `style.css` – kein Build-Tool nötig
- Kein Framework-Wechsel – das Vanilla-JS-Paradigma bleibt erhalten
- DOM-Rerendering komplett zu eliminieren wäre ein großer Refactor; stattdessen fokussieren wir auf **Symptombehandlung** (Focus-Restore, CSS-Transitions) als pragmatischen Ansatz
- Reihenfolge der Phasen entspricht der Priorität (1 = höchste)

## Risiken
- Phase 3.4 (Swipe) könnte Scroll-Konflikte verursachen → nur implementieren wenn sauber machbar
- Phase 5.3 (Fortschritt) erfordert Tracking welche Wörter bereits geübt wurden → neuer localStorage-Key

---

# Android-App (Flutter) – Plan

## Ziel
Native Android-App für den Deklinationstrainer, Flutter-Projekt im Unterordner `flutter/`. Die PWA im Root bleibt unverändert. Umfang: komplette Settings-Seite inkl. Dark Mode, Logik aus `index.html` nach Dart portiert.

## Voraussetzungen
- [ ] **V.1 Flutter SDK** – Auf diesem Mac nicht installiert (`flutter` nicht im PATH). Installation z. B. über `brew install --cask flutter`
- [ ] **V.2 Android SDK** – `~/Library/Android` ist ein Symlink auf `/Volumes/SSD/Android`. Vorhandensein des Ziels ist noch ungeprüft.
- [ ] **V.3 Java** – `openjdk 25` vorhanden. Für AGP 8.x ist Java 17 das sichere Target.

## Entscheidungen
- Application-ID: offen (Vorschlag `com.theo.ancientgreektrainer`)
- Verteilung: offen (F-Droid mit fastlane-Metadaten wie TipsplitAndroid, oder nur APK)
- `nouns.json` wird als Asset in die App kopiert. Die Root-Datei bleibt Quelle der PWA, Synchronisation erfolgt manuell.

## Workplan

### Phase A: Projektgerüst
- [ ] **A.1 Projekt anlegen** – `flutter create` im Unterordner `flutter/`, Application-ID setzen
- [ ] **A.2 Daten einbinden** – `nouns.json` nach `flutter/assets/` kopieren und in `pubspec.yaml` eintragen

### Phase B: Domänenlogik (ohne UI-Abhängigkeiten)
- [ ] **B.1 Modelle** – `Noun` mit Typ, Genus, Stamm, Formen; Parsing aus `nouns.json`
- [ ] **B.2 Filter** – Deklinationsfilter analog `applyFilters` (`index.html:377`), Fallback auf alle Wörter bei leerer Auswahl
- [ ] **B.3 Fragenauswahl** – Fehlergewichtung analog `pickNext` (`index.html:386`)
- [ ] **B.4 Antwortprüfung** – Richtig / Teilweise / Falsch inklusive Akzent- und Artikelbehandlung wie in der PWA
- [ ] **B.5 Stats** – Richtig, Falsch, Streak, bestStreak, Skipped, Fehlerzähler pro Wort

### Phase C: Persistenz
- [ ] **C.1 shared_preferences** – Settings und Stats speichern, Keys an die PWA angelehnt (`greek_trainer_settings`, `greek_trainer_stats`, `greek_trainer_errors`)
- [ ] **C.2 Laden beim Start** – Defaults wie in der PWA (`darkMode = true`, alle Deklinationen und Kasus aktiv)

### Phase D: Theme und Settings
- [ ] **D.1 Theme** – `ThemeMode` mit Dunkel (Default), Hell und System. Farben aus `style.css` als `ThemeData` übernehmen
- [ ] **D.2 Settings-Seite** – Alle Punkte aus `index.html:580–633`: Deklination, Kasus, Artikel abfragen, griechische Volltastatur, Dark Mode, Tastenkürzel-Info, Statistik zurücksetzen (mit Bestätigung)
- [ ] **D.3 Hauptscreen** – Frage, Eingabe, griechische Zeichen-Buttons, Feedback, Stats-Leiste

### Phase E: Tests und Verifikation
- [ ] **E.1 Unit-Tests** – Filter, Fragenauswahl, Antwortprüfung (inkl. Unicode/Akzente)
- [ ] **E.2 Widget-Tests** – Settings-Toggle, Theme-Wechsel, Eingabe und Feedback
- [ ] **E.3 Analyse** – `flutter analyze` ohne Fehler
- [ ] **E.4 Tests** – `flutter test` grün
- [ ] **E.5 Build** – `flutter build apk --debug`
- [ ] **E.6 Gerätetest** – Theme und Einstellungen überleben einen Neustart

## Risiken
- Doppelte Pflege der Logik (PWA und Flutter). Abweichungen sind möglich, deshalb Unit-Tests gegen dieselben Beispielfälle aus `nouns.json`.
- Akzent- und Artikelprüfung muss exakt dem Verhalten der PWA entsprechen, sonst entstehen unterschiedliche Ergebnisse je nach Plattform.
