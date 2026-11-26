import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

class CustomSegmentButton extends StatelessWidget {
  final String label;
  final bool dot;

  /// A check before the label (that part is done).
  final bool done;
  final bool isSelected;
  final VoidCallback? onTap;

  const CustomSegmentButton({super.key, required this.label, required this.isSelected, this.dot = false, this.done = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final fill = isSelected ? tokens.ink : Colors.transparent;
    final foreground = isSelected ? tokens.surface : tokens.ink;

    return Semantics(
      button: true,
      selected: isSelected,
      child: Material(
        color: fill,
        borderRadius: BorderRadius.circular(kPillRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(kPillRadius),
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: kTouchTarget - 8),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                //* Scales down rather than truncating ("Samenvatting" in four
                //* segments at 360 px).
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (done) ...[Icon(Icons.check_rounded, size: 16, color: foreground), const SizedBox(width: 4)],
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: foreground,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                        ),
                      ),
                      if (dot) ...[
                        const SizedBox(width: 5),
                        Container(
                          key: const ValueKey('segment-dot'),
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(color: tokens.clay.color, shape: BoxShape.circle),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
