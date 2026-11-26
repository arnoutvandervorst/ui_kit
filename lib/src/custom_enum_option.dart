import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/src/ui_context.dart';

/// One choice in a picker: the title, an optional line of explanation, and a
/// ring that turns into a check. The chosen one is ink, the check in amber.
/// [match] marks the part of the title a search found.
class CustomEnumOption extends StatelessWidget {
  final String title;
  final String description;
  final IconData? icon;
  final bool selected;
  final ({int start, int end})? match;
  final VoidCallback onTap;

  const CustomEnumOption({
    super.key,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
    this.icon,
    this.match,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final text = context.textTheme;
    final ink = selected ? tokens.surface : tokens.ink;
    final titleStyle = text.titleMedium?.copyWith(color: ink);
    final hit = match;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? tokens.ink : tokens.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: selected ? tokens.ink : tokens.line),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              spacing: 10,
              children: [
                if (icon != null) Icon(icon, size: 20, color: selected ? tokens.surface : tokens.primary.color),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      if (hit == null)
                        Text(title, style: titleStyle)
                      else
                        Text.rich(
                          TextSpan(
                            style: titleStyle,
                            children: [
                              TextSpan(text: title.substring(0, hit.start)),
                              TextSpan(
                                text: title.substring(hit.start, hit.end),
                                style: TextStyle(
                                  backgroundColor: selected
                                      ? tokens.surface.withValues(alpha: 0.2)
                                      : tokens.primary.tint,
                                ),
                              ),
                              TextSpan(text: title.substring(hit.end)),
                            ],
                          ),
                        ),
                      if (description.isNotEmpty)
                        Text(
                          description,
                          style: text.bodySmall?.copyWith(
                            color: selected ? tokens.surface.withValues(alpha: 0.75) : tokens.muted,
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox.square(
                  dimension: 22,
                  child: selected
                      ? DecoratedBox(
                          decoration: BoxDecoration(color: tokens.amber.strong, shape: BoxShape.circle),
                          child: Icon(Icons.check_rounded, size: 15, color: tokens.ink),
                        )
                      : DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: tokens.line, width: 2),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
