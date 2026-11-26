import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/generated/app_localizations.dart';
import '../l10n/grammar_labels.dart';
import '../logic/filters.dart';
import '../logic/grading.dart';
import '../logic/picker.dart';
import '../logic/stats.dart';
import '../models/noun.dart';
import '../settings/app_settings.dart';
import '../storage/prefs.dart';
import '../theme/app_theme.dart';
import '../widgets/greek_keyboard.dart';

class QuizPage extends StatefulWidget {
  final NounCatalog catalog;
  final PrefsService prefs;
  final AppSettings settings;
  final VoidCallback onOpenSettings;
  final String appVersion;

  const QuizPage({
    super.key,
    required this.catalog,
    required this.prefs,
    required this.settings,
    required this.onOpenSettings,
    required this.appVersion,
  });

  @override
  State<QuizPage> createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  late Stats stats;
  late Map<String, double> errorCounts;
  late List<Noun> filtered;
  Question? question;
  GradeResult? gradeResult;
  bool skipped = false;
  bool showParadigm = false;
  final TextEditingController input = TextEditingController();
  final FocusNode inputFocus = FocusNode();
  final FocusNode keysFocus = FocusNode();

  bool get answered => gradeResult != null || skipped;

  @override
  void initState() {
    super.initState();
    stats = widget.prefs.loadStats();
    errorCounts = widget.prefs.loadErrors();
    filtered = applyFilters(widget.catalog.nouns, widget.settings.selectedDecl);
    _next();
  }

  @override
  void dispose() {
    input.dispose();
    inputFocus.dispose();
    keysFocus.dispose();
    super.dispose();
  }

  void refreshFilters() {
    setState(() {
      filtered = applyFilters(widget.catalog.nouns, widget.settings.selectedDecl);
    });
  }

  void resetStats() {
    setState(() {
      stats = Stats();
      errorCounts = {};
    });
    _persist();
  }

  void _persist() {
    widget.prefs.saveStats(stats);
    widget.prefs.saveErrors(errorCounts);
  }

  void _next() {
    setState(() {
      question = pickNext(
        filtered: filtered,
        errorCounts: errorCounts,
        selectedCases: widget.settings.selectedCases,
        includeArticle: widget.settings.includeArticle,
        catalog: widget.catalog,
        currentNoun: question?.noun,
      );
      input.clear();
      gradeResult = null;
      skipped = false;
      showParadigm = false;
    });
  }

  void _check() {
    final v = input.text.trim();
    final q = question;
    if (v.isEmpty || q == null) return;
    final r = grade(v, q.correctAnswer);
    applyGrade(stats, errorCounts, q.noun.lemma, r);
    setState(() => gradeResult = r);
    _persist();
  }

  void _skip() {
    applySkip(stats);
    setState(() => skipped = true);
    _persist();
  }

  void _insert(String ch) {
    if (answered) return;
    final sel = input.selection;
    final text = input.text;
    final start = sel.isValid ? sel.start : text.length;
    final end = sel.isValid ? sel.end : text.length;
    input.value = TextEditingValue(
      text: text.replaceRange(start, end, ch),
      selection: TextSelection.collapsed(offset: start + ch.length),
    );
  }

