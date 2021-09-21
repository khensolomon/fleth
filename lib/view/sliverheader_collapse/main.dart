
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
// import 'package:fleth/icon.dart';
// import 'package:fleth/type.dart';

part 'bar.dart';

class Main extends StatefulWidget {

  const Main({Key? key, this.settingsController, this.navigatorKey}) : super(key: key);
  final SettingsController? settingsController;
  final GlobalKey<NavigatorState>? navigatorKey;

  static const routeName = '/sliverheader_collapse';
  static final uniqueKey = UniqueKey();
  // static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<StatefulWidget> createState() => _View();
}

abstract class _State extends State<Main> with SingleTickerProviderStateMixin {
  final scrollController = ScrollController();

  late Core core;

  late List<String> themeName;

  @override
  void initState() {
    super.initState();
    core = context.read<Core>();
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
    return ViewPage(
      key: widget.key,
      // controller: scrollController,
      child: body()
    );
  }

  CustomScrollView body(){
    return  CustomScrollView(
      primary: true,
      // controller: scrollController,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: <Widget>[
        bar(),
        SliverList(
          delegate: SliverChildListDelegate(
             <Widget>[
                CupertinoButton(
                  child: const Chip(
                    avatar: Icon(Icons.assignment_turned_in),
                    labelPadding: EdgeInsets.zero,
                    label: Text('doConfirmWithDialog'),
                  ),
                  onPressed: () {
                    doConfirmWithDialog(
                      context: context,
                      message: 'Do you really want to delete all?'
                    ).then(
                      (bool? confirmation) {
                        // if (confirmation != null && confirmation) onClearAll();
                        debugPrint('response $confirmation');
                      }
                    );
                  },
                )
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
