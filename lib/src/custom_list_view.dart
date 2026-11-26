import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class CustomListView extends HookWidget {
  final List<Widget> children;
  final EdgeInsets padding;

  const CustomListView({super.key, required this.children, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    final animationController = useAnimationController(duration: const Duration(milliseconds: 500));

    final animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.1, 1.0, curve: Curves.easeOut),
      ),
    );

    useEffect(() {
      animationController.forward();
      return null;
    }, [scrollController]);

    return ListView(
      key: key,
      padding: padding,
      controller: scrollController,
      children: List.generate(children.length, (index) => FadeTransition(opacity: animation, child: children[index])),
    );
  }
}
