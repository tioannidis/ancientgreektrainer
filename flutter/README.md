# Ancient Greek Trainer (Flutter/Android)

Native Android-App für den Altgriechisch-Deklinationstrainer. Die PWA im Repo-Root bleibt unverändert; die Logik aus `index.html` ist 1:1 nach Dart portiert (Filter, Fehlergewichtung, Antwortprüfung inkl. Akzente/Artikel, Statistik).

Lizenz: GNU GPL v3.0 (siehe `LICENSE` im Repo-Root). Nur Open-Source-Abhängigkeiten (Flutter SDK, `shared_preferences`).

## Voraussetzungen

- Flutter SDK (z. B. `brew install --cask flutter`)
- Android SDK + **Java 17** (AGP 8.x)
- Application-ID: `com.tioannidis.ancientgreektrainer`

## Start

```bash
cd flutter
flutter pub get
flutter run
```

## Tests & Build

```bash
flutter analyze
flutter test
flutter build apk --debug
```

## Wortschatz

`assets/nouns.json` ist eine Kopie aus dem Repo-Root. Änderungen am Wortschatz erfolgen in der Root-Datei (`nouns.json`) und werden manuell hierher synchronisiert:

```bash
cp ../nouns.json assets/nouns.json
```

## Persistenz

`shared_preferences` mit denselben Keys wie die PWA: `greek_trainer_settings`, `greek_trainer_stats`, `greek_trainer_errors`.
