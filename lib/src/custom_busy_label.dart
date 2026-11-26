import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

/// A button's label while its action waits on the backend (visible loading):
/// a small spinner in place of the label, at the label's
/// own size so the button does not jump; otherwise the label itself.
///
/// `FilledButton(onPressed: busy ? null : save, child: CustomBusyLabel(busy: busy, child: Text(l.save)))`
class CustomBusyLabel extends StatelessWidget {
  final bool busy;
  final Widget child;

  const CustomBusyLabel({super.key, required this.busy, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!busy) return child;
    final color = DefaultTextStyle.of(context).style.color ?? IconTheme.of(context).color;
    return Semantics(
      label: UiKit.strings.busy,
      liveRegion: true,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ExcludeSemantics(child: Opacity(opacity: 0, child: child)),
          SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2, color: color)),
        ],
      ),
    );
  }
}
