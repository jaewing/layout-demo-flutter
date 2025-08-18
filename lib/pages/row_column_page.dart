import 'package:flutter/material.dart';
import 'package:layout_demo_flutter/layout_type.dart';
import 'package:layout_demo_flutter/pages/main_app_bar.dart';
import 'package:layout_demo_flutter/pages/row_column_layout_attributes.dart';

class RowColumnPage extends StatefulWidget implements HasLayoutGroup {
  const RowColumnPage({
    super.key,
    required this.layoutGroup,
    required this.onLayoutToggle,
  });

  @override
  final LayoutGroup layoutGroup;
  @override
  final VoidCallback onLayoutToggle;

  @override
  State<RowColumnPage> createState() => _RowColumnPageState();
}

class _RowColumnPageState extends State<RowColumnPage> {
  var _isRow = true;
  var _mainAxisAlignment = MainAxisAlignment.start;
  var _crossAxisAlignment = CrossAxisAlignment.start;
  var _mainAxisSize = MainAxisSize.min;

  MainAxisAlignment _mainAxisAlignmentFromIndex(int index) => switch (index) {
        0 => MainAxisAlignment.start,
        1 => MainAxisAlignment.end,
        2 => MainAxisAlignment.center,
        3 => MainAxisAlignment.spaceBetween,
        4 => MainAxisAlignment.spaceAround,
        5 => MainAxisAlignment.spaceEvenly,
        _ => MainAxisAlignment.start,
      };

  CrossAxisAlignment _crossAxisAlignmentFromIndex(int index) => switch (index) {
        0 => CrossAxisAlignment.baseline,
        1 => CrossAxisAlignment.start,
        2 => CrossAxisAlignment.end,
        3 => CrossAxisAlignment.center,
        4 => CrossAxisAlignment.stretch,
        _ => CrossAxisAlignment.start,
      };

  void _updateLayout(int index) {
    setState(() {
      _isRow = index == 0;
    });
  }

  void _updateMainAxisAlignment(int index) {
    setState(() {
      _mainAxisAlignment = _mainAxisAlignmentFromIndex(index);
    });
  }

  void _updateCrossAxisAlignment(int index) {
    setState(() {
      _crossAxisAlignment = _crossAxisAlignmentFromIndex(index);
    });
  }

  void _updateMainAxisSize(int index) {
    setState(() {
      _mainAxisSize = index == 0 ? MainAxisSize.min : MainAxisSize.max;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        layoutGroup: widget.layoutGroup,
        layoutType: LayoutType.rowColumn,
        bottom: PreferredSize(
          preferredSize: const Size(0.0, 160.0),
          child: RowColumnLayoutAttributes(
            onUpdateLayout: _updateLayout,
            onUpdateMainAxisAlignment: _updateMainAxisAlignment,
            onUpdateCrossAxisAlignment: _updateCrossAxisAlignment,
            onUpdateMainAxisSize: _updateMainAxisSize,
          ),
        ),
        onLayoutToggle: widget.onLayoutToggle,
      ),
      body: ColoredBox(
        color: Colors.yellow,
        child: _isRow
            // Both `Row` and `Column` have properties for alignment, size, and `children`.
            //
            // `children` is a property of both `Row` and `Column` that takes a `List` type argument
            // that contains our widgets we intend to group together either vertically or horizontally.
            //
            // `mainAxisSize`:
            // Determines how much space our `Row` or `Column` takes within its parent
            // container.
            // Two arugment value options: `min` or `max`
            //
            // In the case of our example we defined a private variable `_mainAxisSize`
            // in our `_RowColumnPageState` class. We initialized the value of that
            // variable to `min` which is therefore our default behavior.
            //
            // `min` -> takes up the least amount of space possible in the respective axis
            // of its parent to fit all `children` widgets
            //
            // `max` -> takes up the most amount of space possible of it's parent widget's respective axis
            //
            // `mainAxisAlignment`:
            // Determines the alignment of the `children` widgets.
            // Arguments: `start`, `end`, `center`, `spaceBetween`, `spaceAround`, and `spaceEvenly`
            //
            // `start`-> aligns all the children widgets against the left side of the screen (smooshed together)
            //
            // `end`-> same as `start` but aligns all children widgets on right side of screen
            //
            // `center`-> aligns all children widgets, grouped together, in the center of the screen
            //
            // `spaceBetween`-> places children widgets with the most possible equal space between each widget
            //
            // `spaceAround`-> divides the total space available into equal amounts on either side of each widget
            //
            // `spaceEvenly`-> basically same as `spaceAround` but leaves a full unit of space to the left of the left-most
            // widget and to the right of the right-most widget.
            //
            // `crossAxisAlignment`:
            // Refers to the alignment of the axis orthogonal to the main axis.
            //    For `Row`,
            //      the `mainAxis` is horizontal, so the `crossAxis` is vertical.
            //    For `Column`,
            //      the `mainAxis` is vertical, so the `crossAxis` is horizontal.
            // Arguments: `start`, `end`, `center`, `stretch`
            //
            // `stretch`: allows you to extend the widget to fill the entire space
            // available within its parent in the `crossAxis` direction
            ? Row(
                mainAxisAlignment: _mainAxisAlignment,
                // Added this line to resolve a dependency between
                // defining `mainAxisAlignment.baseline` and needing
                // to also define a corresponding `textBaseLine`.
                crossAxisAlignment: _crossAxisAlignment,
                // `alphasbetic` and `ideographic` are both options here.
                textBaseline: TextBaseline.alphabetic,
                mainAxisSize: _mainAxisSize,
                children: const [
                  Icon(Icons.stars, size: 50.0),
                  Icon(Icons.stars, size: 100.0),
                  Icon(Icons.stars, size: 50.0),
                ],
              )
            : Column(
                mainAxisAlignment: _mainAxisAlignment,
                // Added this line to resolve a dependency between
                // defining `mainAxisAlignment.baseline` and needing
                // to also define a corresponding `textBaseLine`.
                crossAxisAlignment: _crossAxisAlignment,
                textBaseline: TextBaseline.alphabetic,
                mainAxisSize: _mainAxisSize,
                children: const [
                  Icon(Icons.stars, size: 50.0),
                  Icon(Icons.stars, size: 100.0),
                  Icon(Icons.stars, size: 50.0),
                ],
              ),
      ),
    );
  }
}
