import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class CustomPageViewBuilder extends HookWidget {
  final PageController controller;
  final IndexedWidgetBuilder itemBuilder;
  final void Function(int)? onPageChanged;
  final int itemCount;
  final Axis scrollDirection;
  final bool reverse;
  final double viewportFraction;
  final int initialPage;

  const CustomPageViewBuilder({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.onPageChanged,
    required this.itemCount,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    this.viewportFraction = 1.0,
    this.initialPage = 0,
  });

  @override
  Widget build(BuildContext context) {
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
    }, []);

    return PageView.builder(
      key: key,
      scrollDirection: scrollDirection,
      controller: controller,
      reverse: reverse,
      itemCount: itemCount,
      onPageChanged: onPageChanged,
      itemBuilder: (BuildContext context, int index) =>
          FadeTransition(opacity: animation, child: itemBuilder.call(context, index)),
    );
  }
}
