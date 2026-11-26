import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/src/custom_enum_option.dart';
import 'package:ui_kit/src/enum_item.dart';
import 'package:ui_kit/src/enum_picker_logic.dart';
import 'package:ui_kit/src/ui_context.dart';
import 'package:ui_kit/src/ui_strings.dart';

/// The picker's sheet: a heading, an optional question, and every choice as
/// a row. It grows with the list ([enumPickerLayoutFor]): short lists show
/// whole, longer ones grow the sheet up to 90% and scroll, opening on the chosen row,
/// and from [kEnumPickerSearchFrom] choices a search field and the items'
/// groups come in. A tap picks and closes.
class CustomEnumPickerSheet<T extends EnumItem> extends HookWidget {
  final String title;
  final String? question;
  final IconData? iconData;
  final List<T> items;
  final T selected;
  final ValueChanged<T> onPicked;

  const CustomEnumPickerSheet({
    super.key,
    required this.title,
    required this.items,
    required this.selected,
    required this.onPicked,
    this.question,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final text = context.textTheme;
    final strings = UiKit.strings;
    final layout = enumPickerLayoutFor(items.length);
    final query = useState('');
    final search = useTextEditingController();
    final selectedKey = useMemoized(GlobalKey.new);
    final shown = filterEnumItems(items, query.value);
    final grouped = layout == EnumPickerLayout.search && items.any((item) => item.pickerGroup.isNotEmpty);

    //* A tall list opens with the chosen row in view.
    useEffect(() {
      if (layout == EnumPickerLayout.short) return null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final target = selectedKey.currentContext;
        if (target != null && target.mounted) Scrollable.ensureVisible(target, alignment: 0.4);
      });
      return null;
    }, const []);

    final rows = <Widget>[];
    var group = '';
    for (final item in shown) {
      if (grouped && item.pickerGroup != group) {
        group = item.pickerGroup;
        if (group.isNotEmpty) {
          rows.add(
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 8, 2, 0),
              child: Text(group.toUpperCase(), style: text.labelSmall?.copyWith(color: tokens.muted)),
            ),
          );
        }
      }
      final isSelected = item == selected;
      rows.add(
        CustomEnumOption(
          key: isSelected ? selectedKey : ValueKey('enum-option-${items.indexOf(item)}'),
          title: item.title,
          description: item.description,
          icon: item.iconData,
          selected: isSelected,
          match: matchIn(item.title, query.value),
          onTap: () => onPicked(item),
        ),
      );
    }
    if (shown.isEmpty) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            spacing: 8,
            children: [
              Text(strings.noMatch(query.value.trim()), style: text.bodySmall, textAlign: TextAlign.center),
              TextButton(
                onPressed: () {
                  search.clear();
                  query.value = '';
                },
                child: Text(strings.clearSearch),
              ),
            ],
          ),
        ),
      );
    }

    final list = ListView.separated(
      key: const ValueKey('enum-picker-list'),
      shrinkWrap: layout != EnumPickerLayout.search,
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: rows.length,
      separatorBuilder: (_, _) => const SizedBox(height: 6),
      itemBuilder: (_, index) => rows[index],
    );

    final header = <Widget>[
      Center(
        child: Container(
          width: 36,
          height: 4,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(color: tokens.line, borderRadius: BorderRadius.circular(2)),
        ),
      ),
      Row(
        spacing: 10,
        children: [
          if (iconData != null) Icon(iconData, size: 22, color: tokens.primary.color),
          Expanded(child: Text(title.toUpperCase(), style: text.headlineSmall?.copyWith(color: tokens.ink))),
        ],
      ),
      if (question != null && question!.isNotEmpty) Text(question!, style: text.bodySmall),
      if (layout == EnumPickerLayout.search) ...[
        TextField(
          key: const ValueKey('enum-picker-search'),
          controller: search,
          onChanged: (value) => query.value = value,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            isDense: true,
            hintText: strings.search,
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: query.value.isEmpty
                ? null
                : IconButton(
                    tooltip: strings.clearSearch,
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      search.clear();
                      query.value = '';
                    },
                  ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(999)),
          ),
        ),
        Text(
          strings.matchCount(shown.length, items.length).toUpperCase(),
          style: text.labelSmall?.copyWith(color: tokens.muted),
        ),
      ],
    ];

    final height = MediaQuery.sizeOf(context).height;
    final insets = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: insets),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          //* Short and tall lists size to their rows (up to 90%); a searched list keeps
          //* its height so the sheet does not jump while filtering.
          child: layout != EnumPickerLayout.search
              ? ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: height * 0.9),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 10,
                    children: [...header, Flexible(child: list)],
                  ),
                )
              : SizedBox(
                  height: height * 0.9 - insets,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 10,
                    children: [...header, Expanded(child: list)],
                  ),
                ),
        ),
      ),
    );
  }
}
