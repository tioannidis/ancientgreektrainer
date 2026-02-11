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
