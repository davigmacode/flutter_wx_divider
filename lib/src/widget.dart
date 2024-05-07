import 'package:flutter/widgets.dart';
import 'package:wx_divider/src/painter.dart';
import 'types.dart';

class WxDivider extends StatelessWidget {
  const WxDivider({
    super.key,
    this.pattern = WxDivider.solid,
    this.color,
    this.gradient,
    this.thickness,
    this.count,
    this.spacing,
    this.paint,
    this.align = WxDividerAlign.center,
    this.child,
  })  : assert(thickness == null || thickness > 0),
        assert(count == null || count > 0);

  /// A constant representing a solid border style.
  static const solid = WxLinePainter.solid;

  /// A constant representing a dotted border style.
  static const dotted = WxLinePainter.dotted;

  /// A constant representing a dashed border style.
  static const dashed = WxLinePainter.dashed;

  /// A constant representing a Morse code-like border style.
  static const morse = WxLinePainter.morse;

  /// The list of doubles defining the on/off durations of the border pattern.
  final List<double> pattern;

  /// The color of this side of the border. overrides if gradient not null
  final Color? color;

  /// A gradient to use for painting the border.
  final Gradient? gradient;

  /// The thickness of the line drawn within the divider.
  final double? thickness;

  final int? count;

  final double? spacing;

  final PaintBuilder? paint;

  final WxDividerAlign align;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? const Color(0xFF000000);
    final effectiveThickness = thickness ?? 1;
    final effectiveCount = count ?? 1;
    final effectiveSpacing = spacing ?? 2.0;

    // Build single line
    Widget result = CustomPaint(
      foregroundPainter: WxLinePainter(
        pattern: pattern,
        color: effectiveColor,
        gradient: gradient,
        thickness: effectiveThickness,
        paintBuilder: paint,
      ),
      size: Size(double.infinity, effectiveThickness),
    );

    // Returns single line
    if (effectiveCount == 1) return result;

    // Build multiple lines
    result = Column(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(effectiveCount, (i) {
        if (i > 0) {
          return Padding(
            padding: EdgeInsets.only(top: effectiveSpacing),
            child: result,
          );
        }
        return result;
      }),
    );

    // Returns without child
    if (child == null) return result;

    // Returns with child
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (align != WxDividerAlign.start) Expanded(child: result),
        child!,
        if (align != WxDividerAlign.end) Expanded(child: result),
      ],
    );
  }
}
