import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

/// Marks that a horizontal page gutter is already applied to this subtree.
///
//* Two conventions coexist in this codebase and nothing declared which applied
//* where: `PageBody` owns the gutter (so its children must be
//* vertical-only), while `UserAuthTile` owns its OWN gutter (so its parents
//* must be vertical-only). A widget could not tell which world it was in, so
//* every new screen was a coin flip — and the failure is silent, because 32px
//* looks plausible until you put two screens side by side. Three screens
//* shipped doubled before this existed.
//*
//* Usage:
//*   * A widget that APPLIES a gutter wraps its child in [GutterScope.applied].
//*   * A widget that WANTS a gutter asks [GutterScope.horizontalOf], which
//*     returns 0 when an ancestor already applied one.
//*   * [GutterScope.debugAssertNotApplied] fails loudly in debug when a widget
//*     is about to hardcode a second gutter.
class GutterScope extends InheritedWidget {
  /// Whether an ancestor already applied the page gutter.
  final bool isApplied;

  const GutterScope({super.key, required this.isApplied, required super.child});

  /// Wraps [child], declaring that this subtree is already inset.
  factory GutterScope.applied({Key? key, required Widget child}) =>
      GutterScope(key: key, isApplied: true, child: child);

  static GutterScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<GutterScope>();

  /// True when some ancestor already inset this subtree horizontally.
  static bool isAppliedIn(BuildContext context) => maybeOf(context)?.isApplied ?? false;

  /// The horizontal gutter this widget should apply: [kPageGutter] normally,
  /// 0 when an ancestor already did it.
  static double horizontalOf(BuildContext context) => isAppliedIn(context) ? 0 : kPageGutter;

  /// Symmetric padding with [vertical], and a horizontal gutter only if one is
  /// not already applied above.
  static EdgeInsets paddingOf(BuildContext context, {double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: horizontalOf(context), vertical: vertical);

  /// Debug-only tripwire for widgets that still hardcode a gutter.
  ///
  //* Returns true so it can be used inside `assert(...)`, which strips the whole
  //* call in release. [owner] names the offending widget in the failure.
  static bool debugAssertNotApplied(BuildContext context, String owner) {
    assert(() {
      if (isAppliedIn(context)) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('$owner applied a horizontal page gutter inside a GutterScope.'),
          ErrorDescription(
            'An ancestor already inset this subtree by ${kPageGutter}px, so this '
            'widget doubles it and the content renders at ${kPageGutter * 2}px.',
          ),
          ErrorHint(
            'Either drop the horizontal padding here and keep vertical-only '
            'spacing, or use GutterScope.paddingOf(context) so the gutter is '
            'applied exactly once.',
          ),
        ]);
      }
      return true;
    }());
    return true;
  }

  @override
  bool updateShouldNotify(GutterScope oldWidget) => oldWidget.isApplied != isApplied;
}
