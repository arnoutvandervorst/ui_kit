import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

/// A round icon button. Filled (the chat send button): [backgroundColor]
/// (primary by default) with an on-colour icon, subtle fill when disabled.
/// [flat]: no fill, the icon in the text colour of what it stands on (a
/// close or more button in a bar or row).
class CustomFilledIconButton extends StatelessWidget {
  final Icon icon;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final double padding;
  final bool flat;

  /// Said on long press and read out; give one for every [flat] button.
  final String? tooltip;

  /// A round outlined button (a tile's secondary action): the icon in its own
  /// colour, [backgroundColor] as fill, a 1.5 px ring in [borderColor] (none
  /// when null). Its size is the icon plus [padding] on each side.
  final bool outlined;
  final Color? borderColor;
  /// A [flat] button's ring, 48 round; null: none.
  final Color? outline;

  /// A [flat] button's count badge on the icon (unread items), hidden at 0.
  /// Null: no badge.
  final int? badgeCount;

  /// The action still runs: a spinner in place of the icon, not tappable.
  final bool busy;

  const CustomFilledIconButton({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.onPressed,
    this.padding = 14,
    this.flat = false,
    this.tooltip,
    this.outlined = false,
    this.borderColor,
    this.outline,
    this.badgeCount,
    this.busy = false,
  });

  @override
  Widget build(BuildContext context) {
    if (flat) {
      final count = badgeCount;
      return IconButton(
        icon: busy ? CustomBusyLabel(busy: true, child: icon) : (count == null ? icon : CustomIconBadge(count: count, isVisible: count > 0, child: icon)),
        tooltip: tooltip,
        onPressed: busy ? null : onPressed,
        style: outline == null
            ? null
            : IconButton.styleFrom(fixedSize: const Size(48, 48), side: BorderSide(color: outline!)),
      );
    }
    final tokens = context.tokens;
    final size = icon.size ?? 24.0;
    if (outlined) {
      final side = Size.square(size + padding * 2);
      return IconButton.outlined(
        tooltip: tooltip,
        onPressed: busy ? null : onPressed,
        icon: CustomBusyLabel(busy: busy, child: Icon(icon.icon, size: size)),
        style: IconButton.styleFrom(
          fixedSize: side,
          minimumSize: side,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: icon.color,
          backgroundColor: backgroundColor,
          side: borderColor == null ? BorderSide.none : BorderSide(color: borderColor!, width: 1.5),
        ),
      );
    }
    final action = busy ? null : onPressed;
    final enabled = action != null;
    //* A button with its own colour keeps it when disabled: the caller fades it.
    final fill = enabled ? (backgroundColor ?? tokens.primary.color) : (backgroundColor ?? tokens.subtle);
    final iconColor = enabled ? (icon.color ?? tokens.primary.onColor) : (backgroundColor == null ? tokens.muted : icon.color ?? tokens.muted);

    return Material(
      color: fill,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: size + (padding * 2),
        height: size + (padding * 2),
        child: IconButton(
          icon: CustomBusyLabel(busy: busy, child: Icon(icon.icon, size: size, color: iconColor)),
          color: iconColor,
          tooltip: tooltip,
          splashRadius: size,
          onPressed: action,
          style: IconButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
