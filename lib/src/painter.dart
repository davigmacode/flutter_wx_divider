import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'types.dart';

/// A custom painter class that draws a border based on a provided `ShapeBorder` object.
///
/// This class is used internally by the [WxBorder] widget. It takes a `ShapeBorder` and an optional
/// `textDirection` as parameters, and draws the border shape on the canvas.
class WxDividerPainter extends CustomPainter {
  /// Creates a new [WxDividerPainter] instance.
  ///
  /// [shape] is required.
  WxDividerPainter({
    this.pattern = WxDividerPainter.solid,
    this.direction = Axis.horizontal,
    this.color = const Color(0xFF000000),
    this.gradient,
    this.thickness = 1,
    this.formatter,
  });

  /// A constant representing a solid border style.
  static const solid = [1.0, 0.0];

  /// A constant representing a dotted border style.
  static const dotted = [1.0, 2.0];

  /// A constant representing a dashed border style.
  static const dashed = [3.0, 2.0];

  /// A constant representing a Morse code-like border style.
  static const morse = [3.0, 2.0, 1.0, 2.0];

  /// The list of doubles defining the on/off durations of the border pattern.
  final List<double> pattern;

  final Axis direction;

  /// The color of this side of the border.
  final Color color;

  /// A gradient to use for painting the border.
  final Gradient? gradient;

  /// The thickness of the line drawn within the divider.
  final double thickness;

  /// Paint formatter
  final PaintFormatter? formatter;

  /// Checks if the border style is solid (pattern is equal to `WxBorderStyle.solid.pattern`).
  bool get isSolid => listEquals(pattern, solid);

  /// Checks if the border style is non-solid (not equal to `WxBorderStyle.solid.pattern`).
  bool get isNonSolid => !isSolid;

  bool get isHorizontal => direction == Axis.horizontal;

  bool get isVertical => !isHorizontal;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..shader = gradient?.createShader(rect);

    if (formatter != null) {
      formatter!(paint, rect);
    }

    if (isSolid) {
      final start = isHorizontal ? rect.centerLeft : rect.topCenter;
      final end = isHorizontal ? rect.centerRight : rect.bottomCenter;
      canvas.drawLine(start, end, paint);
      return;
    }

    final Path path = Path();
    final maxExtent = isHorizontal ? size.width : size.height;
    final crossAxisPoint = isHorizontal ? rect.center.dy : rect.center.dx;

    int index = 0;
    double distance = 0;
    double length = 0;
    bool draw = true;
    while (distance < maxExtent) {
      if (index >= pattern.length) {
        index = 0;
      }
      length = pattern[index++] * thickness;
      if (draw) {
        if (isHorizontal) {
          path
            ..moveTo(distance, crossAxisPoint)
            ..lineTo(distance + length, crossAxisPoint);
        } else {
          path
            ..moveTo(crossAxisPoint, distance)
            ..lineTo(crossAxisPoint, distance + length);
        }
      }
      distance += length;
      draw = !draw;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WxDividerPainter oldDelegate) {
    return listEquals(oldDelegate.pattern, pattern) ||
        oldDelegate.color != color ||
        oldDelegate.gradient != gradient ||
        oldDelegate.thickness != thickness ||
        oldDelegate.formatter != formatter;
  }
}
