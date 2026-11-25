import 'package:flutter/material.dart';

const List<String> diacritics = [
  'ά', 'έ', 'ή', 'ί', 'ό', 'ύ', 'ώ',
  'ᾶ', 'ῆ', 'ῖ', 'ῠ', 'ῶ',
  'ὰ', 'ὲ', 'ὴ', 'ὶ', 'ὸ', 'ὺ', 'ὼ',
  'ἀ', 'ἐ', 'ἠ', 'ἰ', 'ὀ', 'ὐ',
  'ἁ', 'ἑ', 'ἡ', 'ἱ', 'ὁ', 'ὑ',
  'ᾳ', 'ῃ', 'ῳ',
];

const List<List<String>> greekKeyboardRows = [
  ['α', 'β', 'γ', 'δ', 'ε', 'ζ', 'η', 'θ'],
  ['ι', 'κ', 'λ', 'μ', 'ν', 'ξ', 'ο', 'π'],
  ['ρ', 'σ', 'ς', 'τ', 'υ', 'φ', 'χ', 'ψ', 'ω'],
  ['ἀ', 'ἁ', 'ά', 'ᾶ', 'ὰ', 'ᾳ', 'ἐ', 'ἑ', 'έ'],
  ['ἠ', 'ἡ', 'ή', 'ῆ', 'ῃ', 'ἰ', 'ἱ', 'ί', 'ῖ'],
  ['ὀ', 'ὁ', 'ό', 'ὐ', 'ὑ', 'ύ', 'ῠ', 'ῷ', 'ώ', 'ῶ', 'ῳ'],
];

class GreekKeyboardPad extends StatelessWidget {
  final bool full;
  final void Function(String char) onInsert;
  final VoidCallback onBackspace;

  const GreekKeyboardPad({
    super.key,
    required this.full,
    required this.onInsert,
    required this.onBackspace,
  });

  Widget _key(String label, VoidCallback onTap, {bool wide = false}) {
    return Expanded(
      flex: wide ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 40),
            padding: EdgeInsets.zero,
          ),
          child: Text(label, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!full) {
      return Wrap(
        spacing: 4,
        runSpacing: 4,
        children: diacritics
            .map((d) => OutlinedButton(
                  onPressed: () => onInsert(d),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(36, 36),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(d),
                ))
            .toList(),
      );
    }
    return Column(
      children: [
        for (final row in greekKeyboardRows)
          Row(
            children: row
                .map((k) => _key(k, () => onInsert(k)))
                .toList(),
          ),
        Row(
          children: [
            _key('␣', () => onInsert(' '), wide: true),
            _key('⌫', onBackspace, wide: true),
          ],
        ),
      ],
    );
  }
}
