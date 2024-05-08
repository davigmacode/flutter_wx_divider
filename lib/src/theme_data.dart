import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Defines the visual properties of [WxDivider].
///
/// Descendant widgets obtain the current [WxDividerThemeData] object using
/// `WxDividerTheme.of(context)`. Instances of [WxDividerThemeData]
/// can be customized with [WxDividerThemeData.copyWith] or [WxDividerThemeData.merge].
@immutable
class WxDividerThemeData extends ThemeExtension<WxDividerThemeData>
    with Diagnosticable {
  /// The circular list of doubles defining the on/off length of the divider pattern.
  final List<double> pattern;

  /// The color of this side of the divider. Overrides if gradient not `null`.
  final Color color;

  /// A gradient to use for painting the divider.
  final Gradient? gradient;

  /// The thickness of the line drawn within the divider.
  final double thickness;

  /// The number of lines to draw.
  final int lines;

  /// Representing the minimum width or height of the divider, depending on its direction.
  final double extent;

  /// The spacing between lines.
  final double spacing;

  /// The amount of indent applied to the divider on each side.
  final EdgeInsetsGeometry indent;

  /// Creates a theme data that can be used for [WxDividerTheme].
  const WxDividerThemeData({
    required this.pattern,
    required this.color,
    required this.thickness,
    required this.lines,
    required this.extent,
    required this.spacing,
    required this.indent,
    this.gradient,
  });

  /// An [WxDividerThemeData] with some reasonable default values.
  static const fallback = WxDividerThemeData(
    pattern: [1.0, 0.0],
    color: Colors.black54,
    thickness: 1.0,
    lines: 1,
    extent: 8.0,
    spacing: 2.0,
    indent: EdgeInsets.zero,
  );

  /// Creates a [WxDividerThemeData] from another one that probably null.
  WxDividerThemeData.from([WxDividerThemeData? other])
      : pattern = other?.pattern ?? fallback.pattern,
        color = other?.color ?? fallback.color,
        gradient = other?.gradient ?? fallback.gradient,
        thickness = other?.thickness ?? fallback.thickness,
        lines = other?.lines ?? fallback.lines,
        extent = other?.extent ?? fallback.extent,
        spacing = other?.spacing ?? fallback.spacing,
        indent = other?.indent ?? fallback.indent;

  /// A [WxDividerThemeData] with default values.
  factory WxDividerThemeData.defaults(BuildContext context) {
    final dividerTheme = Theme.of(context).dividerTheme;
    return fallback.copyWith(
      color: dividerTheme.color,
      thickness: dividerTheme.thickness,
      extent: dividerTheme.space,
    );
  }

  /// Creates a copy of this [WxDividerThemeData] but with
  /// the given fields replaced with the new values.
  @override
  WxDividerThemeData copyWith({
    List<double>? pattern,
    Color? color,
    Gradient? gradient,
    double? thickness,
    int? lines,
    double? extent,
    double? spacing,
    EdgeInsetsGeometry? indent,
  }) {
    return WxDividerThemeData(
      pattern: pattern ?? this.pattern,
      color: color ?? this.color,
      gradient: gradient ?? this.gradient,
      thickness: thickness ?? this.thickness,
      lines: lines ?? this.lines,
      extent: extent ?? this.extent,
      spacing: spacing ?? this.spacing,
      indent: indent ?? this.indent,
    );
  }

  /// Creates a copy of this [WxDividerThemeData] but with
  /// the given fields replaced with the new values.
  WxDividerThemeData merge(WxDividerThemeData? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      pattern: other.pattern,
      color: other.color,
      gradient: other.gradient,
      thickness: other.thickness,
      lines: other.lines,
      extent: other.extent,
      spacing: other.spacing,
      indent: other.indent,
    );
  }

  @override
  WxDividerThemeData lerp(WxDividerThemeData? other, double t) {
    if (other == null) return this;
    final lowestMultiple = pattern.length * other.pattern.length;
    return WxDividerThemeData(
      pattern: List<double>.generate(
        lowestMultiple,
        (i) {
          final len = other.pattern.length;
          return lerpDouble(pattern[i % len], pattern[i % len], t) ?? 0;
        },
      ),
      color: Color.lerp(color, other.color, t) ?? color,
      gradient: Gradient.lerp(gradient, other.gradient, t) ?? gradient,
      thickness: lerpDouble(thickness, other.thickness, t) ?? thickness,
      lines: (lines + (other.lines - lines) * t).round(),
      extent: lerpDouble(extent, other.extent, t) ?? extent,
      spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
      indent: EdgeInsetsGeometry.lerp(indent, other.indent, t) ?? indent,
    );
  }

  Map<String, dynamic> toMap() => {
        'pattern': pattern,
        'color': color,
        'gradient': gradient,
        'thickness': thickness,
        'extent': extent,
        'spacing': spacing,
        'indent': indent,
      };

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is WxDividerThemeData && mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => Object.hashAll(toMap().values);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    toMap().entries.forEach((el) {
      properties.add(DiagnosticsProperty(el.key, el.value, defaultValue: null));
    });
  }
}
