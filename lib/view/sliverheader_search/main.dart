import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/services.dart';

// import 'package:lidea/hive.dart';;
import 'package:lidea/provider.dart';
// import 'package:lidea/intl.dart';
import 'package:lidea/view.dart';

import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';
// import 'package:fleth/widget.dart';
import 'package:fleth/icon.dart';
// import 'package:fleth/type.dart';

part 'bar.dart';
part 'result.dart';
part 'suggest.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.settings, this.navigatorKey, this.arguments}) : super(key: key);

  final SettingsController? settings;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Object? arguments;

  static const route = '/sliverheader_search';
  static const icon = Icons.ac_unit;
  static const name = 'search';
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
abstract class _State extends State<Main> with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  late final Core core;

  // late NotifyViewScroll scroll;
  late final AnimationController animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  ); //..repeat();
  late final Animation<double> cancelButtonAnimation = CurvedAnimation(
    parent: animationController,
    curve: Curves.fastOutSlowIn,
  );

  bool searchActive = true;

  AppLocalizations get translate => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    core = context.read<Core>();

    Future.microtask(() {
      textController.text = searchQueryPrevious;
      searchQueryCurrent = searchQueryPrevious;
    });

    focusNode.addListener(() {
      // if(focusNode.hasFocus) {
      //   textController.selection = TextSelection(baseOffset: 0, extentOffset: textController.value.text.length);
      // }
      core.nodeFocus = focusNode.hasFocus;
      // setState(() {});
      if (focusNode.hasFocus) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    });

    scrollController.addListener(() {
      if (focusNode.hasFocus) {
        focusNode.unfocus();
      }
    });

    // cancelButtonAnimation.addStatusListener((AnimationStatus status) {
    //   if (status == AnimationStatus.completed) {
    //     animationController.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     animationController.forward();
    //   }
    // });
    // animationController.forward();

    // FocusScope.of(context).requestFocus(FocusNode());
    // FocusScope.of(context).unfocus();

    // textController.addListener(() {
    //   searchPreviousQuery = textController.text.replaceAll(RegExp(' +'), ' ').trim();
    // });

    // Future.delayed(const Duration(milliseconds: 400), (){
    //   focusNode.requestFocus();
    // });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    textController.dispose();
    focusNode.dispose();
    animationController.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
    debugPrint('setState');
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

  void onCancel() {
    searchQueryCurrent = searchQueryPrevious;
    textController.text = searchQueryCurrent;
    // searchActive = false;
    focusNode.unfocus();
    // Future.delayed(Duration(milliseconds: searchActive?200:0), (){
    //   if (searchActive){
    //     setState(() {
    //       searchActive = false;
    //     });
    //   }
    // });
  }

  void onSuggest(String str) {
    searchQueryCurrent = str;
    if (searchActive == false) {
      setState(() {
        searchActive = true;
      });
    }
  }

  // NOTE: used in bar, suggest & result
  void onSearch(String str) {
    searchQueryCurrent = str;
    searchQueryPrevious = searchQueryCurrent;

    if (searchActive) {
      setState(() {
        searchActive = false;
      });
    }
  }
}

class _View extends _State with _Bar, _Suggest, _Result {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      body: ViewPage(
          // controller: scrollController,
          child: body()),
    );
  }

  CustomScrollView body() {
    return CustomScrollView(
        // primary: true,
        controller: scrollController,
        slivers: <Widget>[
          bar(),
          // searchActive?tmp('suggest'):tmp('result')
          SliverToBoxAdapter(
            child: searchActive ? suggest() : result(),
          )
          // SliverToBoxAdapter(
          //   child: suggest(),
          // )

          // SliverToBoxAdapter(
          //   child: AnimatedSwitcher(
          //     duration: const Duration(milliseconds: 300),
          //     transitionBuilder: (Widget child, Animation<double> animation) {
          //       return SlideTransition(
          //         position: Tween(
          //           begin: const Offset(1.0, 1.0),
          //           end: const Offset(0.0, 0.0),
          //         ).animate(animation),
          //         child: child,
          //       );
          //     },
          //     child: searchActive?suggest():result(),
          //   )
          // )
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 20),
          //     child: AnimatedCrossFade(
          //       duration: const Duration(milliseconds: 300),
          //       firstChild: suggest(),
          //       secondChild: result(),
          //       crossFadeState: searchActive ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          //       // layoutBuilder: (Widget topChild, Key topChildKey, Widget bottomChild, Key bottomChildKey) {
          //       //   return Stack(
          //       //     clipBehavior: Clip.none,
          //       //     children: <Widget>[
          //       //       Positioned(
          //       //         key: bottomChildKey,
          //       //         left: 100.0,
          //       //         top: 100.0,
          //       //         child: bottomChild,
          //       //       ),
          //       //       Positioned(
          //       //         key: topChildKey,
          //       //         child: topChild,
          //       //       ),
          //       //     ],
          //       //   );
          //       // },
          //     ),
          //   )
          // )
          // AnimatedCrossFade(
          //   duration: const Duration(milliseconds: 300),
          //   firstChild: tmp('suggest'),
          //   secondChild: tmp('result'),
          //   crossFadeState: searchActive ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          // )

          // SliverFadeTransition(
          //   opacity: animationController,
          //   sliver: SliverFixedExtentList(
          //     itemExtent: 100.0,
          //     delegate: SliverChildBuilderDelegate(
          //       (BuildContext context, int index) {
          //         return Container(
          //           color: index.isEven
          //             ? Colors.indigo[200]
          //             : Colors.orange[200],
          //         );
          //       },
          //       childCount: 5,
          //     ),
          //   ),
          // )
        ]);
  }

  // Widget tmp(String message) {
  //   // if (artist.length == 0) return const SliverSnapshotEmpty();
  //   return SliverPadding(
  //     key: widget.key,
  //     padding: const EdgeInsets.symmetric(vertical: 10),
  //     sliver: SliverList(
  //       delegate: SliverChildBuilderDelegate(
  //         // (BuildContext context, int index) => ArtistListItem(core: core, artist: artist.elementAt(index), index: index,),
  //         (BuildContext context, int index) {
  //           // final delayedMilliseconds = 320 * (index % 25 + 1);
  //         const delayedMilliseconds = 320;
  //           return FutureBuilder<bool>(
  //             // future: Future.microtask(() => true),
  //             future: Future.delayed(const Duration(milliseconds: delayedMilliseconds), ()=>true),
  //             builder: (_, snap){
  //               if (snap.hasData == false) return const SizedBox(height: 50,);
  //               // return ArtistListItem(core: core, artist: artist.elementAt(index));
  //               return ListTile(
  //                 title: Text('$message index: $index delayedMilliseconds: $delayedMilliseconds'),
  //               );
  //               // return const ArtistListItemHolder();
  //             }
  //           );
  //         },
  //         childCount: 30
  //       )
  //     )
  //   );
  // }
}
