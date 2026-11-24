import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../logic/stats.dart';
import '../settings/app_settings.dart';

class PrefsService {
  static const statsKey = 'greek_trainer_stats';
  static const errorsKey = 'greek_trainer_errors';
  static const settingsKey = 'greek_trainer_settings';

  final SharedPreferences _p;

  const PrefsService(this._p);

  Stats loadStats() {
    final raw = _p.getString(statsKey);
    if (raw == null) return Stats();
    try {
      return Stats.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return Stats();
    }
  }

  Future<void> saveStats(Stats s) => _p.setString(statsKey, jsonEncode(s.toJson()));

  Map<String, double> loadErrors() {
    final raw = _p.getString(errorsKey);
    if (raw == null) return {};
    try {
      final m = jsonDecode(raw) as Map<String, dynamic>;
      return m.map((k, v) => MapEntry(k, (v as num).toDouble()));
    } catch (_) {
      return {};
    }
  }

  Future<void> saveErrors(Map<String, double> e) =>
      _p.setString(errorsKey, jsonEncode(e));

  AppSettings loadSettings() {
    final raw = _p.getString(settingsKey);
    if (raw == null) return AppSettings();
    try {
      return AppSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return AppSettings();
    }
  }

  Future<void> saveSettings(AppSettings s) =>
      _p.setString(settingsKey, jsonEncode(s.toJson()));
}
