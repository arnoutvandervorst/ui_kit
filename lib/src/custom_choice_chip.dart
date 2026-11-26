import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

/// A filter pill ("All · Squat · Push"): white with a line border, ink when
/// selected. Flat, fully rounded.
class CustomChoiceChip extends StatelessWidget {
  final bool selected;
  final Widget label;
  final void Function(bool)? onSelected;
  final Icon? avatar;

  /// A remove cross at the end (a chosen item you can take off again).
  final VoidCallback? onDeleted;

  const CustomChoiceChip({
    super.key,
    required this.selected,
    required this.label,
    this.onSelected,
    this.avatar,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    //* The chip theme's icon colour is muted and not state-aware: on the
    //* ink of a selected pill the icon turns with the label.
    final iconTheme = IconThemeData(color: selected ? tokens.surface : tokens.muted, size: 18);
    const shape = StadiumBorder();
    final side = BorderSide(color: selected ? tokens.ink : tokens.line);
    //* Pill: 13 px / 600 label, 36 px tall, 14 px sides.
    const padding = EdgeInsets.symmetric(horizontal: 6, vertical: 4);
    const labelPadding = EdgeInsets.symmetric(horizontal: 4);
    final labelStyle = context.textTheme.labelLarge?.copyWith(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: selected ? tokens.surface : tokens.ink,
    );
    final onDeleted = this.onDeleted;
    if (onDeleted != null) {
      return InputChip(
        avatar: avatar,
        iconTheme: iconTheme,
        elevation: 0,
        pressElevation: 0,
        label: label,
        selected: selected,
        onSelected: onSelected,
        onDeleted: onDeleted,
        deleteIconColor: selected ? tokens.surface : tokens.muted,
        showCheckmark: false,
        shape: shape,
        side: side,
        backgroundColor: tokens.surface,
        selectedColor: tokens.ink,
        padding: padding,
        labelPadding: labelPadding,
        labelStyle: labelStyle,
      );
    }
    return ChoiceChip(
      avatar: avatar,
      iconTheme: iconTheme,
      elevation: 0,
      pressElevation: 0,
      label: label,
      selected: selected,
      onSelected: onSelected,
      showCheckmark: false,
      shape: shape,
      side: side,
      backgroundColor: tokens.surface,
      selectedColor: tokens.ink,
      padding: padding,
      labelPadding: labelPadding,
      labelStyle: labelStyle,
    );
  }
}
