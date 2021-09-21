import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:lidea/provider.dart';
import 'package:lidea/view/notify.dart';
// import 'package:lidea/idea.dart';

// flutter create -t skeleton fleth
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';

import 'core/theme/data.dart';
import 'view/app.dart';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  // }

  if (isProduction) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  // Set up the SettingsController, which will glue user settings to multiple
  final core = Core();
  await core.initEnvironment();

  final settingsController = SettingsController();

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.init();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  runApp(Fleth(core:core,settingsController: settingsController));
}

class Fleth extends StatelessWidget {
  const Fleth({Key? key, required this.core, required this.settingsController}) : super(key: key);

  final Core core;
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotifyViewScroll>(
          create: (context) => NotifyViewScroll(),
        ),
        ChangeNotifierProvider<Core>(
          create: (context) => core,
        ),
        ChangeNotifierProvider<SettingsController>(
          create: (context) => settingsController,
        )
      ],
      child:  start()
    );
  }
  Widget start(){
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        // final brightness = settingsController.isDarkMode;
        return MaterialApp(
          showSemanticsDebugger: false,
          // debugShowCheckedModeBanner: false,
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'fleth',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: settingsController.locale,
          supportedLocales: const [
            // English
            Locale('en', 'GB'),
            // Norwegian
            Locale('no', 'NO'),
            // Myanmar
            Locale('my', ''),
          ],
          // localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
          //   for (Locale supportedLocale in supportedLocales) {
          //     if (supportedLocale.languageCode == locale!.languageCode ||
          //         supportedLocale.countryCode == locale.countryCode) {
          //       return supportedLocale;
          //     }
          //   }
          //   return supportedLocales.first;
          // },
          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          // onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
          onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          // theme: ThemeData(),
          // darkTheme: ThemeData.dark(),
          // themeMode: settingsController.themeMode,

            darkTheme: IdeaData.dark(context),
            theme: IdeaData.light(context),
            // themeMode: IdeaTheme.of(context).themeMode,
            themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings settings) => PageRouteBuilder<void>(
            settings: settings,
            pageBuilder: (BuildContext context, Animation<double> a, Animation<double> b) {
              settingsController.context = context;
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  systemNavigationBarColor: Theme.of(context).primaryColor,
                  systemNavigationBarDividerColor: Colors.transparent,
                  systemNavigationBarIconBrightness: settingsController.resolvedSystemBrightness,
                  systemNavigationBarContrastEnforced: true,
                  statusBarColor: Colors.transparent,
                  statusBarBrightness: settingsController.resolvedSystemBrightness,
                  statusBarIconBrightness: settingsController.resolvedSystemBrightness,
                  systemStatusBarContrastEnforced:true,
                ),
                child: AppMain(settingsController: settingsController),
              );
            }
          )
          // onGenerateRoute: (RouteSettings routeSettings) {
          //   return MaterialPageRoute<void>(
          //     settings: routeSettings,
          //     builder: (BuildContext context) {
          //       settingsController.context = context;
          //       switch (routeSettings.name) {
          //         // case SettingsView.routeName:
          //         //   return AppMain(settingsController: settingsController,);
          //         case AppMain.routeName:
          //         default:
          //           return AnnotatedRegion<SystemUiOverlayStyle>(
          //             value: SystemUiOverlayStyle(
          //               systemNavigationBarColor: Theme.of(context).primaryColor,
          //               systemNavigationBarDividerColor: Colors.transparent,
          //               systemNavigationBarIconBrightness: settingsController.resolvedSystemBrightness,
          //               systemNavigationBarContrastEnforced: true,
          //               statusBarColor: Colors.transparent,
          //               statusBarBrightness: settingsController.resolvedSystemBrightness,
          //               statusBarIconBrightness: settingsController.resolvedSystemBrightness,
          //               systemStatusBarContrastEnforced:true,
          //             ),
          //             child: const AppMain(),
          //           );
          //       }
          //     },
          //   );
          // },
        );
      },
    );
  }
}
