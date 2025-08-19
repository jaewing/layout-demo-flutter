import 'package:flutter/material.dart';
import 'package:layout_demo_flutter/layout_type.dart';

class SliversPage extends StatelessWidget implements HasLayoutGroup {
  const SliversPage({
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
    // `slivers` is a property of `CustomScrollView` in which
    // we are able to specify a List of widgets. By using widgets
    // with `Sliver` in the name, you are able to make various
    // fancy scrolling effects.
    //
    // Options: lists, grids, expanding headers, etc.
    //
    // Think of it as the `Container` for all of the scrolling content.
    return CustomScrollView(
      slivers: <Widget>[
        // `expandedHeight` is another property you can specify
        // to determine the height when at the top of the page.
        // The height is then reduced as you scroll until the
        // scroll height of the `AppBar` is reached.
        SliverAppBar(
          expandedHeight: 120,
          centerTitle: true,
          // `pinned` determines whether the `AppBar` is
          // shown when scrolling down the page.
          pinned: true,
          title: const Text('Slivers'),
          leading: IconButton(
            icon: Icon(layoutGroup == LayoutGroup.nonScrollable
                ? Icons.filter_1
                : Icons.filter_2),
            onPressed: onLayoutToggle,
          ),
        ),
        // Similar to `GridView`.
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ColoredBox(
                color: Colors.teal[index % 9 == 0 ? 50 : 100 * (index % 9)]!,
                child: Align(
                  alignment: Alignment.center,
                  child: Text('grid item $index'),
                ),
              );
            },
            childCount: 20,
          ),
        ),
        // Similar to `ListView`
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ColoredBox(
                color:
                    Colors.lightBlue[index % 9 == 0 ? 50 : 100 * (index % 9)]!,
                child: Align(
                  alignment: Alignment.center,
                  child: Text('list item $index'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
