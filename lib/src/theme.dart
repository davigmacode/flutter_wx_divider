import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'theme_data.dart';

/// A Widget that controls how descendant [WxDivider] should look like.
class WxDividerTheme extends InheritedTheme {
  /// The properties for descendant [WxDivider]s
  final WxDividerThemeData data;

  /// Creates a theme that controls
  /// how descendant [WxDivider] should look like.
  const WxDividerTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Creates an [WxDividerTheme] that controls the style of
  /// descendant widgets, and merges in the current [WxDividerTheme], if any.
  ///
  /// The [child] arguments must not be null.
  static Widget merge({
    Key? key,
    List<double>? pattern,
    Color? color,
    Gradient? gradient,
    double? thickness,
    int? lines,
    double? extent,
    double? spacing,
    EdgeInsetsGeometry? indent,
    WxDividerThemeData? data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final parent = WxDividerTheme.of(context);
        return WxDividerTheme(
          key: key,
          data: parent.merge(data).copyWith(
                pattern: pattern,
                color: color,
                gradient: gradient,
                thickness: thickness,
                lines: lines,
                extent: extent,
                spacing: spacing,
                indent: indent,
              ),
          child: child,
        );
      },
    );
  }

  /// The [WxDividerTheme] from the closest instance of
  /// this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// WxDividerThemeData theme = WxDividerTheme.of(context);
  /// ```
  static WxDividerThemeData of(BuildContext context) {
    final parentTheme =
        context.dependOnInheritedWidgetOfExactType<WxDividerTheme>();
    if (parentTheme != null) return parentTheme.data;

    final globalTheme = Theme.of(context).extension<WxDividerThemeData>();
    final defaultTheme = WxDividerThemeData.defaults(context);
    return defaultTheme.merge(globalTheme);
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return WxDividerTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(WxDividerTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<WxDividerThemeData>('data', data));
  }
}
