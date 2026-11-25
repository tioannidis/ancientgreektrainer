import 'package:flutter/material.dart';

import '../models/noun.dart';

class AppSettings {
  Set<String> selectedDecl;
  List<GramCase> selectedCases;
  bool includeArticle;
  bool showFullKeyboard;
  ThemeMode themeMode;

  AppSettings({
    Set<String>? selectedDecl,
    List<GramCase>? selectedCases,
    this.includeArticle = false,
    this.showFullKeyboard = false,
    this.themeMode = ThemeMode.dark,
  })  : selectedDecl = selectedDecl ?? {'1', '2', '3'},
        selectedCases = selectedCases ?? GramCase.values.toList();

  void toggleDecl(String d) {
    if (selectedDecl.contains(d)) {
      if (selectedDecl.length > 1) selectedDecl.remove(d);
    } else {
      selectedDecl.add(d);
    }
  }

  void toggleCase(GramCase c) {
    if (selectedCases.contains(c)) {
      if (selectedCases.length > 1) selectedCases.remove(c);
    } else {
      selectedCases.add(c);
    }
  }

  Map<String, dynamic> toJson() => {
        'selectedDecl': selectedDecl.toList(),
        'selectedCases': selectedCases.map((c) => c.id).toList(),
        'includeArticle': includeArticle,
        'showFullKeyboard': showFullKeyboard,
        'themeMode': themeMode.name,
      };

  factory AppSettings.fromJson(Map<String, dynamic> j) {
    ThemeMode themeMode;
    if (j['themeMode'] is String) {
      themeMode = ThemeMode.values.firstWhere(
        (t) => t.name == j['themeMode'],
        orElse: () => ThemeMode.dark,
      );
    } else if (j['darkMode'] is bool) {
      themeMode = (j['darkMode'] as bool) ? ThemeMode.dark : ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    return AppSettings(
      selectedDecl:
          (j['selectedDecl'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
              {'1', '2', '3'},
      selectedCases: (j['selectedCases'] as List<dynamic>?)
              ?.map((e) => GramCaseX.fromId(e as String))
              .toList() ??
          GramCase.values.toList(),
      includeArticle: j['includeArticle'] as bool? ?? false,
      showFullKeyboard: j['showFullKeyboard'] as bool? ?? false,
      themeMode: themeMode,
    );
  }
}
