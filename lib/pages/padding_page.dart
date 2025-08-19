import 'package:flutter/material.dart';
import 'package:layout_demo_flutter/layout_type.dart';
import 'package:layout_demo_flutter/pages/main_app_bar.dart';

class PaddingPage extends StatelessWidget implements HasLayoutGroup {
  const PaddingPage({
    super.key,
    required this.layoutGroup,
    required this.onLayoutToggle,
  });

  @override
  final LayoutGroup layoutGroup;
  @override
  final VoidCallback onLayoutToggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        layoutGroup: layoutGroup,
        layoutType: LayoutType.padding,
        onLayoutToggle: onLayoutToggle,
      ),
      body: Column(
        // Here we specify `stretch` to make sure our `Column`
        // fills as much vertical space as there is available.
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // `Padding` can be added vertically or horizontally.
          //
          // Also are able to specify the direction in which
          // you want the padding to be added. You can specify a single
          // side with either:
          // `left`, `right`, `top`, `bottom`
          //
          // or you can specify padding on every side with:
          // `all`
          //
          // Here we implement our custom widget `VerticalPadding` that
          // we defined down below.
          VerticalPadding(
            color: Colors.green[100] ?? Colors.green,
            child: const ColoredText(text: 'First', color: Colors.green),
          ),
          VerticalPadding(
            color: Colors.red[100] ?? Colors.red,
            child: const ColoredText(text: 'Second', color: Colors.red),
          ),
          // Easy way of having consistent spacing that is easy to
          // to structure in code in a readable way and be called
          // repeatedly if you create a custom `SizedBox` widget for
          // both the vertical and horizontal axis'.
          //
          // When you want specific dimensional padding, use `SizedBox`.
          // Otherwise use `Expanded` if you don't have hard dimensional
          // requirements in mind.
          //
          // The combination of `SizedBox` and `Expanded` will allow you to
          // create a multitude of layouts that are both as flexible and rigid
          // as your heart desires.
          //
          // NOTE: The `flex` property is actually optional. If you remove
          // the `flex` property from all of the `children of `Expanded`:
          // the `Expanded` widgets will share the space equally amongst
          // themselves.
          const SizedBox(
            height: 50.0,
            child: ColoredText(
                text: '50 pt', color: Colors.white, textColor: Colors.black),
          ),
          VerticalPadding(
            color: Colors.blue[100] ?? Colors.blue,
            child: const ColoredText(text: 'Third', color: Colors.blue),
          ),
          const Expanded(
            flex: 1,
            child: ColoredText(
                text: 'flex: 1', color: Colors.white, textColor: Colors.black),
          ),
          VerticalPadding(
            color: Colors.purple[100] ?? Colors.purple,
            child: const ColoredText(text: 'Fourth', color: Colors.purple),
          ),
          const Expanded(
            flex: 2,
            child: ColoredText(
                text: 'flex: 2', color: Colors.white, textColor: Colors.black),
          ),
          VerticalPadding(
            color: Colors.brown[100] ?? Colors.brown,
            child: const ColoredText(text: 'Fifth', color: Colors.brown),
          ),
        ],
      ),
    );
  }
}

// Custom widget we created to show the properties of the
// `Padding` widget.
//
// We return another custom widget called `ColoredBox` to
// visually show the spacing characteristics of defining
// a `Padding` widget with the `padding` property being
// passed `symmetric` `vertical` padding.
//
// NOTE: The naming is a bit confusing here, there is both a
// `padding` member we define in the constructor for `VerticalPadding`
// and a `padding` property for the `Padding` widget.
class VerticalPadding extends StatelessWidget {
  const VerticalPadding({
    super.key,
    required this.child,
    this.padding = 16.0,
    this.color = Colors.white,
  });

  final double padding;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: child,
      ),
    );
  }
}

class ColoredText extends StatelessWidget {
  const ColoredText({
    super.key,
    required this.text,
    required this.color,
    this.textColor = Colors.white,
  });
  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Align(
        alignment: AlignmentDirectional.center,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 32.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
