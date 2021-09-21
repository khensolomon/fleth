
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
import 'package:fleth/type.dart';

part 'bar.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.settingsController, this.navigatorKey, this.arguments}) : super(key: key);

  final SettingsController? settingsController;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Object? arguments;

  static const routeName = '/article';
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
                TextButton.icon(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    // splashFactory: NoSplash.splashFactory,
                    // textStyle: TextStyle(color: Colors.blue),
                    // backgroundColor: Colors.white,
                    // shape:RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(24.0),
                    // ),
                  ),
                  onPressed: () => {},
                  icon: const Icon(Icons.send_rounded,),
                  label: const Text('စမ်းသပ်မှု',),
                ),
                TextButton(
                  style: ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: MaterialStateColor.resolveWith(
                      (states) => const Color(0xfffbba3d).withOpacity(0.3)
                    )
                  ),
                  onPressed: () => {},
                  child: const Text('My Button')
                ),
                const Chip(
                  avatar: Icon(Icons.style_sharp),
                  label: Text('Chip', strutStyle: StrutStyle(),),
                ),
                const Chip(
                  avatar: Icon(Icons.style_sharp),
                  label: Text('စမ်းသပ်မှု', strutStyle: StrutStyle(),),
                ),
                CupertinoButton(
                  child: const Chip(
                    avatar: Icon(CupertinoIcons.back),
                    labelPadding: EdgeInsets.zero,
                    label: Text('Back', strutStyle: StrutStyle(),),
                  ),
                  onPressed: () => {},
                ),
                CupertinoButton(
                  child: const Chip(
                    avatar: Icon(CupertinoIcons.back),
                    labelPadding: EdgeInsets.zero,
                    label: Text('ပြန်', strutStyle: StrutStyle(),),
                  ),
                  onPressed: () => {},
                ),
                const Text('လူတိုင်းတွင် လွတ်လပ်စွာ တွေးခေါ် ကြံဆနိုင်ခွင့်၊ လွတ်လပ်စွာ ခံယူရပ်တည်နိုင်ခွင့် နှင့် လွတ်လပ်စွာ သက်ဝင် ကိုးကွယ်နိုင်ခွင့်ရှိသည်။ အဆိုပါ အခွင့်အရေးများ၌', textAlign: TextAlign.center),
                const Text('Material Icons are available in five styles and a range of downloadable sizes and densities. The icons are based on the core Material Design principles and metrics.', textAlign: TextAlign.center)
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
