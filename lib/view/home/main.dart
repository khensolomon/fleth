import 'package:flutter/material.dart';

import 'package:lidea/provider.dart';
import 'package:lidea/icon.dart';

// import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';

// launch blog article
import 'launch/main.dart' as launch;
import 'blog/main.dart' as blog;
import 'article/main.dart' as article;
import '../search/main.dart' as search;
import '../user/main.dart' as user;
import '../reader/main.dart' as reader;
import 'reorderable/main.dart' as reorderable;
import 'dismissible/main.dart' as dismissible;
import 'recent_search/main.dart' as recent_search;
// import 'album/main.dart' as Album;
// import 'search/main.dart' as Search;
// import 'album-info/main.dart' as AlbumInfo;
// import 'artist/main.dart' as Artist;
// import 'artist-info/main.dart' as ArtistInfo;

// key: 0,
//       icon: LideaIcon.home,
//       name: "Home",
//       description: translate.home,
class Main extends StatefulWidget {
  const Main({Key? key, this.settings}) : super(key: key);

  final SettingsController? settings;
  // final GlobalKey<NavigatorState>? navigatorKey;

  static const route = '/home';
  static const icon = LideaIcon.home;
  static const name = 'Home';
  static const description = 'home';
  static final uniqueKey = UniqueKey();
  // static final scaffoldKey = GlobalKey<ScaffoldState>();
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<StatefulWidget> createState() => _State();
}

class TmpDelete extends StatelessWidget {
  const TmpDelete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('??????????????')),
    );
  }
}

class _State extends State<Main> {
  late final NavigatorNotifyObserver obs = NavigatorNotifyObserver(
    Provider.of<NavigatorNotify>(
      context,
      listen: false,
    ),
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: widget.key,
      body: HeroControllerScope(
        controller: MaterialApp.createMaterialHeroController(),
        child: Navigator(
          key: Main.navigatorKey,
          initialRoute: "/",
          restorationScopeId: 'home',
          observers: [obs],
          onGenerateRoute: (RouteSettings route) {
            // MaterialPageRoute<void>(
            //   settings: route,
            //   builder: (_){
            //     switch (route.name) {
            //       case launch.Main.routeName:
            //       default:
            //         // throw Exception('Invalid route: ${route.name}');
            //         return launch.Main(arguments: route.arguments);
            //     }
            //   }
            // );

            return PageRouteBuilder(
              settings: route,
              // BuildContext, Animation<double>, Animation<double>
              pageBuilder: (BuildContext _, Animation<double> _a, Animation<double> _b) {
                switch (route.name) {
                  case search.Main.route:
                    return search.Main(arguments: route.arguments);
                  case user.Main.route:
                    return user.Main(arguments: route.arguments);
                  case reader.Main.route:
                    return reader.Main(arguments: route.arguments);
                  case search.Main.route + '/result':
                    return search.Main(arguments: route.arguments, defaultRouteName: '/result');
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
              },
              transitionDuration: const Duration(milliseconds: 400),
              reverseTransitionDuration: const Duration(milliseconds: 400),
              transitionsBuilder: (_, animation, __, child) => FadeTransition(
                opacity: animation,
                child: child,
              ),
              // transitionsBuilder: (_, animation, __, child) => SlideTransition(
              //   position: Tween<Offset>(
              //     begin: const Offset(1.0, 0.0),
              //     end: Offset.zero,
              //   ).animate(animation),
              //   child: child,
              // ),
              // transitionsBuilder: (_, animation, __, child) => Stack(
              //   children: <Widget>[
              //     SlideTransition(
              //       position: new Tween<Offset>(
              //         begin: const Offset(0.0, 0.0),
              //         end: const Offset(-1.0, 0.0),
              //       ).animate(animation),
              //       child: child,
              //     ),
              //     SlideTransition(
              //       position: new Tween<Offset>(
              //         begin: const Offset(1.0, 0.0),
              //         end: Offset.zero,
              //       ).animate(animation),
              //       child: child,
              //     )
              //   ],
              // ),
              fullscreenDialog: true,
            );
          },
        ),
      ),
    );
  }
}
