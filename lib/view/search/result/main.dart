import 'package:flutter/material.dart';

import 'package:lidea/provider.dart';
import 'package:lidea/view/main.dart';
import 'package:lidea/icon.dart';
// import 'package:lidea/hive.dart';

import '/core/main.dart';
import '/type/main.dart';
import '/widget/main.dart';

part 'bar.dart';
part 'state.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.arguments}) : super(key: key);

  final Object? arguments;

  static const route = '/search-result';
  static const icon = LideaIcon.search;
  static const name = 'Result';
  static const description = '...';

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
      SliverLayoutBuilder(
        builder: (BuildContext context, constraints) {
          return ViewHeaderSliverSnap(
            pinned: true,
            floating: false,
            padding: MediaQuery.of(context).viewPadding,
            heights: const [kToolbarHeight],
            overlapsBackgroundColor: Theme.of(context).primaryColor,
            overlapsBorderColor: Theme.of(context).shadowColor,
            overlapsForce: constraints.scrollOffset > 0,
            builder: bar,
          );
        },
      ),
      FutureBuilder(
        future: initiator,
        builder: (BuildContext _, AsyncSnapshot<void> snap) {
          switch (snap.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return _msg(preference.text.aMoment);
            default:
              return Selector<Core, ConclusionType>(
                selector: (_, e) => e.collection.cacheConclusion,
                builder: (BuildContext context, ConclusionType o, Widget? child) {
                  if (o.query.isEmpty) {
                    return _msg(preference.text.aWordOrTwo);
                  } else if (o.raw.isNotEmpty) {
                    return _resultBlock(o);
                  } else {
                    return _msg(preference.text.searchNoMatch);
                  }
                },
              );
          }
        },
      ),
      // Selector<Core, ConclusionType>(
      //   selector: (_, e) => e.collection.cacheConclusion,
      //   builder: (BuildContext context, ConclusionType o, Widget? child) {
      //     if (o.query.isEmpty) {
      //       return _msg(translate.aWordOrTwo);
      //     } else if (o.raw.isNotEmpty) {
      //       return _resultBlock(o);
      //     } else {
      //       return _msg(translate.searchNoMatch);
      //     }
      //   },
      // ),
    ];
  }

  Widget _msg(String msg) {
    return SliverFillRemaining(
      hasScrollBody: false,
      fillOverscroll: true,
      child: Center(
        child: Text(msg),
      ),
    );
  }

  Widget _resultBlock(ConclusionType o) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int i) => _resultContainer(o.raw.elementAt(i)),
        childCount: o.raw.length,
      ),
    );
  }

  Widget _resultContainer(Map<String, dynamic> item) {
    String word = item.values.first.toString();
    return ListTile(
      title: Text(word),
      minLeadingWidth: 10,
      leading: const Icon(Icons.ac_unit),
      onTap: () => true,
    );
  }
}
