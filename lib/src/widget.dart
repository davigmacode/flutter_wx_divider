import 'package:flutter/widgets.dart';
import 'package:wx_divider/src/painter.dart';
import 'types.dart';

/// A widget that displays a divider with a configurable style, pattern, and child.
///
/// A divider can be used to visually separate sections of content. It can be
/// horizontal or vertical, with a solid, dotted, dashed, or Morse code-like pattern.
/// You can also customize the color, thickness, and number of lines.
class WxDivider extends StatelessWidget {
  /// Creates a divider widget.
  ///
  /// - [pattern]: The circular list of doubles defining the on/off length of the divider pattern.
  ///   Defaults to `WxDivider.solid`.
  /// - [direction]: The direction of the divider. Defaults to `Axis.horizontal`.
  /// - [color]: The color of this side of the divider. Overrides if gradient is not `null`.
  /// - [gradient]: A gradient to use for painting the divider.
  /// - [thickness]: The thickness of the line drawn within the divider.
  /// - [lines]: The number of lines to draw. Defaults to 1.
  /// - [spacing]: The spacing between lines. Defaults to 2.0.
  /// - [indent]: The amount of indent applied to the divider on each side.
  /// - [formatter]: A callback that allows customization of the paint object before drawing.
  /// - [align]: The alignment of the child widget within the divider. Defaults to `WxDividerAlign.center`.
  /// - [child]: The widget to display within the divider.
  const WxDivider({
    super.key,
    this.pattern = WxDivider.solid,
    this.direction = Axis.horizontal,
    this.color,
    this.gradient,
    this.thickness,
    this.lines,
    this.spacing,
    this.formatter,
    this.align = WxDividerAlign.center,
    this.indent,
    this.child,
  })  : assert(thickness == null || thickness > 0),
        assert(lines == null || lines > 0),
        assert(spacing == null || spacing >= 0);

  /// A constant representing a solid divider style.
  static const solid = WxDividerPainter.solid;

  /// A constant representing a dotted divider style.
  static const dotted = WxDividerPainter.dotted;

  /// A constant representing a dashed divider style.
  static const dashed = WxDividerPainter.dashed;

  /// A constant representing a Morse code-like divider style.
  static const morse = WxDividerPainter.morse;

  /// The circular list of doubles defining the on/off length of the divider pattern.
  final List<double> pattern;

  /// The direction of the divider.
  final Axis direction;

  /// The color of this side of the divider. Overrides if gradient not `null`.
  final Color? color;

  /// A gradient to use for painting the divider.
  final Gradient? gradient;

  /// The thickness of the line drawn within the divider.
  final double? thickness;

  /// The number of lines to draw.
  final int? lines;

  /// The spacing between lines.
  final double? spacing;

  /// The amount of indent applied to the divider on each side.
  final EdgeInsetsGeometry? indent;

  /// A callback that allows customization of the paint object before drawing.
  final PaintFormatter? formatter;

  /// The alignment of the child widget within the divider.
  final WxDividerAlign align;

  /// The widget to display within the divider.
  final Widget? child;

  /// Whether the divider direction is horizontal.
  bool get isHorizontal => direction == Axis.horizontal;

  /// Whether the divider direction is vertical.
  bool get isVertical => !isHorizontal;

  /// The amount of indent applied to the divider on each side.
  EdgeInsetsGeometry get defaultIndent => isHorizontal
      ? const EdgeInsets.symmetric(vertical: 8)
      : const EdgeInsets.symmetric(horizontal: 8);

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? const Color(0xFF000000);
    final effectiveThickness = thickness ?? 1;
    final effectiveCount = lines ?? 1;
    final effectiveSpacing = spacing ?? 2.0;
    final effectiveIndent = indent ?? defaultIndent;

    // Build single line
    Widget result = CustomPaint(
      foregroundPainter: WxDividerPainter(
        direction: direction,
        pattern: pattern,
        color: effectiveColor,
        gradient: gradient,
        thickness: effectiveThickness,
        formatter: formatter,
      ),
      size: isHorizontal
          ? Size(double.infinity, effectiveThickness)
          : Size(effectiveThickness, double.infinity),
    );

    // Returns single line
    if (effectiveCount == 1 && child == null) {
      return Padding(
        padding: effectiveIndent,
        child: result,
      );
    }

    // Build multiple lines
    result = Flex(
      direction: isHorizontal ? Axis.vertical : Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(effectiveCount, (i) {
        if (i > 0) {
          return Padding(
            padding: EdgeInsets.only(
              top: isHorizontal ? effectiveSpacing : 0,
              left: isVertical ? effectiveSpacing : 0,
            ),
            child: result,
          );
        }
        return result;
      }),
    );

    // Returns without child
    if (child == null) {
      return Padding(
        padding: effectiveIndent,
        child: result,
      );
    }

    // Returns with child
    return Padding(
      padding: effectiveIndent,
      child: Flex(
        direction: direction,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (align != WxDividerAlign.start) Expanded(child: result),
          child!,
          if (align != WxDividerAlign.end) Expanded(child: result),
        ],
      ),
    );
  }
}

/// A convenience widget that creates a vertical divider using a `WxDivider` with a fixed direction.
class WxVerticalDivider extends WxDivider {
  /// Creates a vertical divider widget.
  ///
  /// The same parameters as `WxDivider` apply.
  const WxVerticalDivider({
    super.key,
    super.pattern = WxDivider.solid,
    super.color,
    super.gradient,
    super.thickness,
    super.lines,
    super.spacing,
    super.indent,
    super.formatter,
    super.align = WxDividerAlign.center,
    super.child,
  }) : super(direction: Axis.vertical);

  /// A constant representing a solid divider style.
  static const solid = WxDividerPainter.solid;

  /// A constant representing a dotted divider style.
  static const dotted = WxDividerPainter.dotted;

  /// A constant representing a dashed divider style.
  static const dashed = WxDividerPainter.dashed;

  /// A constant representing a Morse code-like divider style.
  static const morse = WxDividerPainter.morse;
}
