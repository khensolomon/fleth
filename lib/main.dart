import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:lidea/provider.dart';
import 'package:lidea/view/notify.dart';

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
  // Flutter Widgets.
  // final settingsController = SettingsController(SettingsService());
  final settingsController = SettingsController();

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.init();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(Zaideih(settingsController: settingsController));
}

class Zaideih extends StatelessWidget {
  const Zaideih({Key? key, required this.settingsController}) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotifyViewScroll>(
          create: (context) => NotifyViewScroll(),
        ),
        ChangeNotifierProvider<Core>(
          create: (context) => Core(),
        ),
        ChangeNotifierProvider<SettingsController>(
          create: (context) => settingsController,
        )
      ],
      child:  builds()
    );
  }
  Widget builds(){
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        final brightness = settingsController.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemStatusBarContrastEnforced:true,
            systemNavigationBarContrastEnforced: true,
            statusBarBrightness: brightness?Brightness.light:Brightness.dark,
            systemNavigationBarColor: brightness?IdeaData.dark.scaffoldBackgroundColor:IdeaData.light.scaffoldBackgroundColor,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: brightness?Brightness.light:Brightness.dark,
          ),
          child: MaterialApp(
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
            // locale: Locale(settingsController.locale, ''),
            locale: settingsController.locale,
            supportedLocales: const [
              Locale('en', 'GB'), // English
              Locale('no', 'NO'), // Norwegian
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
              
              darkTheme: IdeaData.dark,
              theme: IdeaData.light,
              // themeMode: IdeaTheme.of(context).themeMode,  
              themeMode: settingsController.themeMode,        

            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  settingsController.context = context;
                  return AppMain(settingsController: settingsController,);
                  // switch (routeSettings.name) {
                  //   case SettingsView.routeName:
                  //     return SettingsView(controller: settingsController);
                  //   case SampleItemDetailsView.routeName:
                  //     return const SampleItemDetailsView();
                  //   case SampleItemListView.routeName:
                  //   default:
                  //     return const SampleItemListView();
                  // }
                },
              );
            },
          ),
        );
      },
    );
  }
  /*
  Widget app(){
    return Builder(
      builder: (context) => uiOverlayStyle(
        context: context,
        isBrightness: IdeaTheme.of(context).resolvedSystemBrightness == Brightness.light,
        brightness: IdeaTheme.of(context).resolvedSystemBrightness,
        child: MaterialApp(
          title: "Zaideih",
          // title: Core.instance.collection.env.name,
          showSemanticsDebugger: false,
          debugShowCheckedModeBanner: false,
          darkTheme: IdeaData.dark.copyWith(
            platform: IdeaTheme.of(context).platform,
            brightness: IdeaTheme.of(context).systemBrightness
          ),
          theme: IdeaData.light.copyWith(
            platform: IdeaTheme.of(context).platform,
            brightness: IdeaTheme.of(context).systemBrightness
          ),
          themeMode: IdeaTheme.of(context).themeMode,
          locale: IdeaTheme.of(context).locale,
          // supportedLocales: GalleryLocalizations.supportedLocales,
          // localizationsDelegates: const [
          //   ...GalleryLocalizations.localizationsDelegates,
          //   LocaleNamesLocalizationsDelegate()
          // ],
          localeResolutionCallback: (locale, supportedLocales) => locale,
          // initialRoute: initialRoute,
          onGenerateRoute: (RouteSettings settings) => PageRouteBuilder<void>(
            settings: settings,
            pageBuilder: (_, __, ___)  => const ApplyTextOptions(
              child: AppMain(settingsController: settingsController,)
            ),
          )
          // onGenerateRoute: (RouteSettings settings) => MaterialPageRoute<void>(
          //   builder: (context) => ApplyTextOptions(
          //     child: const AppMain()
          //   ),
          //   settings: settings
          // )
          // onUnknownRoute: RouteConfiguration.onUnknownRoute,
        )
      )
    );
  }
  */

  // Widget uiOverlayStyle({required BuildContext context, required Brightness brightness, required bool isBrightness, required Widget child}){
  //   return AnnotatedRegion<SystemUiOverlayStyle>(
  //     value: SystemUiOverlayStyle(
  //       statusBarColor: Colors.transparent,
  //       statusBarIconBrightness: brightness,
  //       statusBarBrightness: isBrightness?Brightness.dark:Brightness.light,
  //       // systemNavigationBarColor: isBrightness?IdeaData.darkScheme.primary:IdeaData.lightScheme.primary,
  //       systemNavigationBarColor: isBrightness?IdeaData.dark.primaryColor:IdeaData.light.primaryColor,
  //       // systemNavigationBarColor: isBrightness?IdeaData.dark.scaffoldBackgroundColor:IdeaData.light.scaffoldBackgroundColor,
  //       systemNavigationBarDividerColor: Colors.transparent,
  //       systemNavigationBarIconBrightness: brightness
  //     ),
  //     child: child
  //   );
  // }
}
