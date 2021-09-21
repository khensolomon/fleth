
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
import 'package:fleth/type.dart';
// import 'package:fleth/icon.dart';

part 'bar.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.settingsController, this.navigatorKey, this.arguments}) : super(key: key);

  final SettingsController? settingsController;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Object? arguments;

  static const routeName = '/blog';
  static final uniqueKey = UniqueKey();
  // static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<StatefulWidget> createState() => _View();
}

abstract class _State extends State<Main> with SingleTickerProviderStateMixin {
  final scrollController = ScrollController();

  late Core core;
  late AppLocalizations translationInstance;

  NavigatorArguments get arguments => widget.arguments as NavigatorArguments;
  // AudioAlbumType get album => arguments.meta as AudioAlbumType;

  @override
  void initState() {
    super.initState();
    core = context.read<Core>();
    translationInstance = context.read<SettingsController>().translate;
  }

  @override
  dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if(mounted) super.setState(fn);
  }

  void onClearAll(){
    Future.microtask((){});
  }

  void onSearch(String word){
  }

  void onDelete(String word){
    Future.delayed(Duration.zero, () {});
  }

}

class _View extends _State with _Bar{

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

        SliverList(
          delegate: SliverChildListDelegate(
             <Widget>[
               CupertinoButton(
                  child: const Chip(
                    avatar: Icon(CupertinoIcons.back),
                    labelPadding: EdgeInsets.zero,
                    label: Text('Back'),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
               CupertinoButton(
                 child: const Chip(
                   label: Text('Continue to article'),
                  ),
                  onPressed: () => core.navigate(to: '/article')
                ),
               CupertinoButton(
                 child: const Chip(
                   label: Text('Navigate to search'),
                  ),
                  onPressed: () => core.navigate(to: '/search', routePush: true)
                ),
             ]
          )
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
      ]
    );
  }
}
