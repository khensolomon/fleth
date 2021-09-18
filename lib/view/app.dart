import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:fleth/settings.dart';

class AppMain extends StatelessWidget {
  const AppMain({Key? key, required this.settingsController}) : super(key: key);
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final List<String> themeName = ["System","Light","Dark"];
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        // backwardsCompatibility: false,
        // systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        // title: const Text('Sample Items'),
        // title: Text(AppLocalizations.of(context)!.appTitle),
        backgroundColor: Theme.of(context).primaryColor,
        // title: Text(AppLocalizations.of(context)!.album),
        // title: Text(AppLocalizations.of(context)!.settings),
        title: Text(settingsController.language.settings),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              // Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
            child: Semantics(
              label: "Switch theme mode",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.lightbulb,size:20),
                  Text('Switch theme',
                    style: TextStyle(
                      fontSize: 20
                    )
                  )
                ],
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ThemeMode.values.map<Widget>((e){
                // bool active = IdeaTheme.of(context).themeMode == e;
                bool active = settingsController.themeMode == e;
                // IdeaTheme.update(context,IdeaTheme.of(context).copyWith(themeMode: ThemeMode.system));
                return Semantics(
                  label: "Switch to",
                  selected: active,
                  child: CupertinoButton(
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    padding: const EdgeInsets.symmetric(vertical:5, horizontal:10),
                    // minSize: 20,
                    // color: Theme.of(context).primaryColorDark,
                    child: Text(
                      themeName[e.index],
                      semanticsLabel: themeName[e.index],
                    ),
                    // onPressed: null,
                    // onPressed: active?null:()=>IdeaTheme.update(context,IdeaTheme.of(context).copyWith(themeMode: e))
                    // onPressed: active?null:()=>settingsController.updateThemeMode(e)
                    onPressed: active?null:()=>SettingsController().updateThemeMode(e)
                  ),
                );
              }).toList()
            )
          ),
          // CupertinoButton(
          //   child: const Text('english'),
          //   onPressed: () {
          //     controller.updateLocale(const Locale('en',''));
          //   },
          // ),
          // CupertinoButton(
          //   child: const Text('norwegian'),
          //   onPressed: () {
          //     controller.updateLocale(const Locale('no',''));
          //   },
          // )
          ListView.builder(
            shrinkWrap:true,
            primary: false,
            itemCount: AppLocalizations.supportedLocales.length,
            // itemCount: Localizations.localeOf(context).,
            itemBuilder: (_,index) {
              final sd = AppLocalizations.supportedLocales[index];
              // return Text('index $sd');
              // final asdf = Locale.fromSubtags();
              // Locale locale = Localizations.localeOf(context);
              // print(locale.)
              final String localeName = Intl.canonicalizedLocale(sd.languageCode);
              // final asdf = Intl.systemLocale;
              return ListTile(
                selected: settingsController.locale.languageCode == sd.languageCode,
                title: Text(localeName),
                onTap: () => settingsController.updateLocale(sd),
              );
            }
          )
        ],
      )
    );
  }
}