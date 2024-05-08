[![Pub Version](https://img.shields.io/pub/v/wx_divider)](https://pub.dev/packages/wx_divider) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_wx_divider) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

A widget that displays a divider with a configurable style, pattern, and child. It can be
horizontal or vertical, with a solid, dotted, dashed, or Morse code-like pattern.
You can also customize the color, thickness, and number of lines.

[![Preview](https://github.com/davigmacode/flutter_wx_divider/raw/main/media/preview.gif)](https://davigmacode.github.io/flutter_wx_divider)

[Demo](https://davigmacode.github.io/flutter_wx_divider)

## Features

* **Orientation**: The divider can be displayed horizontally or vertically by setting the `direction` property to `Axis.horizontal` or `Axis.vertical`, respectively.
* **Line Pattern**: Control the line pattern using the `pattern` property. Supported options include:
  * WxDivider.solid (default)
  * WxDivider.dashed
  * WxDivider.dotted
  * WxDivider.morse (predefined morse code pattern)
  * Provide a custom array for creating custom patterns, example `<double>[2,1,3]`.
* **Thickness**: Set the thickness of the divider line using the thickness property.
* **Color and Gradient**: Customize the color of the divider line using the `color` property. You can also define a gradient for the line using the `gradient` property.
* **Multiple Lines**: Create dividers with multiple lines using the `lines` property to specify the number of lines and the `spacing` property to control the space between lines.
* **Indentation**: Indent the divider from the start using the indent property.
* **Child and Alignment**: Include a child widget within the divider using the `child` property. The `align` property allows you to position the child widget within the divider (`start`, `center`, `end`).
* **Customization Callback**: The `onPaint` callback provides access to the `Paint` object before it's used to draw the divider. This allows for advanced customization of the divider's appearance.

## Usage

To delve deeper into the technical details of `wx_divider`'s classes, methods, and properties, please refer to the official [API Reference](https://pub.dev/documentation/wx_divider/latest/).

```dart
import 'package:wx_divider/wx_divider.dart';

// Horizontal divider with dashed line pattern
WxDivider(
  direction: Axis.horizontal,
  pattern: WxDivider.dashed,
  color: Colors.grey,
  thickness: 2.0,
  lines: 2,
  spacing: 5.0,
  child: Text('My Text'),
  align: WxDividerAlign.center,
);

// Vertical divider with custom color and gradient
WxDivider(
  direction: Axis.vertical,
  thickness: 1.0,
  color: Colors.blue,
  gradient: LinearGradient(
    colors: [Colors.blue, Colors.lightBlue],
  ),
  onPaint: (paint, rect) {
    // Modify paint object for custom effects
  },
);
```

### WxDividerAlign:

This enum defines the possible alignments for the child widget relative to the `WxDivider`. It consists of the following options:

* `start`: Aligns the child widget at the beginning of the divider (left for horizontal, top for vertical).
* `center`: Aligns the child widget in the center of the divider.
* `end`: Aligns the child widget at the end of the divider (right for horizontal, bottom for vertical).

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.