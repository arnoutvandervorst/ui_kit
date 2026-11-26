import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

class CustomBottomSheetBody extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Widget content;
  final List<Widget>? actions;
  final EdgeInsets padding;

  const CustomBottomSheetBody({
    super.key,
    required this.title,
    required this.iconData,
    required this.content,
    this.actions,
    this.padding = kBodyPadding,
  });

  @override
  Widget build(BuildContext context) {
    final outerRadius = BorderRadius.circular(28);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.tokens.surface,
        borderRadius: outerRadius,
        border: context.softOutlineBorder,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 4),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.onSurface.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DecoratedBox(
                  decoration: context.premiumOverlayDecoration(
                    tintColor: context.colorScheme.primary,
                    tintOpacity: 0.14,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(iconData, size: 18, color: context.colorScheme.primary),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: 0.1),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: context.premiumOverlayDecoration(
              tintColor: context.colorScheme.primary,
              tintOpacity: 0.06,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(padding: p16, child: content),
                if (actions != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: actions!),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
