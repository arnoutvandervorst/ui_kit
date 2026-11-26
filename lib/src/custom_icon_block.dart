import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

/// An icon on a rounded square in an accent's colour: what a card is about
/// (an activity's kind, a task's type). No outer margin; decorative, so the
/// card's own text carries the meaning for screen readers.
class CustomIconBlock extends StatelessWidget {
  final IconData icon;

  /// The block's colour and the icon's colour on it.
  final UiAccent accent;

  /// Width and height; the icon is half of it.
  final double size;

  const CustomIconBlock({super.key, required this.icon, required this.accent, this.size = 44});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: accent.color, borderRadius: BorderRadius.circular(kControlRadius)),
        child: Icon(icon, size: size / 2, color: accent.onColor),
      ),
    );
  }
}
