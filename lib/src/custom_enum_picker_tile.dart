import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/src/custom_enum_picker.dart';
import 'package:ui_kit/src/enum_item.dart';
import 'package:ui_kit/src/ui_context.dart';

/// A row that shows a choice and opens [customEnumPicker]: the icon in a
/// well, the label small in capitals, the current value large, a chevron.
class CustomEnumPickerTile<T extends EnumItem> extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final List<T> items;
  final T selected;
  final void Function(T) onSelected;

  /// The question under the picker's heading.
  final String? question;

  const CustomEnumPickerTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.items,
    required this.selected,
    required this.onSelected,
    this.question,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final text = context.textTheme;
    return Material(
      color: tokens.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: BorderSide(color: tokens.line)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => customEnumPicker(context, label, icon, items, selected, onSelected, question: question),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            spacing: 10,
            children: [
              SizedBox.square(
                dimension: 36,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: tokens.primary.color, borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, size: 18, color: tokens.primary.onColor),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label.toUpperCase(), style: text.labelSmall?.copyWith(color: tokens.muted)),
                    Text(value, style: text.titleMedium?.copyWith(fontSize: 17, color: tokens.ink), maxLines: 2),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: tokens.muted),
            ],
          ),
        ),
      ),
    );
  }
}