  void _backspace() {
    if (answered) return;
    final sel = input.selection;
    final text = input.text;
    if (sel.isValid && !sel.isCollapsed) {
      input.value = TextEditingValue(
        text: text.replaceRange(sel.start, sel.end, ''),
        selection: TextSelection.collapsed(offset: sel.start),
      );
    } else if (sel.isValid && sel.start > 0) {
      input.value = TextEditingValue(
        text: text.replaceRange(sel.start - 1, sel.start, ''),
        selection: TextSelection.collapsed(offset: sel.start - 1),
      );
    }
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (!answered) {
        _check();
      } else {
        _next();
      }
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.escape && answered) {
      setState(() => showParadigm = !showParadigm);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.tab && !answered) {
      _skip();
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.space &&
        answered &&
        !inputFocus.hasFocus) {
      _next();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  Widget _statItem(String value, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  Widget _statsBar(ColorScheme cs) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          spacing: 12,
          runSpacing: 4,
          children: [
            _statItem('${stats.correct}', l10n.statsCorrect, isDark ? AppTheme.correctDark : AppTheme.correctLight),
            _statItem('${stats.partial}', l10n.statsPartial, isDark ? AppTheme.goldDark : AppTheme.goldLight),
            _statItem('${stats.wrong}', l10n.statsWrong, isDark ? AppTheme.wrongDark : AppTheme.wrongLight),
            _statItem('${stats.streak}', l10n.statsStreak, isDark ? AppTheme.blueDark : AppTheme.blueLight),
            _statItem('${stats.pct}%', l10n.statsAccuracy, cs.onSurface),
            if (stats.skipped > 0) _statItem('${stats.skipped}', l10n.statsSkipped, cs.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  Widget _feedback(ColorScheme cs) {
    final q = question;
    if (q == null) return const SizedBox.shrink();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    if (gradeResult == GradeResult.correct) {
      return _feedbackBox(l10n.feedbackCorrect(q.correctAnswer),
          isDark ? AppTheme.correctDark : AppTheme.correctLight);
    }
    if (gradeResult == GradeResult.partial) {
      return _feedbackBox(l10n.feedbackPartial(q.correctAnswer),
          isDark ? AppTheme.goldDark : AppTheme.goldLight);
    }
    if (gradeResult == GradeResult.wrong) {
      return _feedbackBox(l10n.feedbackWrong(q.correctAnswer),
          isDark ? AppTheme.wrongDark : AppTheme.wrongLight);
    }
    if (skipped) {
      return _feedbackBox(
          l10n.feedbackSkipped(q.correctAnswer), cs.onSurfaceVariant);
    }
    return const SizedBox.shrink();
  }

  Widget _feedbackBox(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(color: color)),
    );
  }

  Widget _paradigm(Question q) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final gold = isDark ? AppTheme.goldDark : AppTheme.goldLight;
    final art = widget.catalog.articles;
    TableRow row(GramCase c) {
      final isHl = c == q.gramCase;
      String withArt(String? f, GramNumber n) {
        if (f == null) return '—';
        final a = (widget.settings.includeArticle && c != GramCase.voc)
            ? art.article(q.noun.gender, n, c)
            : null;
        return (a != null && a.isNotEmpty) ? '$a $f' : f;
      }
      return TableRow(
        decoration: isHl ? BoxDecoration(color: gold.withValues(alpha: 0.15)) : null,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(caseAbbr(l10n, c)),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(withArt(q.noun.form(GramNumber.sg, c), GramNumber.sg),
                style: TextStyle(
                    fontWeight: isHl && q.number == GramNumber.sg ? FontWeight.bold : null,
                    color: isHl && q.number == GramNumber.sg ? gold : cs.onSurface)),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(withArt(q.noun.form(GramNumber.pl, c), GramNumber.pl),
                style: TextStyle(
                    fontWeight: isHl && q.number == GramNumber.pl ? FontWeight.bold : null,
                    color: isHl && q.number == GramNumber.pl ? gold : cs.onSurface)),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(l10n.fullParadigm, style: TextStyle(fontWeight: FontWeight.bold, color: cs.onSurface)),
        const SizedBox(height: 4),
        Table(
          columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth(), 2: FlexColumnWidth()},
          children: [
            TableRow(
              children: ['', l10n.singular, l10n.plural]
                  .map((h) => Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(h, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ))
                  .toList(),
            ),
            for (final c in GramCase.values) row(c),
          ],
        ),
      ],
    );
  }

  Widget _card(BuildContext context, Question q) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final noun = q.noun;
    final declLabel = declensionLabel(l10n, noun.type);
    final articleHint = widget.settings.includeArticle && q.gramCase != GramCase.voc
        ? l10n.withArticleSuffix
        : '';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('$declLabel · ${genderName(l10n, noun.gender)}',
                style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${genderArticle[noun.gender]} ${noun.lemma}',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  tooltip: l10n.insertLemma,
                  icon: const Icon(Icons.copy),
                  onPressed: answered ? null : () => setState(() => input.text = noun.lemma),
                ),
              ],
            ),
            Text('»${noun.meaningFor(languageCode)}«',
                style: TextStyle(color: cs.onSurfaceVariant)),
            const SizedBox(height: 12),
            Text(
              l10n.buildForm(
                numberName(l10n, q.number),
                articleHint,
                caseName(l10n, q.gramCase),
              ),
              style: const TextStyle(fontSize: 16),
            ),
            if (!answered) ...[
              const SizedBox(height: 8),
              GreekKeyboardPad(
                full: widget.settings.showFullKeyboard,
                onInsert: _insert,
                onBackspace: _backspace,
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: input,
                    focusNode: inputFocus,
                    readOnly: answered,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(hintText: l10n.answerHint),
                    onSubmitted: (_) => answered ? _next() : _check(),
                  ),
                ),
                const SizedBox(width: 8),
                if (!answered)
                  FilledButton(onPressed: _check, child: Text(l10n.check)),
              ],
            ),
            if (!answered) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: _skip, child: Text(l10n.skip)),
              ),
            ],
            if (answered) ...[
              const SizedBox(height: 12),
              _feedback(cs),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => showParadigm = !showParadigm),
                      child: Text(showParadigm ? l10n.hideTable : l10n.fullDeclension),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      onPressed: _next,
                      child: Text(l10n.nextWord),
                    ),
                  ),
                ],
              ),
            ],
            if (showParadigm) _paradigm(q),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final q = question;
    return Focus(
      focusNode: keysFocus,
      autofocus: true,
      onKeyEvent: _onKey,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.appTitle, style: const TextStyle(fontSize: 18)),
              Text(
                l10n.appSubtitle(filtered.length, widget.appVersion),
                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: l10n.settingsTooltip,
              onPressed: widget.onOpenSettings,
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _statsBar(cs),
                const SizedBox(height: 12),
                if (q != null) _card(context, q),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
