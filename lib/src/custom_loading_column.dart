import 'package:material_ui/material_ui.dart';

import 'package:ui_kit/ui_kit.dart';

class CustomLoadingColumn extends StatelessWidget {
  const CustomLoadingColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [CustomProgressIndicator()]),
      ],
    );
  }
}
