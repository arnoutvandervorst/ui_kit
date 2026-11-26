import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

class CustomEmptyState extends StatelessWidget {
  final IconData icon;
  final String text;
  final EdgeInsetsGeometry padding;

  const CustomEmptyState({super.key, required this.icon, required this.text, this.padding = const EdgeInsets.all(32)});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, color: context.tokens.primary.tint),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(icon, size: 30, color: context.tokens.primary.color),
              ),
            ),
            const SizedBox(height: 18),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Text(
                text,
                style: context.textTheme.bodyMedium?.copyWith(color: context.tokens.muted, height: 1.4),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
