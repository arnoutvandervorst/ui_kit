import 'package:material_ui/material_ui.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double? height;
  final double? width;
  final double? value;

  /// Null: the theme's.
  final Color? color;
  final double? strokeWidth;

  const CustomProgressIndicator({super.key, this.height, this.width, this.value, this.color, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator.adaptive(
        value: value,
        valueColor: color == null ? null : AlwaysStoppedAnimation(color!),
        strokeWidth: strokeWidth,
      ),
    );
  }
}
