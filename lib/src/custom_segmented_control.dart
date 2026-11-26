import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

/// One option of a [CustomSegmentedControl].
class CustomSegment<T> {
  final T value;
  final String label;

  /// Something new behind this segment: a small dot beside the label.
  final bool dot;

  /// Already done (a journal part written): a check before the label.
  final bool done;

  const CustomSegment({required this.value, required this.label, this.dot = false, this.done = false});
}

/// A segmented control: a pill track holding equal segments, the selected
/// one in ink. Each segment
/// is at least 44 px tall and announces itself as a selected/unselected
/// button.
class CustomSegmentedControl<T> extends StatelessWidget {
  final List<CustomSegment<T>> segments;
  final T? selected;
  final ValueChanged<T>? onChanged;

  const CustomSegmentedControl({super.key, required this.segments, required this.selected, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return DecoratedBox(
      //* A pill track, the picked one in ink.
      decoration: BoxDecoration(color: tokens.line, borderRadius: BorderRadius.circular(kPillRadius)),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            for (final segment in segments)
              Expanded(
                child: CustomSegmentButton(
                  label: segment.label,
                  dot: segment.dot,
                  done: segment.done,
                  isSelected: segment.value == selected,
                  onTap: onChanged == null ? null : () => onChanged!(segment.value),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
