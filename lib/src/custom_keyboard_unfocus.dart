import 'package:material_ui/material_ui.dart';

class CustomKeyboardUnfocus extends StatelessWidget {
  final Widget child;

  const CustomKeyboardUnfocus({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => FocusManager.instance.primaryFocus?.unfocus(), child: child);
  }
}
