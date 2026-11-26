import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

class Item with EnumItem {
  @override
  final String title;
  @override
  final String description;
  @override
  final String pickerGroup;

  Item(this.title, {this.description = '', this.pickerGroup = ''});

  @override
  String toString() => title;
}

List<Item> make(int count, {bool grouped = false}) => [
  for (var i = 0; i < count; i++) Item('Item $i', pickerGroup: grouped ? (i < count / 2 ? 'First' : 'Second') : ''),
];

Future<Item?> open(WidgetTester tester, List<Item> items, Item selected) async {
  Item? picked;
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () => customEnumPicker<Item>(context, 'Goal', Icons.flag, items, selected, (item) => picked = item),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return picked;
}

void main() {
  group('layout by count', () {
    test('7 short, 8 tall, 14 tall, 15 search', () {
      expect(enumPickerLayoutFor(7), EnumPickerLayout.short);
      expect(enumPickerLayoutFor(8), EnumPickerLayout.tall);
      expect(enumPickerLayoutFor(14), EnumPickerLayout.tall);
      expect(enumPickerLayoutFor(15), EnumPickerLayout.search);
    });
  });

  group('search', () {
    test('matches title and description, ignores case and accents, keeps order', () {
      final items = [Item('Fietsen'), Item('Café', description: 'koffie'), Item('Hardlopen'), Item('Spinning', description: 'Binnen fietsen')];
      expect(filterEnumItems(items, 'FIETS').map((e) => e.title), ['Fietsen', 'Spinning']);
      expect(filterEnumItems(items, 'cafe').map((e) => e.title), ['Café']);
      expect(filterEnumItems(items, '  '), items);
      expect(matchIn('Café latte', 'fe'), (start: 2, end: 4));
      expect(matchIn('Hardlopen', 'xyz'), isNull);
    });
  });

  testWidgets('a short list shows whole, without search; a tap picks and closes', (tester) async {
    final items = make(3);
    Item? picked;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => customEnumPicker<Item>(context, 'Goal', Icons.flag, items, items[0], (item) => picked = item, question: 'Why?'),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('GOAL'), findsOneWidget);
    expect(find.text('Why?'), findsOneWidget);
    expect(find.byKey(const ValueKey('enum-picker-search')), findsNothing);
    for (final item in items) {
      expect(find.text(item.title), findsOneWidget);
    }
    await tester.tap(find.text('Item 2'));
    await tester.pumpAndSettle();
    expect(picked, items[2]);
    expect(find.text('GOAL'), findsNothing, reason: 'the sheet closed');
  });

  testWidgets('a tall list opens on the chosen row', (tester) async {
    final items = make(12);
    await open(tester, items, items[11]);
    expect(find.byKey(const ValueKey('enum-picker-search')), findsNothing);
    expect(find.text('Item 11').hitTestable(), findsOneWidget);
  });

  testWidgets('from 15: search filters with a count, groups head the list, nothing found offers a clear', (tester) async {
    final items = make(16, grouped: true);
    await open(tester, items, items[0]);
    expect(find.byKey(const ValueKey('enum-picker-search')), findsOneWidget);
    expect(find.text('16 OF 16'), findsOneWidget);
    expect(find.text('FIRST'), findsOneWidget);
    await tester.enterText(find.byKey(const ValueKey('enum-picker-search')), 'item 1');
    await tester.pumpAndSettle();
    //* "Item 1" and "Item 10".."Item 15"
    expect(find.text('7 OF 16'), findsOneWidget);
    await tester.enterText(find.byKey(const ValueKey('enum-picker-search')), 'zzz');
    await tester.pumpAndSettle();
    expect(find.text('Nothing found for "zzz".'), findsOneWidget);
    await tester.tap(find.text('Clear search').last);
    await tester.pumpAndSettle();
    expect(find.text('16 OF 16'), findsOneWidget);
  });
}
