import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

/// The fade a list opens with: its children go from 0 to 1 in half a second.
Animation<double> useFadeIn() {
  final controller = useAnimationController(duration: const Duration(milliseconds: 500));
  final animation = useMemoized(
    () => Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.1, 1.0, curve: Curves.easeOut)),
    ),
    [controller],
  );
  useEffect(() {
    controller.forward();
    return null;
  }, const []);
  return animation;
}
