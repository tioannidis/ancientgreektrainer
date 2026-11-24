import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/noun.dart';
import 'pages/quiz_page.dart';
import 'pages/settings_page.dart';
import 'settings/app_settings.dart';
import 'storage/prefs.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final service = PrefsService(prefs);
  final settings = service.loadSettings();
  final catalog = await loadCatalog();
  runApp(TrainerApp(service: service, settings: settings, catalog: catalog));
}

Future<NounCatalog> loadCatalog() async {
  final raw = await rootBundle.loadString('assets/nouns.json');
  return NounCatalog.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}

class TrainerApp extends StatefulWidget {
  final PrefsService service;
  final AppSettings settings;
  final NounCatalog catalog;

  const TrainerApp({
    super.key,
    required this.service,
    required this.settings,
    required this.catalog,
  });

  @override
  State<TrainerApp> createState() => TrainerAppState();
}

class TrainerAppState extends State<TrainerApp> {
  late AppSettings settings;
  final GlobalKey<QuizPageState> quizKey = GlobalKey<QuizPageState>();

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  void _openSettings() {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (_) => SettingsPage(
              settings: settings,
              onChanged: () {
                setState(() {});
                widget.service.saveSettings(settings);
              },
              onResetStats: () => quizKey.currentState?.resetStats(),
            ),
          ),
        )
        .then((_) {
      setState(() {});
      widget.service.saveSettings(settings);
      quizKey.currentState?.refreshFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ancient Greek Trainer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.themeMode,
      home: QuizPage(
        key: quizKey,
        catalog: widget.catalog,
        prefs: widget.service,
        settings: settings,
        onOpenSettings: _openSettings,
      ),
    );
  }
}
