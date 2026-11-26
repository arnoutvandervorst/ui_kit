import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  testWidgets('CustomIconBlock: the icon at half the size, on the accent, hidden from screen readers', (tester) async {
    const accent = UiTokens.light;
    await tester.pumpWidget(MaterialApp(home: Center(child: CustomIconBlock(icon: Icons.favorite, accent: accent.primary, size: 40))));
    expect(tester.getSize(find.byType(CustomIconBlock)), const Size(40, 40));
    final icon = tester.widget<Icon>(find.byIcon(Icons.favorite));
    expect(icon.size, 20);
    expect(icon.color, accent.primary.onColor);
    expect(find.byType(ExcludeSemantics), findsWidgets);
  });
}
