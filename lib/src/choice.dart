import 'package:ui_kit/src/enum_item.dart';
import 'package:ui_kit/src/ui_strings.dart';

/// The answer of a confirm or OK sheet.
enum Choice with EnumItem {
  yes,
  no,
  cancel,
  unknown;

  @override
  String get title {
    final l = UiKit.strings;
    return switch (this) {
      Choice.yes => l.yes,
      Choice.no => l.no,
      Choice.cancel => l.cancel,
      Choice.unknown => l.unknown,
    };
  }
}
