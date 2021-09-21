import 'package:flutter/material.dart';

// import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';
// import 'package:fleth/widget.dart';

// launch blog article
import 'launch/main.dart' as launch;
import 'blog/main.dart' as blog;
import 'article/main.dart' as article;
import 'search/main.dart' as search;
// import 'album/main.dart' as Album;
// import 'search/main.dart' as Search;
// import 'album-info/main.dart' as AlbumInfo;
// import 'artist/main.dart' as Artist;
// import 'artist-info/main.dart' as ArtistInfo;

class Main extends StatefulWidget {
  const Main({Key? key, this.settingsController, this.navigatorKey}) : super(key: key);

  final SettingsController? settingsController;
  final GlobalKey<NavigatorState>? navigatorKey;

  static const routeName = '/home';
  static final uniqueKey = UniqueKey();
  // static final navigatorKeyTmp = GlobalKey<NavigatorState>;
  // static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<Main>{

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: widget.key,
      body: HeroControllerScope(
        controller: MaterialApp.createMaterialHeroController(),
        child: Navigator(
          key: widget.navigatorKey,
          initialRoute: "/",
          // restorationScopeId: 'home',
          onGenerateRoute: (RouteSettings settings) {
            // You can also return a PageRouteBuilder and
            // define custom transitions between pages

            // MaterialPageRoute<void>(
            //   settings: settings,
            //   builder: (_){
            //     switch (settings.name) {
            //       case blog.Main.routeName:
            //         return blog.Main(arguments: settings.arguments);
            //       case article.Main.routeName:
            //         return article.Main(arguments: settings.arguments);
            //       case search.Main.routeName:
            //         return search.Main(arguments: settings.arguments);
            //       case launch.Main.routeName:
            //       default:
            //         // throw Exception('Invalid route: ${settings.name}');
            //         return launch.Main(arguments: settings.arguments);
            //     }
            //   }
            // );

            return PageRouteBuilder(
              settings: settings,
              // BuildContext, Animation<double>, Animation<double>
              pageBuilder: (BuildContext _, Animation<double> _a, Animation<double> _b) {
                switch (settings.name) {
                  case blog.Main.routeName:
                    return blog.Main(arguments: settings.arguments);
                  case article.Main.routeName:
                    return article.Main(arguments: settings.arguments);
                  case search.Main.routeName:
                    return search.Main(arguments: settings.arguments);
                  case launch.Main.routeName:
                  default:
                    // throw Exception('Invalid route: ${settings.name}');
                    return launch.Main(arguments: settings.arguments);
                }
              },
              transitionDuration: const Duration(milliseconds: 350),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              // transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
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
              fullscreenDialog: true
            );

          }
        ),
      )
    );
  }

}
