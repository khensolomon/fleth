import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lidea/provider.dart';
import 'package:lidea/connectivity.dart';
import 'package:lidea/view.dart';
import 'package:lidea/keepAlive.dart';

import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';
import 'package:fleth/icon.dart';
import 'package:fleth/type.dart';

import 'package:fleth/view/home/main.dart' as home;
import 'package:fleth/view/sliverheader_shrink/main.dart' as shrink;
import 'package:fleth/view/sliverheader_collapse/main.dart' as collapse;
import 'package:fleth/view/sliverheader_search/main.dart' as search;
import 'package:fleth/view/more/main.dart' as setting;
import 'package:fleth/view/more/main.dart' as note;
import 'package:fleth/view/more/main.dart' as more;

part 'app.view.dart';
part 'app.launcher.dart';
part 'app.other.dart';

class AppMain extends StatefulWidget {
  const AppMain({Key? key, this.settingsController}) : super(key: key);
  final SettingsController? settingsController;

  static const routeName = '/';

  @override
  _State createState() => AppView();
}

abstract class _State extends State<AppMain> with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pageController = PageController(keepPage: true);
  final _controller = ScrollController();
  final viewNotifyNavigation = NotifyNavigationButton.navigation;
  final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();


  late List<Widget> _pageView;
  late List<ViewNavigationModel> _pageButton;

  late Core core;
  late Future<void> initiator;
  late StreamSubscription<ConnectivityResult> connection;

  @override
  void initState() {

    super.initState();
    // Provider.of<Core>(context, listen: false);
    core = context.read<Core>();
    core.navigate = navigate;
    // homeNavigatorKey = home.Main.navigatorKey;
    // core.navigation = homeNavigatorKey;
    initiator = core.init();
    // initiator = Future.delayed(const Duration(seconds: 1));
    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      // ConnectivityResult.mobile
      // ConnectivityResult.wifi
      // ConnectivityResult.none
    });
    _pageButton =[
      ViewNavigationModel(icon:ZaideihIcon.home, name:"Home", description: "Home", key: 0),

      ViewNavigationModel(icon:Icons.all_out, name:"Sliver header shrink", description: "Sliver header shrink", key: 1),
      ViewNavigationModel(icon:Icons.subtitles_off, name:"Sliver header collapse", description: "Sliver header collapse", key: 2),

      ViewNavigationModel(icon:ZaideihIcon.search, name:"Search", description: "Search dictionary", key: 3),
      ViewNavigationModel(icon:Icons.settings, name:"Settings", description: "Setting", key: 4),
      // ViewNavigationModel(icon:ZaideihIcon.dotHoriz, name:"More", description: "More information", key: 5),
      // ViewNavigationModel(icon:ZaideihIcon.note, name:"Note", description: "Note", key: 6),
    ];
    _pageView = [
      WidgetKeepAlive(key:home.Main.uniqueKey, child: home.Main(settingsController: widget.settingsController, navigatorKey: homeNavigatorKey,)),

      WidgetKeepAlive(key:shrink.Main.uniqueKey, child: const shrink.Main()),
      WidgetKeepAlive(key:collapse.Main.uniqueKey, child: const collapse.Main()),

      WidgetKeepAlive(key:search.Main.uniqueKey, child: const search.Main()),
      WidgetKeepAlive(key:setting.Main.uniqueKey, child: const setting.Main()),
      WidgetKeepAlive(key:more.Main.uniqueKey, child: const more.Main()),
      WidgetKeepAlive(key:note.Main.uniqueKey, child: const note.Main()),
    ];

    viewNotifyNavigation.addListener((){
      int index = viewNotifyNavigation.value;
      // navigator.currentState.pushReplacementNamed(index.toString());
      debugPrint('page.addListener $index');

      ViewNavigationModel page = _pageButton.firstWhere((e) => e.key == index, orElse: () => _pageButton.first);
      core.analyticsScreen(page.name,'${page.name}State');
      // NOTE: check State isMounted
      // if(page.key.currentState != null){
      //   page.key.currentState.setState(() {});
      // }
      pageController.jumpToPage(index);

      // pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeOutQuart);
      // pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
      // navigator.currentState.pushNamed(index.toString());
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => Note(),
      // ));
      // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => Bible(), maintainState: false));
      // Navigator.of(context, rootNavigator: false).pushNamed(index.toString());
      // Navigator.of(context, rootNavigator: false).pushReplacementNamed(index.toString());
    });
  }

  @override
  void dispose() {
    // core.store?.subscription?.cancel();
    _controller.dispose();
    viewNotifyNavigation.dispose();
    super.dispose();
    connection.cancel();
  }

  @override
  void setState(fn) {
    if(mounted) super.setState(fn);
  }

  void _navView(int index){
    // _controller.master.bottom.pageChange(index);
    viewNotifyNavigation.value = index;
  }

  void navigate({int at=0, String? to, Object? args, bool routePush=false}){
    NotifyNavigationButton.navigation.value = at;
    if (at == 0 && to != null && homeNavigatorKey.currentState != null) {
      final canPop = homeNavigatorKey.currentState!.canPop();
      // final canPop = Navigator.canPop(context);

      final arguments = NavigatorArguments(canPop:canPop, meta: args);
      if (routePush){
        homeNavigatorKey.currentState!.pushReplacementNamed(to, arguments: arguments);
        // homeNavigatorKey.currentState!.pushReplacementNamed(to, arguments: args);
        // Navigator.of(context).pushReplacementNamed(to, arguments: arguments);
      } else {
        // Navigate to the settings page. If the user leaves and returns
        // to the app after it has been killed while running in the
        // background, the navigation stack is restored.

        // homeNavigatorKey.currentState!.restorablePushNamed(to, arguments: arguments);
        // Navigator.restorablePushNamed(context, to, arguments: arguments);
        homeNavigatorKey.currentState!.pushNamed(to, arguments: arguments);
        // Navigator.of(context).pushNamed(to, arguments: arguments);
      }
      debugPrint('canPop $canPop');
      // debugPrint('is mounted: ${homeNavigatorKey.currentState!.mounted}');
      // debugPrint('??? at: $at to: $to routePush: $routePush canPop: $canPop args: $args');
    }
    // pushReplacementNamed will execute the enter animation and popAndPushNamed will execute the exit animation.
    // Navigator.of(context).pushReplacementNamed('/screen4');
    // Navigator.popAndPushNamed(context, '/screen4')

    // Navigator.pushNamed(context, '/album')
    // widget.home.currentState!.pushNamed('/artist');
    // widget.home.currentState!.popAndPushNamed('/artist');
    // widget.home.currentState!.pushReplacementNamed('/artist');
    // widget.home.currentState!.pushNamedAndRemoveUntil('/artist', (route) => false);
    // final abc = ModalRoute.of(context)!.settings.name;

  }

  int history = 0;

  void Function()? onPreviousHistory(){
    // _controller.master.bottom.pageChange(index);
    debugPrint('onPreviousHistory');

    // final items = core.collection.boxOfHistory;
    // var abc = items.valuesBetween(startKey:1, endKey: 10);
    // debugPrint(abc.map((e) => e.word));
    //   final items = core.collection.boxOfHistory.toMap().values.toList();
    //   items.sort((a, b) => b.date!.compareTo(a.date!));

    // if (items.length > history) {
    //   return (){
    //     // debugPrint(items.first.word);
    //     debugPrint(items.map((e) => e.word));
    //     onSearch(items.elementAt(1).word);
    //   };
    // }

    return null;
  }

  void Function()? onNextHistory(){
    // _controller.master.bottom.pageChange(index);
    debugPrint('onNextHistory');
    return null;
  }

  // void onSearch(String word){
  //   NotifyNavigationButton.navigation.value = 0;
  //   core.collection.searchQuery = word;
  //   Future.delayed(const Duration(milliseconds: 200), () {
  //     core.definitionGenerate();
  //   });
  //   Future.delayed(Duration.zero, () {
  //     core.collection.historyUpdate(word);
  //   });
  // }

  // void _pageChanged(int index){
  //   // _controller.master.bottom.pageChange(index);
  //   viewNotifyNavigation.value = index;
  // }
}

// class _AppMainState extends State<AppMain> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }