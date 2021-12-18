import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';

import 'package:lidea/provider.dart';
import 'package:lidea/view.dart';
import 'package:lidea/icon.dart';

import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';
import 'package:fleth/widget.dart';
import 'package:fleth/type.dart';

part 'bar.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.arguments}) : super(key: key);

  final Object? arguments;

  static const route = '/result';
  static const icon = LideaIcon.search;
  static const name = 'Result';
  static const description = '...';
  // static final uniqueKey = UniqueKey();
  // static final navigatorKey = GlobalKey<NavigatorState>();
  // static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<StatefulWidget> createState() => _View();
}

abstract class _State extends State<Main> with SingleTickerProviderStateMixin {
  late Core core;

  late final scrollController = ScrollController();
  late final Future<void> initiator = core.conclusionGenerate(init: true);

  ViewNavigationArguments get arguments => widget.arguments as ViewNavigationArguments;
  GlobalKey<NavigatorState> get navigator => arguments.navigator!;
  ViewNavigationArguments get parent => arguments.args as ViewNavigationArguments;
  bool get canPop => arguments.args != null;
  // bool get canPop => arguments.canPop;
  // bool get canPop => navigator.currentState!.canPop();
  // bool get canPop => Navigator.of(context).canPop();

  AppLocalizations get translate => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    core = context.read<Core>();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void onSearch(bool status) {
    if (status) {
      // Future.microtask(() {
      //   core.conclusionGenerate().whenComplete(() {
      //     if (scrollController.hasClients && scrollController.position.hasContentDimensions) {
      //       scrollController.animateTo(
      //         scrollController.position.minScrollExtent,
      //         curve: Curves.fastOutSlowIn,
      //         duration: const Duration(milliseconds: 500),
      //       );
      //     }
      //   });
      // });
      Future.delayed(const Duration(milliseconds: 300), () {
        if (scrollController.hasClients && scrollController.position.hasContentDimensions) {
          scrollController.animateTo(
            scrollController.position.minScrollExtent,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 500),
          );
        }
      });
    }
  }
}

class _View extends _State with _Bar {
  @override
  Widget build(BuildContext context) {
    return ViewPage(
      controller: scrollController,
      child: body(),
    );
  }

  CustomScrollView body() {
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        bar(),

        FutureBuilder(
          future: initiator,
          builder: (BuildContext _, AsyncSnapshot<void> snap) {
            switch (snap.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('A moment'),
                  ),
                );
              default:
                return Selector<Core, ConclusionType>(
                  selector: (_, e) => e.collection.cacheConclusion,
                  builder: (BuildContext context, ConclusionType o, Widget? child) {
                    if (o.query.isEmpty) {
                      return _noQuery();
                    } else if (o.raw.isNotEmpty) {
                      return _listView(o);
                    } else {
                      return _noMatch();
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
        //       return _noQuery();
        //     } else if (o.raw.isNotEmpty) {
        //       return _listView(o);
        //     } else {
        //       return _noMatch();
        //     }
        //   },
        // )
      ],
    );
  }

  Widget _noQuery() {
    return const SliverToBoxAdapter(
      child: Text('result: no query'),
    );
  }

  Widget _noMatch() {
    return const SliverToBoxAdapter(
      child: Text('result: not found'),
    );
  }

  // listView
  Widget _listView(ConclusionType o) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final snap = o.raw.elementAt(index);
            return _listItem(snap);
          },
          childCount: o.raw.length,
        ),
      ),
    );
  }

  Widget _listItem(Map<String, dynamic> item) {
    String word = item.values.first.toString();
    return ListTile(
      title: Text(word),
      minLeadingWidth: 10,
      leading: const Icon(CupertinoIcons.arrow_turn_down_right, semanticLabel: 'Conclusion'),
      onTap: () => true,
    );
  }
}
