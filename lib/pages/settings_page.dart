import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../l10n/grammar_labels.dart';
import '../l10n/languages.dart';
import '../models/noun.dart';
import '../settings/app_settings.dart';

class SettingsPage extends StatefulWidget {
  final AppSettings settings;
  final VoidCallback onChanged;
  final VoidCallback onResetStats;

  const SettingsPage({
    super.key,
    required this.settings,
    required this.onChanged,
    required this.onResetStats,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _confirmReset() async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.resetStatsTitle),
        content: Text(l10n.resetStatsBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.reset),
          ),
        ],
      ),
    );
    if (ok == true) widget.onResetStats();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = widget.settings;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.declensionsSection,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final d in ['1', '2', '3'])
                FilterChip(
                  label: Text(l10n.declChip(d)),
                  selected: s.selectedDecl.contains(d),
                  onSelected: (_) {
                    setState(() => s.toggleDecl(d));
                    widget.onChanged();
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(l10n.casesSection,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final c in GramCase.values)
                FilterChip(
                  label: Text(caseAbbr(l10n, c)),
                  selected: s.selectedCases.contains(c),
                  onSelected: (_) {
                    setState(() => s.toggleCase(c));
                    widget.onChanged();
                  },
                ),
            ],
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: Text(l10n.articleToggle),
            value: s.includeArticle,
            onChanged: (v) {
              setState(() => s.includeArticle = v);
              widget.onChanged();
            },
          ),
          SwitchListTile(
            title: Text(l10n.fullKeyboardToggle),
            value: s.showFullKeyboard,
            onChanged: (v) {
              setState(() => s.showFullKeyboard = v);
              widget.onChanged();
            },
          ),
          const SizedBox(height: 8),
          Text(l10n.themeSection,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(value: ThemeMode.dark, label: Text(l10n.themeDark)),
              ButtonSegment(
                  value: ThemeMode.light, label: Text(l10n.themeLight)),
              ButtonSegment(
                  value: ThemeMode.system, label: Text(l10n.themeSystem)),
            ],
            selected: {s.themeMode},
            onSelectionChanged: (sel) {
              setState(() => s.themeMode = sel.first);
              widget.onChanged();
            },
          ),
          const SizedBox(height: 16),
          Text(l10n.languageSection,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          InputDecorator(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: s.language,
                items: [
                  DropdownMenuItem(
                    value: systemLanguageCode,
                    child: Text(l10n.languageSystem),
                  ),
                  for (final language in supportedAppLanguages)
                    DropdownMenuItem(
                      value: language.code,
                      child: Text(language.nativeName),
                    ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => s.language = value);
                  widget.onChanged();
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.shortcutsSection,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(l10n.shortcutsText),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _confirmReset,
            icon: const Icon(Icons.delete_outline),
            label: Text(l10n.resetStatsButton),
          ),
        ],
      ),
    );
  }
}
