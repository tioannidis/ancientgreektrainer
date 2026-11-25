import '../models/noun.dart';

List<Noun> applyFilters(List<Noun> all, Set<String> selectedDecl) {
  final filtered = all
      .where((n) => selectedDecl.contains(n.type.substring(0, 1)))
      .toList();
  if (filtered.isEmpty) return List<Noun>.of(all);
  return filtered;
}
