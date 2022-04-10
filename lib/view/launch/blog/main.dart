import 'package:flutter/material.dart';

// import 'package:lidea/provider.dart';
// import 'package:lidea/intl.dart';
import 'package:lidea/view/main.dart';
// import 'package:lidea/icon.dart';

// import '/core/main.dart';
// import '/type/main.dart';
import '/widget/main.dart';

part 'bar.dart';
part 'state.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.arguments}) : super(key: key);

  final Object? arguments;

  static const route = '/blog';
  static const icon = Icons.low_priority_outlined;
  static const name = 'Blog';
  static const description = '...';
  static final uniqueKey = UniqueKey();

  @override
  State<StatefulWidget> createState() => _View();
}

class _View extends _State with _Bar {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewPage(
        controller: scrollController,
        child: CustomScrollView(
          controller: scrollController,
          slivers: sliverWidgets(),
        ),
      ),
    );
  }

  List<Widget> sliverWidgets() {
    return [
      ViewHeaderSliverSnap(
        pinned: true,
        floating: true,
        padding: MediaQuery.of(context).viewPadding,
        heights: const [kToolbarHeight, 40],
        overlapsBackgroundColor: Theme.of(context).primaryColor,
        overlapsBorderColor: Theme.of(context).shadowColor,
        builder: bar,
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          <Widget>[
            WidgetButton(
              child: const Chip(
                avatar: Icon(Icons.arrow_back_ios_new_rounded),
                labelPadding: EdgeInsets.zero,
                label: Text('Back'),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            WidgetButton(
              child: const Chip(
                label: Text('Continue to article'),
              ),
              onPressed: () => core.navigate(to: '/article'),
            ),
            WidgetButton(
              child: const Chip(
                label: Text('Navigate to search'),
              ),
              onPressed: () => core.navigate(
                to: '/search',
                routePush: false,
              ),
            ),
          ],
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.all(15),
              // color: Colors.grey[100 * (index % 9 + 1)],
              color: Colors.grey[100 * (index % 5 + 1)],
              // alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10),
                // height: 80,
                child: Text(
                  "Item $index",
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            );
          },
          childCount: 1000,
        ),
      ),
    ];
  }
}
