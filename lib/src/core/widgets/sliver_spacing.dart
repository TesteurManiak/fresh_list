import 'package:flutter/rendering.dart';
import 'package:material_ui/material_ui.dart';

class SliverSpacing extends LeafRenderObjectWidget {
  const new(this.size, {super.key});

  final double size;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderSliverSpacing(size);

  @override
  void updateRenderObject(
    BuildContext context,
    RenderSliverSpacing renderObject,
  ) {
    renderObject.size = size;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('size', size));
  }
}

class RenderSliverSpacing(var double _size) extends RenderSliver {
  double get size => _size;

  set size(double value) {
    if (_size != value) {
      _size = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    final paintExtent = calculatePaintOffset(constraints, from: 0, to: size);
    final cacheExtent = calculateCacheOffset(constraints, from: 0, to: size);
    geometry = SliverGeometry(
      scrollExtent: size,
      paintExtent: paintExtent,
      cacheExtent: cacheExtent,
      maxPaintExtent: size,
      hitTestExtent: paintExtent,
      hasVisualOverflow:
          size > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('size', size));
  }
}
