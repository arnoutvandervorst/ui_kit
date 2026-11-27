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
    //* A tap always goes through, except on a new item once the maximum is reached.
    void onTapHandler(T item) {
      final max = maxSelected;
      if (max == null || max == 1 || selected.contains(item) || max > selected.length) onTap?.call(item);
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
