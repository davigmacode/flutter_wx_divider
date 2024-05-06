import 'package:flutter/widgets.dart';
import 'package:wx_divider/src/painter.dart';
import 'types.dart';

class WxDivider extends StatelessWidget {
  const WxDivider({
    super.key,
    this.pattern = WxDivider.solid,
    this.color = const Color(0xFF000000),
    this.gradient,
    this.width = 1,
    this.paint,
    this.align = WxDividerAlign.center,
    this.child,
  }) : assert(pattern.length > 0);

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

  final PaintBuilder? paint;

  final WxDividerAlign align;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final line = CustomPaint(
      foregroundPainter: WxLinePainter(
        pattern: pattern,
        color: color,
        gradient: gradient,
        width: width,
        paintBuilder: paint,
      ),
    );

    if (child == null) return line;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: line),
      ],
    );
  }
}
