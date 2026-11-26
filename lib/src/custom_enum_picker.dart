import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/src/custom_enum_picker_sheet.dart';
import 'package:ui_kit/src/enum_item.dart';
import 'package:ui_kit/src/ui_context.dart';

/// Picks one of [items] in a sheet (see [CustomEnumPickerSheet]): a tap calls
/// [onTap] with the choice and closes the sheet. [question] stands under the
/// heading; an item's `description` is its line of explanation and its
/// `pickerGroup` its heading in a long list. The caller decides the order.
Future<void> customEnumPicker<T extends EnumItem>(
  BuildContext context,
  String title,
  IconData iconData,
  List<T> items,
  T selected,
  void Function(T)? onTap, {
  String? question,
}) => showModalBottomSheet<void>(
  useRootNavigator: true,
  context: context,
  isScrollControlled: true,
  showDragHandle: false,
  backgroundColor: context.tokens.surface,
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  builder: (sheetContext) => CustomEnumPickerSheet<T>(
    title: title,
    question: question,
    iconData: iconData,
    items: items,
    selected: selected,
    onPicked: (item) {
      onTap?.call(item);
      Navigator.of(sheetContext).pop();
    },
  ),
);
