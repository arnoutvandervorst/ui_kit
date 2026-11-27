import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ui_kit/src/use_fade_in.dart';


import 'package:ui_kit/ui_kit.dart';

class CustomListViewBuilder extends HookWidget {
  final ScrollController controller;
  final IndexedWidgetBuilder itemBuilder;
  final Widget empty;
  final int itemCount;
  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry padding;

  const CustomListViewBuilder({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required this.itemCount,
    this.empty = const CustomEmptyColumn(),
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return empty;
    }

    final animation = useFadeIn();

    return ListView.builder(
      key: key,
      scrollDirection: scrollDirection,
      controller: controller,
      padding: padding,
      reverse: reverse,
      itemCount: itemCount,
      itemBuilder: (context, index) => FadeTransition(opacity: animation, child: itemBuilder(context, index)),
    );
  }
}
