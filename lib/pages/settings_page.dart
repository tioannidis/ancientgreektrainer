import 'package:flutter/material.dart';

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
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Statistik zurücksetzen?'),
        content: const Text('Alle Zähler und Lernfortschritte werden gelöscht.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Zurücksetzen'),
          ),
        ],
      ),
    );
    if (ok == true) widget.onResetStats();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.settings;
    return Scaffold(
      appBar: AppBar(title: const Text('Einstellungen')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Deklinationen', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final d in ['1', '2', '3'])
                FilterChip(
                  label: Text('$d. Dekl.'),
                  selected: s.selectedDecl.contains(d),
                  onSelected: (_) {
                    setState(() => s.toggleDecl(d));
                    widget.onChanged();
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Kasus', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final c in GramCase.values)
                FilterChip(
                  label: Text('${caseNamesDe[c]!.substring(0, 3)}.'),
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
            title: const Text('Artikel mit abfragen'),
            value: s.includeArticle,
            onChanged: (v) {
              setState(() => s.includeArticle = v);
              widget.onChanged();
            },
          ),
          SwitchListTile(
            title: const Text('Griechische Volltastatur'),
            value: s.showFullKeyboard,
            onChanged: (v) {
              setState(() => s.showFullKeyboard = v);
              widget.onChanged();
            },
          ),
          const SizedBox(height: 8),
          const Text('Design', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.dark, label: Text('Dunkel')),
              ButtonSegment(value: ThemeMode.light, label: Text('Hell')),
              ButtonSegment(value: ThemeMode.system, label: Text('System')),
            ],
            selected: {s.themeMode},
            onSelectionChanged: (sel) {
              setState(() => s.themeMode = sel.first);
              widget.onChanged();
            },
          ),
          const SizedBox(height: 16),
          const Text('Tastenkürzel', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text(
            'Enter: Prüfen / Nächstes Wort · Tab: Überspringen · '
            'Esc: Paradigma ein/aus · Leertaste: Nächstes Wort (nach Antwort)',
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _confirmReset,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Statistik zurücksetzen'),
          ),
        ],
      ),
    );
  }
}
