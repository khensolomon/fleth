import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/services.dart';

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

  static const route = '/article';
  static const icon = Icons.article;
  static const name = 'Article';
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
        floating: false,
        padding: MediaQuery.of(context).viewPadding,
        heights: const [kToolbarHeight, 50],
        overlapsBackgroundColor: Theme.of(context).primaryColor,
        overlapsBorderColor: Theme.of(context).shadowColor,
        builder: bar,
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          <Widget>[
            const Text(
              'Article page',
              textAlign: TextAlign.center,
            )
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
          childCount: 1000, // 1000 list items
        ),
      ),
    ];
  }
}
