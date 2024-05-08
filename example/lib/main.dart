import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wx_divider/wx_divider.dart';
import 'package:wx_text/wx_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WxDivider Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
        extensions: [
          WxDividerThemeData.defaults(context).copyWith(extent: 20),
        ],
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      children: <Widget>[
        ListTile(
          title: const WxText.displayMedium(
            'WxDivider',
            fontWeight: FontWeight.bold,
            outlineColor: Colors.white,
            outlineWidth: 1,
            shadows: [
              Shadow(
                color: Colors.green,
                blurRadius: 3,
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.blue,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          subtitle: WxAnimatedText(
            duration: const Duration(milliseconds: 2500),
            transition: WxAnimatedText.shimmer(
              colors: [
                Colors.black87,
                Colors.red,
                Colors.amber,
                Colors.black87,
                Colors.black87,
              ],
              stops: [0.0, 0.35, 0.5, 0.65, 1.0],
            ),
            child: const WxText.bodyLarge(
              'A widget that displays a divider with a configurable style, pattern, and child.',
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        const SizedBox(height: 20),
        const Example(
          title: 'Single Line',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WxDivider(),
              WxDivider(
                color: Colors.red,
                pattern: WxDivider.dashed,
              ),
              WxDivider(
                gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
                pattern: WxDivider.dotted,
                thickness: 2,
              ),
              WxDivider(
                gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
                pattern: WxDivider.morse,
                thickness: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Example(
          title: 'Multiple Lines',
          child: Column(
            children: [
              WxDivider(
                thickness: 1,
                lines: 2,
                spacing: 3,
              ),
              WxDivider(
                gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
                pattern: WxDivider.dashed,
                thickness: 2,
                lines: 3,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Example(
          title: 'With Child',
          child: WxDividerTheme.merge(
            extent: 30,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WxDivider(
                  align: WxDividerAlign.start,
                  pattern: WxDivider.solid,
                  thickness: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      'Start',
                      style: TextStyle(height: 1, color: Colors.black54),
                    ),
                  ),
                ),
                WxDivider(
                  pattern: WxDivider.morse,
                  thickness: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      'Center',
                      style: TextStyle(height: 1, color: Colors.black54),
                    ),
                  ),
                ),
                WxDivider(
                  align: WxDividerAlign.end,
                  pattern: WxDivider.dotted,
                  thickness: 1,
                  lines: 2,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      'End',
                      style: TextStyle(height: 1, color: Colors.black54),
                    ),
                  ),
                ),
                WxDivider(
                  pattern: WxDivider.dashed,
                  gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
                  thickness: 1,
                  lines: 2,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 5,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(height: 1, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Example(
          title: 'Vertical Direction',
          child: SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WxDivider(
                  align: WxDividerAlign.start,
                  direction: Axis.vertical,
                  pattern: WxDivider.solid,
                  thickness: 1,
                  indent: EdgeInsets.all(12),
                  gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Icon(
                      Icons.home,
                      color: Colors.black45,
                    ),
                  ),
                ),
                WxVerticalDivider(
                  pattern: WxDivider.dashed,
                  thickness: 1,
                  lines: 2,
                  indent: EdgeInsets.all(12),
                  gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Icon(
                      Icons.search,
                      color: Colors.black45,
                    ),
                  ),
                ),
                WxVerticalDivider(
                  align: WxDividerAlign.end,
                  pattern: WxDivider.dotted,
                  thickness: 2,
                  lines: 3,
                  indent: EdgeInsets.all(12),
                  gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Icon(
                      Icons.power_settings_new,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Example extends StatelessWidget {
  const Example({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: WxText.labelLarge(title),
        ),
        Card.outlined(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
