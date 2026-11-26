import 'package:flutter/widgets.dart';

/// An enum the Custom pickers and selectors can show: a title, an optional
/// description, icon, colour and, in a long list, a group.
mixin EnumItem {
  String get title => '';
  String get description => '';
  IconData? get iconData => null;
  Color? get color => null;
  bool get isCustom => false;

  /// The heading this item sits under in a long picker; empty for none.
  String get pickerGroup => '';
}
