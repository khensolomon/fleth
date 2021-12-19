import 'package:flutter/material.dart';
import 'package:lidea/keepAlive.dart';
import 'package:lidea/view/model.dart';

import 'package:fleth/settings.dart';

import 'app.dart' as root;

// import 'launch/main.dart' as launch;
// import 'blog/main.dart' as blog;
// import 'article/main.dart' as article;
// import '../search/main.dart' as search;
// import '../user/main.dart' as user;
// import '../read/main.dart' as read;
// import 'reorderable/main.dart' as reorderable;
// import 'dismissible/main.dart' as dismissible;
// import 'recent_search/main.dart' as recent_search;

import 'home/main.dart' as home;
import 'home/launch/main.dart' as launch;
import 'home/blog/main.dart' as blog;
import 'home/article/main.dart' as article;
import 'home/reorderable/main.dart' as reorderable;
import 'home/dismissible/main.dart' as dismissible;
import 'home/recent_search/main.dart' as recent_search;
import 'home/note/main.dart' as note;

import 'search/main.dart' as search_page;
import 'search/result/main.dart' as search_result;
import 'search/suggest/main.dart' as search_suggest;

import 'user/main.dart' as user;
import 'read/main.dart' as reader;
import 'setting/main.dart' as setting;

// import 'album/main.dart' as Album;
// import 'search/main.dart' as Search;
// import 'album-info/main.dart' as AlbumInfo;
// import 'artist/main.dart' as Artist;
// import 'artist-info/main.dart' as ArtistInfo;

class AppRoutes {
  static String rootInitial = root.Main.route;
  static Map<String, Widget Function(BuildContext)> rootMap = {
    root.Main.route: (BuildContext _) {
      return const root.Main();
    },
    // bible.Main.route: (BuildContext _) {
    //   return const bible.Main();
    // },
  };

  // static void showParallelList(BuildContext context) {
  //   // Navigator.of(context, rootNavigator: true).pushNamed(
  //   //   bible.Main.route,
  //   // );
  // }

  // static GlobalKey<NavigatorState> homeNavigator = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> homeNavigator = home.Main.navigator;

  static String homeInitial({String? name}) => name ?? home.Main.route;

  static Widget _homePage(RouteSettings route) {
    switch (route.name) {
      case search_page.Main.route:
        return search_page.Main(
          arguments: route.arguments,
          defaultRouteName: search_suggest.Main.route,
        );
      // case search_page.Main.route:
      //   return search_result.Main(arguments: route.arguments);
      // case search_suggest.Main.route:
      //   return search_suggest.Main(arguments: route.arguments);
      case search_suggest.Main.route:
        return search_page.Main(
          arguments: route.arguments,
          defaultRouteName: search_suggest.Main.route,
        );
      case search_result.Main.route:
        return search_page.Main(
          arguments: route.arguments,
          defaultRouteName: search_result.Main.route,
        );
      // case search_result.Main.route:
      //   return search_page.Main(arguments: route.arguments);

      // case search_result.Main.route:
      //   return search_result.Main(arguments: route.arguments);
      // case search_suggest.Main.route:
      //   return search_suggest.Main(arguments: route.arguments);

      case user.Main.route:
        return user.Main(arguments: route.arguments);
      case setting.Main.route:
        return setting.Main(arguments: route.arguments);
      case reader.Main.route:
        return reader.Main(arguments: route.arguments);
      case note.Main.route:
        return note.Main(arguments: route.arguments);
      case recent_search.Main.route:
        return recent_search.Main(arguments: route.arguments);

      case blog.Main.route:
        return blog.Main(arguments: route.arguments);
      case article.Main.route:
        return article.Main(arguments: route.arguments);
      case reorderable.Main.route:
        return reorderable.Main(arguments: route.arguments);
      case dismissible.Main.route:
        return dismissible.Main(arguments: route.arguments);
      case launch.Main.route:
      default:
        // throw Exception('Invalid route: ${route.name}');
        return launch.Main(arguments: route.arguments);
    }
  }

  // static Route<dynamic>? homeBuilder(RouteSettings route) {
  //   return MaterialPageRoute<void>(
  //     settings: route,
  //     fullscreenDialog: true,
  //     builder: (BuildContext context) {
  //       return _homePage(route);
  //     },
  //   );
  // }

  static Route<dynamic>? homeBuilder(RouteSettings route) {
    return PageRouteBuilder(
      settings: route,
      pageBuilder: (BuildContext _, Animation<double> _a, Animation<double> _b) {
        return _homePage(route);
      },
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, _b, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      fullscreenDialog: true,
    );
  }

  // static GlobalKey<NavigatorState> searchNavigator = search_page.Main.navigator;
  // static GlobalKey<NavigatorState> searchNavigator => GlobalKey<NavigatorState>();

  static String searchInitial({String? name}) => name ?? search_result.Main.route;

  static Route<dynamic>? searchBuilder(RouteSettings route, Object? args) {
    // final arguments = ViewNavigationArguments(
    //   navigator: searchNavigator,
    //   args: args,
    // );
    return PageRouteBuilder(
      settings: route,
      pageBuilder: (BuildContext _, Animation<double> _a, Animation<double> _b) {
        switch (route.name) {
          case search_suggest.Main.route:
            return search_suggest.Main(arguments: args);
          case search_result.Main.route:
          default:
            return search_result.Main(arguments: args);
        }
      },
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      fullscreenDialog: true,
    );
  }
}

// AppPageView AppPageNavigation
class AppPageNavigation {
  // static final controller = PageController(keepPage: true);
  static List<ViewNavigationModel> button(AppLocalizations translate) {
    return [
      ViewNavigationModel(
        key: 0,
        icon: home.Main.icon,
        name: home.Main.name,
        description: translate.home,
      ),
      ViewNavigationModel(
        key: 1,
        icon: recent_search.Main.icon,
        name: recent_search.Main.name,
        description: translate.recentSearch,
      ),
      ViewNavigationModel(
        key: 2,
        icon: note.Main.icon,
        name: note.Main.name,
        description: translate.note(false),
      ),
      ViewNavigationModel(
        key: 3,
        icon: setting.Main.icon,
        name: setting.Main.name,
        description: translate.setting(false),
      ),
    ];
  }

  static List<Widget> page = [
    WidgetKeepAlive(
      key: home.Main.uniqueKey,
      child: const home.Main(),
    ),
    WidgetKeepAlive(
      key: recent_search.Main.uniqueKey,
      child: const recent_search.Main(),
    ),
    WidgetKeepAlive(
      key: note.Main.uniqueKey,
      child: const note.Main(),
    ),
    WidgetKeepAlive(
      key: setting.Main.uniqueKey,
      child: const setting.Main(),
    ),
  ];
}
