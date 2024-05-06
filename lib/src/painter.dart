import 'dart:ui' show PathMetric;
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'types.dart';

/// A custom painter class that draws a border based on a provided `ShapeBorder` object.
///
/// This class is used internally by the [WxBorder] widget. It takes a `ShapeBorder` and an optional
/// `textDirection` as parameters, and draws the border shape on the canvas.
class WxLinePainter extends CustomPainter {
  /// Creates a new [WxLinePainter] instance.
  ///
  /// [shape] is required.
  WxLinePainter({
    this.pattern = WxLinePainter.solid,
    this.color = const Color(0xFF000000),
    this.gradient,
    this.width = 1,
    this.paintBuilder,
  });

  /// A constant representing a solid border style.
  static const solid = [1.0, 0.0];

  /// A constant representing a dotted border style.
  static const dotted = [1.0];

  /// A constant representing a dashed border style.
  static const dashed = [3.0, 2.0];

  /// A constant representing a Morse code-like border style.
  static const morse = [3.0, 2.0, 1.0, 2.0];

  /// The list of doubles defining the on/off durations of the border pattern.
  final List<double> pattern;

  /// The color of this side of the border.
  final Color color;

  /// A gradient to use for painting the border.
  final Gradient? gradient;

  /// The width of this side of the border, in logical pixels.
  ///
  /// Setting width to 0.0 will result in a hairline border. This means that
  /// the border will have the width of one physical pixel. Hairline
  /// rendering takes shortcuts when the path overlaps a pixel more than once.
  /// This means that it will render faster than otherwise, but it might
  /// double-hit pixels, giving it a slightly darker/lighter result.
  ///
  /// To omit the border entirely, set the [style] to [BorderStyle.none].
  final double width;

  final PaintBuilder? paintBuilder;

  /// Checks if the border style is solid (pattern is equal to `WxBorderStyle.solid.pattern`).
  bool get isSolid => listEquals(pattern, solid);

  /// Checks if the border style is non-solid (not equal to `WxBorderStyle.solid.pattern`).
  bool get isNonSolid => !isSolid;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..shader = gradient?.createShader(rect);

    if (paintBuilder != null) {
      paintBuilder!(paint, rect);
    }

    if (isSolid) {
      canvas.drawLine(rect.centerLeft, rect.centerRight, paint);
      return;
    }

    final source = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, size.height / 2);
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      int index = 0;
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        if (index >= pattern.length) {
          index = 0;
        }
        final double len = pattern[index++] * width;
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
      }
    }

    canvas.drawPath(dest, paint);
  }

  @override
  bool shouldRepaint(WxLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.gradient != gradient ||
        oldDelegate.width != width ||
        oldDelegate.paintBuilder != paintBuilder;
  }
}
