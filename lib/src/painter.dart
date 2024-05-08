import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'types.dart';

/// A custom painter that draws a divider with a configurable style and pattern.
class WxDividerPainter extends CustomPainter {
  /// Creates a divider painter with the provided configurations.
  ///
  /// - [pattern]: The circular list of doubles defining the on/off length of the divider pattern.
  ///   Defaults to `WxDividerPainter.solid`.
  /// - [direction]: The direction of the divider. Defaults to `Axis.horizontal`.
  /// - [color]: The color of the divider. Defaults to `black`.
  /// - [gradient]: A gradient to use for painting the divider.
  /// - [thickness]: The thickness of the line drawn within the divider. Defaults to 1.0.
  /// - [onPaint]: A callback that allows customization of the paint object before drawing.
  WxDividerPainter({
    this.pattern = WxDividerPainter.solid,
    this.direction = Axis.horizontal,
    this.color = const Color(0xFF000000),
    this.gradient,
    this.thickness = 1,
    this.onPaint,
  })  : assert(pattern.isNotEmpty, 'The pattern should not be empty'),
        assert(pattern.first > 0 || pattern.length > 1,
            'If the pattern has only a single value, it must be greater than 0');

  /// A constant representing a solid divider style.
  static const solid = [1.0, 0.0];

  /// A constant representing a dotted divider style.
  static const dotted = [1.0, 2.0];

  /// A constant representing a dashed divider style.
  static const dashed = [3.0, 2.0];

  /// A constant representing a Morse code-like divider style.
  static const morse = [3.0, 2.0, 1.0, 2.0];

  /// The circular list of doubles defining the on/off length of the divider pattern.
  final List<double> pattern;

  /// The direction of the divider.
  final Axis direction;

  /// The color of this side of the divider.
  final Color color;

  /// A gradient to use for painting the divider.
  final Gradient? gradient;

  /// The thickness of the line drawn within the divider.
  final double thickness;

  /// A callback that allows customization of the paint object before drawing.
  final PaintCallback? onPaint;

  /// Whether the divider style is solid (pattern is equal to `solid.pattern`).
  bool get isSolid => listEquals(pattern, solid);

  /// Whether the divider style is non-solid (not equal to `solid.pattern`).
  bool get isNonSolid => !isSolid;

  /// Whether the divider direction is horizontal.
  bool get isHorizontal => direction == Axis.horizontal;

  /// Whether the divider direction is vertical.
  bool get isVertical => !isHorizontal;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..shader = gradient?.createShader(rect);

    if (onPaint != null) {
      onPaint!(paint, rect);
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
        final point = distance + length;
        final dest = point > maxExtent ? maxExtent : point;
        if (isHorizontal) {
          path
            ..moveTo(distance, crossAxisPoint)
            ..lineTo(dest, crossAxisPoint);
        } else {
          path
            ..moveTo(crossAxisPoint, distance)
            ..lineTo(crossAxisPoint, dest);
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
        oldDelegate.onPaint != onPaint;
  }
}
