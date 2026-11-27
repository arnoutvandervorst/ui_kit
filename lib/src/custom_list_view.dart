import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ui_kit/src/use_fade_in.dart';


class CustomListView extends HookWidget {
  final List<Widget> children;
  final EdgeInsets padding;

  const CustomListView({super.key, required this.children, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    final animation = useFadeIn();

    return ListView(
      key: key,
      padding: padding,
      controller: scrollController,
      children: List.generate(children.length, (index) => FadeTransition(opacity: animation, child: children[index])),
    );
  }
}
