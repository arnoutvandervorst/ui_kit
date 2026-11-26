import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

class CustomIconBadge extends StatelessWidget {
  final Widget child;
  final int? count;
  final String? label;
  final bool isVisible;
  final Color? tintColor;
  final EdgeInsets padding;
  final double? right;
  final double top;

  const CustomIconBadge({
    super.key,
    required this.child,
    this.count,
    this.label,
    this.isVisible = true,
    this.tintColor,
    this.padding = EdgeInsets.zero,
    this.right,
    this.top = -8,
  }) : assert(count != null || label != null, 'Either count or label must be provided.');

  @override
  Widget build(BuildContext context) {
    final rawLabel = label ?? math.min(count ?? 0, 99).toString();
    final badgeTint = tintColor ?? context.colorScheme.primary;
    final isPill = rawLabel.length > 1;

    return Padding(
      padding: padding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          child,
          Positioned(
            right: right ?? (isPill ? -12 : -8),
            top: top,
            child: IgnorePointer(
              ignoring: true,
              child: AnimatedScale(
                scale: isVisible ? 1 : 0.75,
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                child: AnimatedOpacity(
                  opacity: isVisible ? 1 : 0,
                  duration: const Duration(milliseconds: 150),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: badgeTint,
                      borderRadius: BorderRadius.circular(isPill ? 999 : 12),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: isPill ? 24 : 20, minHeight: 20),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: isPill ? 7 : 5, vertical: 2),
                        child: Center(
                          child: Text(
                            rawLabel,
                            textAlign: TextAlign.center,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.onPrimary,
                              fontWeight: FontWeight.w800,
                              height: 1,
                              letterSpacing: -0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
