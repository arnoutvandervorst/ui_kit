import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

Future<void> customHelpTooltip(
  BuildContext context, {
  required String title,
  required String content,
  IconData iconData = Icons.info_outline,
}) async => showGeneralDialog<void>(
  context: context,
  barrierDismissible: true,
  barrierLabel: 'dismiss-help-tooltip',
  barrierColor: Colors.black.withValues(alpha: 0.26),
  transitionDuration: const Duration(milliseconds: 220),
  pageBuilder: (dialogContext, _, _) {
    final colorScheme = dialogContext.colorScheme;
    final maxWidth = MediaQuery.of(dialogContext).size.width * 0.86;

    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: () => Navigator.of(dialogContext).pop()),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, right: 12, left: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // _TooltipArrow(color: colorScheme.surface),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: dialogContext.tokens.surface,
                      borderRadius: kBorderRadiusCircular,
                      border: dialogContext.softOutlineBorder,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth.clamp(280.0, 440.0)),
                      child: DecoratedBox(
                        decoration: dialogContext.premiumOverlayDecoration(
                          tintColor: colorScheme.primary,
                          tintOpacity: 0.08,
                          borderRadius: kBorderRadiusCircular,
                          elevated: true,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  DecoratedBox(
                                    decoration: dialogContext.premiumOverlayDecoration(
                                      tintColor: colorScheme.primary,
                                      tintOpacity: 0.14,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(iconData, size: 16, color: colorScheme.primary),
                                    ),
                                  ),
                                  gapx8,
                                  Expanded(
                                    child: Text(
                                      title,
                                      style: dialogContext.textTheme.titleSmall?.copyWith(
                                        color: colorScheme.onSurface,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.1,
                                      ),
                                    ),
                                  ),
                                  CustomFilledIconButton(
                                    icon: const Icon(Icons.close, size: 16),
                                    backgroundColor: colorScheme.surfaceContainerHighest,
                                    padding: 8,
                                    onPressed: () => Navigator.of(dialogContext).pop(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 42,
                                height: 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  color: colorScheme.primary,
                                ),
                              ),
                              gapy8,
                              Text(
                                content,
                                style: dialogContext.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface.withValues(alpha: 0.92),
                                  height: 1.38,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  },
  transitionBuilder: (context, animation, _, child) {
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.03, -0.03), end: Offset.zero).animate(curved),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1).animate(curved),
          alignment: Alignment.topRight,
          child: child,
        ),
      ),
    );
  },
);
