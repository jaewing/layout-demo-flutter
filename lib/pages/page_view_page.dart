import 'package:flutter/material.dart';
import 'package:layout_demo_flutter/layout_type.dart';
import 'package:layout_demo_flutter/pages/main_app_bar.dart';

class PageViewPage extends StatelessWidget implements HasLayoutGroup {
  const PageViewPage({
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
        layoutType: LayoutType.pageView,
        onLayoutToggle: onLayoutToggle,
      ),
      // `PageView` allows you to swipe between pages.
      // It also has a property that allows you to choose
      // whether the "auto-snap" feature is enabled or not.
      //
      // "Auto-snap": when you have partially swiped between two pages
      // and then you release, it will snap to the page that is
      // taking up the majority of the screen when released.
      //
      // Great for "step-by-step" processes.
      // E.g., onboarding a new hire
      body: PageView(
        scrollDirection: Axis.vertical,
        children: const [
          PageContent(index: 1, color: Colors.green),
          PageContent(index: 2, color: Colors.blue),
          PageContent(index: 3, color: Colors.indigo),
          PageContent(index: 4, color: Colors.red),
        ],
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  const PageContent({super.key, required this.index, required this.color});
  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Align(
        alignment: AlignmentDirectional.center,
        child: Text(
          '$index',
          style: const TextStyle(fontSize: 132.0, color: Colors.white),
        ),
      ),
    );
  }
}
