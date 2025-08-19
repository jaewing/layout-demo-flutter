import 'package:flutter/material.dart';
import 'package:layout_demo_flutter/layout_type.dart';
import 'package:flutter/rendering.dart';

// Here we define a custom widget to display our
// `HeroHeader` image.
class HeroHeader implements SliverPersistentHeaderDelegate {
  HeroHeader({
    required this.layoutGroup,
    required this.onLayoutToggle,
    // Height of the "Hero Image" while scrolling down.
    required this.minExtent,
    // Height of the "Hero Image" when the page is scrolled
    // to the top.
    required this.maxExtent,
  });
  final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;
  @override
  double maxExtent;
  @override
  double minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      // `expand` ensures our `Stack` widget will take
      // up all the space available from its parent.
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/ronnie-mayo-361348-unsplash.jpg',
          // `cover` ensures the image will take up all
          // of the available space allotted for it.
          fit: BoxFit.cover,
        ),
        // Provides a gradient effect to the image so it's
        // easier to read the "Hero Image" text overlayed
        // on top of it and make it feel more like a background
        // (as it should be).
        //
        // Gradient is between the Text and the Image.
        const DecoratedBox(
          decoration: BoxDecoration(
            // Provides the desired gradient effect.
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        // Placement of the button to switch between App Modes
        // top left.
        Positioned(
          left: 4.0,
          top: 4.0,
          // `SafeArea` is important to use at the top of a screen
          // so we don't collide with the top-notch of iPhones and
          // other unique Phone screen features.
          child: SafeArea(
            child: IconButton(
              icon: Icon(layoutGroup == LayoutGroup.nonScrollable
                  ? Icons.filter_1
                  : Icons.filter_2),
              onPressed: onLayoutToggle,
            ),
          ),
        ),
        // Placement of Text in bottom left.
        const Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            'Hero Image',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  // If `shouldRebuild` is set to `false`, then the header won't be rebuilt
  // even if the instance of the delegate changed.
  //
  // Hence, why we ensure `true` is returned here.
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  // This property is only useful for "Floating" headers. Otherwise,
  // value should be assigned to `null`.
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      null;

  @override
  TickerProvider? get vsync => null;
}

class HeroPage extends StatelessWidget implements HasLayoutGroup {
  HeroPage({
    super.key,
    required this.layoutGroup,
    required this.onLayoutToggle,
  });

  @override
  final LayoutGroup layoutGroup;
  @override
  final VoidCallback onLayoutToggle;

  final List<String> assetNames = [
    'assets/brady-bellini-212790-unsplash.jpg',
    'assets/stefan-stefancik-105587-unsplash.jpg',
    'assets/simon-fitall-530083-unsplash.jpg',
    'assets/anton-repponen-99530-unsplash.jpg',
    'assets/kevin-cochran-524957-unsplash.jpg',
    'assets/samsommer-72299-unsplash.jpg',
    'assets/simon-matzinger-320332-unsplash.jpg',
    'assets/meng-ji-102492-unsplash.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _scrollView(context),
    );
  }

  Widget _scrollView(BuildContext context) {
    // Use LayoutBuilder to get the hero header size while keeping the image aspect-ratio
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: HeroHeader(
            layoutGroup: layoutGroup,
            onLayoutToggle: onLayoutToggle,
            minExtent: 150.0,
            maxExtent: 250.0,
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 0.75,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                padding: _edgeInsetsForIndex(index),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    // Here we cycle through the available images.
                    assetNames[index % assetNames.length],
                  ),
                ),
              );
            },
            // Then we repeat the sequence twice.
            childCount: assetNames.length * 2,
          ),
        ),
      ],
    );
  }

  EdgeInsets _edgeInsetsForIndex(int index) {
    if (index % 2 == 0) {
      return const EdgeInsets.only(
          top: 4.0, left: 8.0, right: 4.0, bottom: 4.0);
    } else {
      return const EdgeInsets.only(
          top: 4.0, left: 4.0, right: 8.0, bottom: 4.0);
    }
  }
}
