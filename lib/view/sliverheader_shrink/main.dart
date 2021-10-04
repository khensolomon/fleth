import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/services.dart';

// import 'package:lidea/hive.dart';
import 'package:lidea/provider.dart';
// import 'package:lidea/intl.dart';
import 'package:lidea/view.dart';
// import 'package:lidea/icon.dart';

import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';
// import 'package:fleth/widget.dart';
// import 'package:fleth/type.dart';

part 'bar.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.settings, this.navigatorKey}) : super(key: key);
  final SettingsController? settings;
  final GlobalKey<NavigatorState>? navigatorKey;

  static const route = '/sliverheader_shrink';
  static const icon = Icons.ac_unit;
  static const name = 'shrink';
  static const description = '...';
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
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void onClearAll() {
    Future.microtask(() {});
  }

  void onSearch(String word) {}

  void onDelete(String word) {
    Future.delayed(Duration.zero, () {});
  }
}

class _View extends _State with _Bar {
  @override
  Widget build(BuildContext context) {
    return ViewPage(key: widget.key, controller: scrollController, child: body());
  }

  CustomScrollView body() {
    return CustomScrollView(
        // primary: true,
        controller: scrollController,
        slivers: <Widget>[
          bar(),
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
        ]);
  }
}
