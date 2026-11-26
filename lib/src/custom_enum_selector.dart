import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';


class CustomEnumSelector<T extends EnumItem> extends StatelessWidget {
  final List<T> items;
  final List<T> selected;
  final void Function(T)? onTap;
  final int? maxSelected;

  const CustomEnumSelector({super.key, required this.items, required this.selected, this.onTap, this.maxSelected = 1});

  @override
  Widget build(BuildContext context) {
    Future<void> onTapHandler(T item) async {
      /// When unrestricted, just call onTap
      if (maxSelected == null) {
        onTap?.call(item);
        return;
      }

      /// When 1, just call onTap
      if (maxSelected == 1) {
        onTap?.call(item);
        return;
      }

      /// When the item is already selected, call onTap
      if (selected.contains(item)) {
        onTap?.call(item);
        return;
      }

      /// When the item is not selected and maxSelected is not reached, call onTap
      if (maxSelected! > selected.length) {
        onTap?.call(item);
        return;
      }
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      children: items
          .map(
            (item) => CustomChoiceChip(
              label: Text(item.title),
              selected: selected.contains(item),
              onSelected: (value) => onTapHandler(item),
            ),
          )
          .toList(),
    );
  }
}
