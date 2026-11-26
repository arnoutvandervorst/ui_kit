import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

/// Fills the remaining height and applies THE page gutter, once.
///
//* Despite the name there is no card: the `DecoratedBox` this used to wrap the
//* child in carried a BoxDecoration with only a borderRadius — no colour,
//* gradient, border or shadow — so it painted nothing and has been removed.
//* What the widget actually provides is "fill + 16px gutter".
//*
//* It publishes a [GutterScope], so a child that would otherwise apply its own
//* horizontal padding gets 0 instead. Before that existed, every screen had to
//* remember that this padding was already here, and three shipped at 32px.
class PageBody extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const PageBody({super.key, required this.child, this.padding = p16});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: padding,
            child: SizedBox(
              width: double.infinity,
              //* Declares the gutter as applied, so descendants that would
              //* otherwise add their own (UserAuthTile, scroll paddings) fall
              //* back to 0 instead of doubling it.
              child: GutterScope.applied(child: child),
            ),
          ),
        ),
      ],
    );
  }
}
