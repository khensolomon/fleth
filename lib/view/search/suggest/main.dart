import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/services.dart';

// import 'package:lidea/hive.dart';
import 'package:lidea/provider.dart';
// import 'package:lidea/intl.dart';
import 'package:lidea/view.dart';
import 'package:lidea/icon.dart';

import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';
import 'package:fleth/widget.dart';
import 'package:fleth/type.dart';

part 'bar.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.settings, this.navigatorKey, this.arguments}) : super(key: key);

  final SettingsController? settings;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Object? arguments;

  static const route = '/suggest';
  static const icon = LideaIcon.search;
  static const name = 'Suggestion';
  static const description = '...';
  static final uniqueKey = UniqueKey();
  // static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<StatefulWidget> createState() => _View();
}

/*
on initState(searchQuery)
  get -> core.collection.searchQuery
onSearch
  set -> core.collection.searchQuery from core.searchQuery
onCancel
  restore -> core.searchQuery from core.collection.searchQuery
  update -> textController.text
*/
abstract class _State extends State<Main> with TickerProviderStateMixin {
  late Core core;

  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ViewNavigationArguments get arguments => widget.arguments as ViewNavigationArguments;
  GlobalKey<NavigatorState> get navigator => arguments.navigator;
  ViewNavigationArguments get parent => arguments.args as ViewNavigationArguments;
  bool get canPop => arguments.args != null;

  late final AnimationController clearController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  ); //..repeat();
  late final Animation<double> clearAnimation = CurvedAnimation(
    parent: clearController,
    curve: Curves.fastOutSlowIn,
  );
  // late final Animation<double> clearAnimation = Tween(
  //   begin: 0.0,
  //   end: 1.0,
  // ).animate(clearController);
  // late final Animation clearAnimations = ColorTween(
  //   begin: Colors.red, end: Colors.green
  // ).animate(clearController);

  AppLocalizations get translate => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    core = context.read<Core>();

    Future.microtask(() {
      // searchQueryCurrent = searchQueryPrevious;
      // textController.text = searchQueryPrevious;
      textController.text = searchQueryCurrent;
    });

    focusNode.addListener(() {
      core.nodeFocus = focusNode.hasFocus;
    });

    scrollController.addListener(() {
      if (focusNode.hasFocus) {
        focusNode.unfocus();
        Future.microtask(() {
          clearToggle(false);
        });
      }
    });

    // FocusScope.of(context).requestFocus(FocusNode());
    // FocusScope.of(context).unfocus();

    textController.addListener(() {
      clearToggle(textController.text.isNotEmpty);
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    clearController.dispose();
    super.dispose();
    scrollController.dispose();
    textController.dispose();
    focusNode.dispose();
  }

  String get searchQueryPrevious => core.collection.searchQuery;
  set searchQueryPrevious(String str) {
    core.collection.searchQuery = str;
  }

  String get searchQueryCurrent => core.searchQuery;
  set searchQueryCurrent(String str) {
    core.searchQuery = str.replaceAll(RegExp(' +'), ' ').trim();
  }

  void onClear() {
    textController.clear();
    searchQueryCurrent = '';
  }

  void clearToggle(bool show) {
    if (show) {
      clearController.forward();
    } else {
      clearController.reverse();
    }
  }

  void onCancel() {
    focusNode.unfocus();
    Future.delayed(Duration(milliseconds: focusNode.hasPrimaryFocus ? 200 : 0), () {
      Navigator.of(context).pop(false);
      searchQueryCurrent = searchQueryPrevious;
      textController.text = searchQueryCurrent;
    });
  }

  void onSuggest(String str) {
    searchQueryCurrent = str;
    Future.microtask(() {
      core.suggestionGenerate();
    });
  }

  // NOTE: used in bar, suggest & result
  void onSearch(String str) {
    searchQueryCurrent = str;
    searchQueryPrevious = searchQueryCurrent;

    core.conclusionGenerate().whenComplete(() => Navigator.of(context).pop(true));
    // Future.delayed(Duration(milliseconds: focusNode.hasPrimaryFocus ? 200 : 0), () {
    //   Navigator.of(context).pop(true);
    // });

    // debugPrint('suggest onSearch $canPop');
    // scrollController.animateTo(
    //   scrollController.position.minScrollExtent,
    //   curve: Curves.fastOutSlowIn, duration: const Duration(milliseconds: 800)
    // );
    // Future.delayed(Duration.zero, () {
    //   core.collection.historyUpdate(searchQuery);
    // });
  }
}

class _View extends _State with _Bar {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: widget.key,
      body: ViewPage(
        controller: scrollController,
        child: body(),
      ),
    );
  }

  CustomScrollView body() {
    return CustomScrollView(
      // primary: true,
      controller: scrollController,
      slivers: <Widget>[
        // bar(),
        Selector<Core, bool>(
          selector: (BuildContext _, Core e) => e.nodeFocus,
          builder: (BuildContext _, bool word, Widget? child) {
            return bar();
          },
        ),

        Selector<Core, SuggestionType>(
          selector: (_, e) => e.collection.cacheSuggestion,
          builder: (BuildContext context, SuggestionType o, Widget? child) {
            if (o.query.isEmpty) {
              return _noQuery();
            } else if (o.raw.isNotEmpty) {
              return _listView(o);
            } else {
              return _noMatch();
            }
          },
        )
      ],
    );
  }

  Widget _noQuery() {
    return const SliverToBoxAdapter(
      child: Text('suggest: no query'),
    );
  }

  Widget _noMatch() {
    return const SliverToBoxAdapter(
      child: Text('suggest: not found'),
    );
  }

  // listView
  Widget _listView(SuggestionType o) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final snap = o.raw.elementAt(index);
            String word = snap.values.first.toString();
            int hightlight =
                searchQueryCurrent.length < word.length ? searchQueryCurrent.length : word.length;
            return _listItem(word, hightlight);
          },
          childCount: o.raw.length,
        ),
      ),
    );
  }

  Widget _listItem(String word, int hightlight) {
    return ListTile(
      title: RichText(
        // strutStyle: StrutStyle(height: 1.0),
        text: TextSpan(
          text: word.substring(0, hightlight),
          semanticsLabel: word,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).textTheme.caption!.color,
            // fontWeight: FontWeight.w500
          ),
          children: <TextSpan>[
            TextSpan(
              text: word.substring(hightlight),
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.button!.color,
                // fontWeight: FontWeight.w300
              ),
            ),
          ],
        ),
      ),
      minLeadingWidth: 10,
      leading: const Icon(CupertinoIcons.arrow_turn_down_right, semanticLabel: 'Suggestion'),
      onTap: () => true,
    );
  }
}
