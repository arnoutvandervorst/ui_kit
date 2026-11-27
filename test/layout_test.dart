import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  testWidgets('CustomSpacedColumn: a gap between children, none around one that renders nothing', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 200,
            child: CustomSpacedColumn(
              spacing: 10,
              children: [
                SizedBox(key: ValueKey('a'), height: 20),
                SizedBox.shrink(key: ValueKey('empty')),
                SizedBox(key: ValueKey('b'), height: 30),
                SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
    expect(tester.getTopLeft(find.byKey(const ValueKey('a'))).dy, 0);
    expect(tester.getTopLeft(find.byKey(const ValueKey('b'))).dy, 30);
    expect(tester.getSize(find.byKey(const ValueKey('b'))).width, 200);
    expect(tester.getSize(find.byType(CustomSpacedColumn)), const Size(200, 60));
  });

  testWidgets('CustomGapAbove: the gap only above a child that renders something', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: ListView(
          children: const [SizedBox(height: 20), SizedBox.shrink(), SizedBox(key: ValueKey('c'), height: 30)].spaced(spacing: 10),
        ),
      ),
    );
    expect(tester.getTopLeft(find.byKey(const ValueKey('c'))).dy, 30);
  });

  testWidgets('PageBody: the gutter counts as applied only when its padding has one', (tester) async {
    Future<double> gutterUnder(EdgeInsets padding) async {
      late double gutter;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: PageBody(
            padding: padding,
            child: Builder(
              builder: (context) {
                gutter = GutterScope.horizontalOf(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      return gutter;
    }

    expect(await gutterUnder(p16), 0);
    expect(await gutterUnder(const EdgeInsets.symmetric(vertical: 8)), kPageGutter);
  });
}
