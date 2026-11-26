import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:material_ui/material_ui.dart';

/// A page's vertical rhythm (the parent owns it; widgets carry no outer
/// margin): [spacing] between children, stretched to the width, and no gap
/// around a child that renders nothing (zero height), so a section that
/// loads asynchronously or has nothing to show never leaves a double gap.
/// The vertical twin of PageBody's gutter (widgets own zero outer space,
/// parents own rhythm).
class CustomSpacedColumn extends MultiChildRenderObjectWidget {
  final double spacing;

  const CustomSpacedColumn({super.key, this.spacing = 16, super.children});

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderSpacedColumn(spacing);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) => (renderObject as _RenderSpacedColumn).spacing = spacing;
}

class _SpacedParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderSpacedColumn extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _SpacedParentData>, RenderBoxContainerDefaultsMixin<RenderBox, _SpacedParentData> {
  _RenderSpacedColumn(this._spacing);

  double _spacing;
  set spacing(double value) {
    if (value == _spacing) return;
    _spacing = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _SpacedParentData) child.parentData = _SpacedParentData();
  }

  @override
  void performLayout() {
    final width = constraints.maxWidth;
    final childConstraints = BoxConstraints.tightFor(width: width.isFinite ? width : null);
    var y = 0.0;
    var any = false;
    var child = firstChild;
    while (child != null) {
      child.layout(childConstraints, parentUsesSize: true);
      final data = child.parentData! as _SpacedParentData;
      final height = child.size.height;
      if (height > 0 && any) y += _spacing;
      data.offset = Offset(0, y);
      if (height > 0) {
        y += height;
        any = true;
      }
      child = data.nextSibling;
    }
    size = constraints.constrain(Size(width.isFinite ? width : _maxChildWidth(), y));
  }

  double _maxChildWidth() {
    var widest = 0.0;
    var child = firstChild;
    while (child != null) {
      widest = math.max(widest, child.size.width);
      child = (child.parentData! as _SpacedParentData).nextSibling;
    }
    return widest;
  }

  double _sum(double Function(RenderBox child) extent) {
    var total = 0.0;
    var count = 0;
    var child = firstChild;
    while (child != null) {
      final value = extent(child);
      if (value > 0) {
        total += value;
        count++;
      }
      child = (child.parentData! as _SpacedParentData).nextSibling;
    }
    return total + _spacing * math.max(0, count - 1);
  }

  @override
  double computeMinIntrinsicHeight(double width) => _sum((child) => child.getMinIntrinsicHeight(width));

  @override
  double computeMaxIntrinsicHeight(double width) => _sum((child) => child.getMaxIntrinsicHeight(width));

  @override
  double computeMinIntrinsicWidth(double height) {
    var widest = 0.0;
    var child = firstChild;
    while (child != null) {
      widest = math.max(widest, child.getMinIntrinsicWidth(double.infinity));
      child = (child.parentData! as _SpacedParentData).nextSibling;
    }
    return widest;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    var widest = 0.0;
    var child = firstChild;
    while (child != null) {
      widest = math.max(widest, child.getMaxIntrinsicWidth(double.infinity));
      child = (child.parentData! as _SpacedParentData).nextSibling;
    }
    return widest;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final childConstraints = BoxConstraints.tightFor(width: width.isFinite ? width : null);
    return constraints.constrain(Size(width.isFinite ? width : 0, _sum((child) => child.getDryLayout(childConstraints).height)));
  }

  @override
  void paint(PaintingContext context, Offset offset) => defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) => defaultHitTestChildren(result, position: position);
}

/// The same rhythm for a lazy list (a ListView's children, built as they
/// scroll into view): [spacing] above [child], and nothing at all when the
/// child renders nothing. Use `List<Widget>.spaced` to give every child but
/// the first one.
class CustomGapAbove extends SingleChildRenderObjectWidget {
  final double spacing;

  const CustomGapAbove({super.key, this.spacing = 16, required Widget super.child});

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderGapAbove(spacing);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) => (renderObject as _RenderGapAbove).spacing = spacing;
}

class _RenderGapAbove extends RenderShiftedBox {
  _RenderGapAbove(this._spacing) : super(null);

  double _spacing;
  set spacing(double value) {
    if (value == _spacing) return;
    _spacing = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final child = this.child;
    if (child == null) {
      size = constraints.smallest;
      return;
    }
    child.layout(constraints.loosen().copyWith(minWidth: constraints.minWidth, maxWidth: constraints.maxWidth), parentUsesSize: true);
    final gap = child.size.height > 0 ? _spacing : 0.0;
    (child.parentData! as BoxParentData).offset = Offset(0, gap);
    size = constraints.constrain(Size(child.size.width, child.size.height + gap));
  }
}

/// A lazy list's children with the page rhythm: the first as is, every other
/// one in a [CustomGapAbove].
extension CustomSpacedList on List<Widget> {
  List<Widget> spaced({double spacing = 16}) => [
    for (final (index, child) in indexed) index == 0 ? child : CustomGapAbove(spacing: spacing, child: child),
  ];
}
