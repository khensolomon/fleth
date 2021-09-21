
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/services.dart';

// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive/hive.dart';

import 'package:lidea/provider.dart';
// import 'package:lidea/intl.dart';
import 'package:lidea/view.dart';

import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';
import 'package:fleth/widget.dart';
import 'package:fleth/icon.dart';
// import 'package:fleth/type.dart';

part 'bar.dart';
part 'result.dart';
part 'suggest.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.settingsController, this.navigatorKey, this.arguments}) : super(key: key);

  final SettingsController? settingsController;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Object? arguments;

  static const routeName = '/search';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late Core core;
  late AppLocalizations translationInstance;
  // localeInstance translationInstance
  // late NotifyViewScroll scroll;

  bool searchActive = true;

  @override
  void initState() {
    super.initState();
    core = context.read<Core>();
    translationInstance = context.read<SettingsController>().translate;
    // final translationInstance = SettingsController.instance;
    // scroll = context.read<NotifyViewScroll>();

    Future.microtask(() {
      textController.text = searchQueryPrevious;
      searchQueryCurrent = searchQueryPrevious;
    });

    focusNode.addListener(() {
      // if(focusNode.hasFocus) {
      //   textController.selection = TextSelection(baseOffset: 0, extentOffset: textController.value.text.length);
      // }
      core.nodeFocus = focusNode.hasFocus;
      setState(() {});
    });

    scrollController.addListener(() {
      if (focusNode.hasFocus){
        focusNode.unfocus();
      }
    });

    // FocusScope.of(context).requestFocus(FocusNode());
    // FocusScope.of(context).unfocus();

    // textController.addListener(() {
    //   searchPreviousQuery = textController.text.replaceAll(RegExp(' +'), ' ').trim();
    // });

    Future.delayed(const Duration(milliseconds: 400), (){
      focusNode.requestFocus();
    });
  }

  @override
  dispose() {
    super.dispose();
    scrollController.dispose();
    textController.dispose();
    focusNode.dispose();
  }

  @override
  void setState(fn) {
    if(mounted) super.setState(fn);
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
    // searchQueryCurrent = searchQueryPrevious;
    // textController.text = searchQueryCurrent;

    focusNode.unfocus();
    Future.delayed(Duration(milliseconds: focusNode.hasPrimaryFocus?200:0), (){
      Navigator.of(context).pop();
    });
  }


  void onSuggest(String str) {
    searchQueryCurrent = str;
    if (searchActive == false){
      setState(() {
        searchActive = true;
      });
    }
  }

  // NOTE: used in bar, suggest & result
  void onSearch(String str) {
    searchQueryCurrent = str;
    searchQueryPrevious = searchQueryCurrent;

    if (searchActive){
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
        controller: scrollController,
        child: body()
      ),
    );
  }

  CustomScrollView body(){
    return  CustomScrollView(
      // primary: true,
      controller: scrollController,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: <Widget>[
        bar(),
        searchActive?suggest():result()
      ]
    );
  }
}
