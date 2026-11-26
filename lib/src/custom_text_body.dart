import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

class CustomTextBody extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomTextBody({super.key, required this.text, this.backgroundColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return const CustomNullContainer();
    }

    final foregroundColor = textColor ?? context.colorScheme.onSurfaceVariant;
    final effectiveDecoration = backgroundColor != null
        ? BoxDecoration(
            color: backgroundColor,
            borderRadius: kBorderRadiusCircular,
            border: Border.all(color: context.colorScheme.outlineVariant.withValues(alpha: 0.24)),
          )
        : context.premiumOverlayDecoration(
            borderRadius: kBorderRadiusCircular,
            tintColor: context.colorScheme.primary,
            tintOpacity: 0.08,
            elevated: true,
          );

    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: effectiveDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Icon(Icons.info_outline, size: 16, color: textColor ?? context.colorScheme.primary),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
