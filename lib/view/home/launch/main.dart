
import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'package:lidea/provider.dart';
import 'package:lidea/view.dart';

import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';
import 'package:fleth/widget.dart';
import 'package:fleth/icon.dart';
// import 'package:fleth/type.dart';

part 'bar.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.arguments}) : super(key: key);

  final Object? arguments;

  static const routeName = '/launch';
  // static final uniqueKey = UniqueKey();
  // static final navigatorKey = GlobalKey<NavigatorState>();
  // static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<StatefulWidget> createState() => _View();
}

abstract class _State extends State<Main> with SingleTickerProviderStateMixin {

  late Core core;
  late AppLocalizations translationInstance;

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    core = context.read<Core>();

    translationInstance = context.read<SettingsController>().translate;
    // final translationInstance = SettingsController.instance.translate;
    // Future.microtask((){});
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
      controller: scrollController,
      child: body()
    );
  }

  CustomScrollView body(){
    return  CustomScrollView(
      // primary: true,
      controller: scrollController,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: <Widget>[
        bar(),

        SliverToBoxAdapter(
          child: SizedBox(
            height: kBottomNavigationBarHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 11),
              child: Hero(
                tag: 'searchHero',
                child: GestureDetector(
                  child: Material(
                    type: MaterialType.transparency,
                    child: MediaQuery(
                      data: MediaQuery.of(context),
                      child: TextFormField(
                        readOnly: true,
                        enabled: false,

                        decoration: InputDecoration(
                          hintText: translationInstance.aWordOrTwo,
                          // contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),

                          prefixIcon: const Icon(
                            ZaideihIcon.find,
                            size: 17
                          ),
                          fillColor: Theme.of(context).inputDecorationTheme.fillColor!.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    core.navigate(to: '/search');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Search.Main(arguments: NavigatorArguments())),
                    //   // PageRouteBuilder(pageBuilder: (_, __, ___) => Search.Main(arguments: NavigatorArguments())),
                    // );
                  }
                ),
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [

              ]
            )
          )
        ),

        SliverList(
          delegate: SliverChildListDelegate(
             <Widget>[
               CupertinoButton(
                 child: const Chip(
                   label: Text('Navigate to blog'),
                  ),
                  onPressed: () => core.navigate(to: '/blog')
                ),
               CupertinoButton(
                 child: const Chip(
                   label: Text('Navigate to article'),
                  ),
                  onPressed: () => core.navigate(to: '/article')
                ),
               CupertinoButton(
                 child: const Chip(
                   label: Text('Navigate to search'),
                  ),
                  onPressed: () => core.navigate(to: '/search')
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
