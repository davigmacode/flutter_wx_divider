import 'package:flutter/painting.dart';

/// A callback that allows customization of the `Paint` object before it is used to draw a `WxDivider`.
///
/// This can be useful for applying additional effects or styles to the divider.
typedef PaintCallback = void Function(Paint paint, Rect rect);

/// An enum representing the possible alignments for the child widget within a `WxDivider`.
enum WxDividerAlign {
  /// The child is aligned at the start of the divider.
  start,

  /// The child is aligned in the center of the divider.
  center,

  /// The child is aligned at the end of the divider.
  end,
}
