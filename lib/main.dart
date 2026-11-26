import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/generated/app_localizations.dart';
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
  final packageInfo = await PackageInfo.fromPlatform();
  runApp(TrainerApp(
    service: service,
    settings: settings,
    catalog: catalog,
    appVersion: packageInfo.version,
  ));
}

Future<NounCatalog> loadCatalog() async {
  final raw = await rootBundle.loadString('assets/nouns.json');
  return NounCatalog.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}

class TrainerApp extends StatefulWidget {
  final PrefsService service;
  final AppSettings settings;
  final NounCatalog catalog;
  final String appVersion;

  const TrainerApp({
    super.key,
    required this.service,
    required this.settings,
    required this.catalog,
    required this.appVersion,
  });

  @override
  State<TrainerApp> createState() => TrainerAppState();
}

class TrainerAppState extends State<TrainerApp> {
  late AppSettings settings;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<QuizPageState> quizKey = GlobalKey<QuizPageState>();

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  void _openSettings() {
    final nav = navigatorKey.currentState;
    if (nav == null) return;
    nav
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
      navigatorKey: navigatorKey,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      locale: settings.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.themeMode,
      home: QuizPage(
        key: quizKey,
        catalog: widget.catalog,
        prefs: widget.service,
        settings: settings,
        onOpenSettings: _openSettings,
        appVersion: widget.appVersion,
      ),
    );
  }
}
