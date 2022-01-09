import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';

import 'package:lidea/provider.dart';
import 'package:lidea/view/main.dart';
import 'package:lidea/icon.dart';
// import 'package:lidea/hive.dart';

import '/core/main.dart';
import '/type/main.dart';
import '/widget/main.dart';

part 'bar.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.arguments}) : super(key: key);

  final Object? arguments;

  static const route = '/search-result';
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
  late final TextEditingController textController = TextEditingController();
  late final Future<void> initiator = core.conclusionGenerate(init: true);

  ViewNavigationArguments get arguments => widget.arguments as ViewNavigationArguments;
  GlobalKey<NavigatorState> get navigator => arguments.navigator!;
  ViewNavigationArguments get parent => arguments.args as ViewNavigationArguments;
  bool get canPop => arguments.args != null;
  // bool get canPop => arguments.canPop;
  // bool get canPop => navigator.currentState!.canPop();
  // bool get canPop => Navigator.of(context).canPop();

  // AppLocalizations get translate => AppLocalizations.of(context)!;
  Preference get preference => core.preference;

  @override
  void initState() {
    super.initState();
    core = context.read<Core>();
    onQuery();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    textController.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void onUpdate(bool status) {
    if (status) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (scrollController.hasClients && scrollController.position.hasContentDimensions) {
          scrollController.animateTo(
            scrollController.position.minScrollExtent,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 500),
          );
        }
      });
      onQuery();
    }
  }

  void onQuery() async {
    Future.microtask(() {
      textController.text = core.searchQuery;
    });
  }

  void onSearch(String ord) async {
    core.searchQuery = ord;
    core.suggestQuery = ord;
    await core.conclusionGenerate();
    onQuery();
    onUpdate(core.searchQuery.isNotEmpty);
  }

  void onSwitchFavorite() {
    core.collection.favoriteSwitch(core.searchQuery);
    core.notify();
  }
}

class _View extends _State with _Bar {
  @override
  Widget build(BuildContext context) {
    return ViewPage(
      // controller: scrollController,
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
      ],
    );
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
      leading: const Icon(CupertinoIcons.arrow_turn_down_right, semanticLabel: 'Conclusion'),
      onTap: () => true,
    );
  }
}
