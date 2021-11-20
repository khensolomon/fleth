import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lidea/provider.dart';
import 'package:lidea/connectivity.dart';
import 'package:lidea/view.dart';
import 'package:lidea/keepAlive.dart';
// import 'package:lidea/icon.dart';

import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';
// import 'package:fleth/type.dart';

import 'package:fleth/view/home/main.dart' as home;
import 'package:fleth/view/user/main.dart' as user;
import 'package:fleth/view/search/main.dart' as search;
import 'package:fleth/view/read/main.dart' as read;
import 'package:fleth/view/setting/main.dart' as setting;
// import 'package:fleth/view/more/main.dart' as note;
// import 'package:fleth/view/more/main.dart' as more;

part 'app.view.dart';
part 'app.launcher.dart';
part 'app.other.dart';

class AppMain extends StatefulWidget {
  const AppMain({Key? key, this.settings}) : super(key: key);
  final SettingsController? settings;

  static const routeName = '/';

  @override
  _State createState() => AppView();
}

abstract class _State extends State<AppMain> with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pageController = PageController(keepPage: true);
  final _controller = ScrollController();

  late List<Widget> _pageView;

  // late Core core;
  late StreamSubscription<ConnectivityResult> _connection;

  // late final Core core = Provider.of<Core>(context, listen: false);
  late final Core core = context.read<Core>();
  late final NavigatorNotify _navigatorNotify = context.read<NavigatorNotify>();
  // late final AppLocalizations translate = AppLocalizations.of(context)!;
  AppLocalizations get translate => AppLocalizations.of(context)!;

  late final Future<void> initiator = core.init();
  // late final initiator = Future.delayed(const Duration(milliseconds: 300));
  late final GlobalKey<NavigatorState> _tmp123 = home.Main.navigatorKey;

  List<ViewNavigationModel> get _pageButton => [
        ViewNavigationModel(
          key: 0,
          icon: home.Main.icon,
          name: home.Main.name,
          description: translate.home,
        ),
        const ViewNavigationModel(
          key: 1,
          icon: user.Main.icon,
          name: user.Main.name,
          description: "User",
        ),
        ViewNavigationModel(
          key: 2,
          icon: search.Main.icon,
          name: search.Main.name,
          description: translate.search,
        ),
        const ViewNavigationModel(
          key: 3,
          icon: read.Main.icon,
          name: read.Main.name,
          description: 'read',
        ),
        ViewNavigationModel(
          key: 4,
          icon: setting.Main.icon,
          name: setting.Main.name,
          description: translate.settings,
        ),
      ];

  @override
  void initState() {
    super.initState();
    core.navigate = navigate;

    _connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      // ConnectivityResult.mobile
      // ConnectivityResult.wifi
      // ConnectivityResult.none
    });

    _pageView = [
      WidgetKeepAlive(
        key: home.Main.uniqueKey,
        child: home.Main(settings: widget.settings),
      ),
      WidgetKeepAlive(
        key: user.Main.uniqueKey,
        child: const user.Main(),
      ),
      WidgetKeepAlive(
        key: search.Main.uniqueKey,
        child: const search.Main(
          defaultRouteName: '/result',
        ),
      ),
      WidgetKeepAlive(
        key: read.Main.uniqueKey,
        child: const read.Main(),
      ),
      WidgetKeepAlive(
        key: setting.Main.uniqueKey,
        child: const setting.Main(),
      ),
    ];
  }

  @override
  void dispose() {
    // core.store?.subscription?.cancel();
    _controller.dispose();
    super.dispose();
    _connection.cancel();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void Function()? _navButtonAction(ViewNavigationModel item, bool disable) {
    if (disable) {
      return null;
    } else if (item.action == null) {
      return () => _navPageViewAction(item.key);
    } else {
      return item.action;
    }
  }

  void _navPageViewAction(int index) {
    _navigatorNotify.index = index;
    ViewNavigationModel page = _pageButton.firstWhere(
      (e) => e.key == index,
      orElse: () => _pageButton.first,
    );
    core.analyticsScreen('${page.name}', '${page.name}State');
    // NOTE: check State isMounted
    // if(page.key.currentState != null){
    //   page.key.currentState.setState(() {});
    // }
    pageController.jumpToPage(index);
    // pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeOutQuart);
    // pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  void navigate({int at = 0, String? to, Object? args, bool routePush = true}) {
    _navigatorNotify.index = at;
    final state = _tmp123.currentState;
    if (at == 0 && to != null && state != null) {
      final canPop = state.canPop();
      // final canPop = Navigator.canPop(context);
      final arguments = ViewNavigationArguments(
        canPop: canPop,
        args: args,
        navigator: _tmp123,
      );
      if (routePush) {
        state.pushNamed(to, arguments: arguments);
        // Navigator.of(context).pushNamed(to, arguments: arguments);
      } else {
        state.pushReplacementNamed(to, arguments: arguments);
        // Navigator.of(context).pushReplacementNamed(to, arguments: arguments);
      }
    }
  }
}
