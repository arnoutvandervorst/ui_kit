import 'package:ui_kit/src/enum_item.dart';

/// How a picker lays out its list, by the number of choices.
enum EnumPickerLayout {
  /// Up to [kEnumPickerShortMax]: the sheet is as tall as the list.
  short,

  /// Up to [kEnumPickerSearchFrom] - 1: a tall sheet whose list scrolls.
  tall,

  /// From [kEnumPickerSearchFrom]: tall, with a search field and groups.
  search,
}

/// The most choices that show without scrolling.
const kEnumPickerShortMax = 7;

/// From this many choices the picker gets a search field.
const kEnumPickerSearchFrom = 15;

EnumPickerLayout enumPickerLayoutFor(int count) => count <= kEnumPickerShortMax
    ? EnumPickerLayout.short
    : count < kEnumPickerSearchFrom
    ? EnumPickerLayout.tall
    : EnumPickerLayout.search;

/// The items whose title or description contains [query], ignoring case and
/// the accents of Latin letters; all of them for an empty query. Keeps order.
List<T> filterEnumItems<T extends EnumItem>(List<T> items, String query) {
  final needle = foldForSearch(query.trim());
  if (needle.isEmpty) return items;
  return [
    for (final item in items)
      if (foldForSearch(item.title).contains(needle) || foldForSearch(item.description).contains(needle)) item,
  ];
}

/// Where [query] sits in [text] (folded the same way), or null.
({int start, int end})? matchIn(String text, String query) {
  final needle = foldForSearch(query.trim());
  if (needle.isEmpty) return null;
  final start = foldForSearch(text).indexOf(needle);
  return start < 0 ? null : (start: start, end: start + needle.length);
}

/// Lower case without accents, one character per character so positions match.
String foldForSearch(String text) {
  const from = 'àáâãäåèéêëìíîïòóôõöùúûüýÿñç';
  const to = 'aaaaaaeeeeiiiiooooouuuuyync';
  final lower = text.toLowerCase();
  final out = StringBuffer();
  for (final rune in lower.runes) {
    final char = String.fromCharCode(rune);
    final index = from.indexOf(char);
    out.write(index < 0 ? char : to[index]);
  }
  return out.toString();
}
