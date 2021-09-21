
import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive/hive.dart';

import 'package:intl/intl.dart';

import 'package:lidea/provider.dart';
import 'package:lidea/view.dart';

import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';
import 'package:fleth/widget.dart';
// import 'package:fleth/icon.dart';
// import 'package:fleth/type.dart';

part 'bar.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.settingsController, this.navigatorKey}) : super(key: key);
  final SettingsController? settingsController;
  final GlobalKey<NavigatorState>? navigatorKey;

  static const routeName = '/more';
  static final uniqueKey = UniqueKey();
  // static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<StatefulWidget> createState() => _View();
}

abstract class _State extends State<Main> with SingleTickerProviderStateMixin {

  late Core core;
  late SettingsController settingsController;
  late List<String> themeName;

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    core = context.read<Core>();
    settingsController = context.read<SettingsController>();
    // settingsController = SettingsController.instance;
    // settingsController = widget.settingsController!;
    // Future.microtask((){});

    themeName = [
      settingsController.translate.automatic,
      settingsController.translate.light,
      settingsController.translate.dark,
    ];
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

        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
                  child: RichText(
                    textAlign: TextAlign.center,
                    strutStyle: const StrutStyle(height: 1.5),
                    text: TextSpan(
                      // style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1.25, fontSize: 19),
                      style: Theme.of(context).textTheme.subtitle1,
                      // style: const TextStyle(height: 1.25, fontSize: 19),
                      children: <InlineSpan>[
                        const WidgetSpan(child: Icon(Icons.lightbulb,size:20), alignment: PlaceholderAlignment.middle),
                        TextSpan(text: settingsController.translate.switchTheme),
                      ],
                    ),
                  )
                ),
                Selector<SettingsController , ThemeMode>(
                  selector: (_, e) => e.themeMode,
                  builder: (BuildContext context, ThemeMode theme, Widget? child) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ThemeMode.values.map<Widget>(
                      (e){
                        bool active = theme == e;
                        return CupertinoButton(
                          child: Text(
                            themeName[e.index],
                            semanticsLabel: themeName[e.index],
                          ),
                          onPressed: active?null:()=>settingsController.updateThemeMode(e)
                        );
                      }
                    ).toList()
                  )
                )
              ]
            )
          )
        ),

        SliverList(
          delegate: SliverChildListDelegate(
             <Widget>[
               Card(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                   child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,left: 10),
                          child: RichText(
                            // textAlign: TextAlign.center,
                            strutStyle: const StrutStyle(height: 1.5),
                            text: TextSpan(
                              // style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1.25, fontSize: 19),
                              style: Theme.of(context).textTheme.subtitle1,
                              // style: const TextStyle(height: 1.25, fontSize: 19),
                              children: <InlineSpan>[
                                const WidgetSpan(child: Icon(Icons.lightbulb,size:20), alignment: PlaceholderAlignment.middle),
                                const TextSpan(text: ' '),
                                TextSpan(text: settingsController.translate.switchTheme),
                              ],
                            ),
                          )
                        ),
                        const Divider(),
                        Selector<SettingsController , ThemeMode>(
                          selector: (_, e) => e.themeMode,
                          builder: (BuildContext context, ThemeMode theme, Widget? child) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: ThemeMode.values.map<Widget>(
                              (e){
                                bool active = theme == e;
                                return CupertinoButton(
                                  // padding: EdgeInsets.zero,
                                  child: Text(
                                    themeName[e.index],
                                    semanticsLabel: themeName[e.index],
                                  ),
                                  onPressed: active?null:()=>settingsController.updateThemeMode(e)
                                );
                              }
                            ).toList()
                          )
                        )
                      ]
                   )
                 ),
               ),
               Card(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                   child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,left: 10),
                          child: RichText(
                            // textAlign: TextAlign.center,
                            strutStyle: const StrutStyle(height: 1.5),
                            text: TextSpan(
                              // style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1.25, fontSize: 19),
                              style: Theme.of(context).textTheme.subtitle1,
                              // style: const TextStyle(height: 1.25, fontSize: 19),
                              children: <InlineSpan>[
                                const WidgetSpan(child: Icon(Icons.translate,size:20), alignment: PlaceholderAlignment.middle),
                                const TextSpan(text: ' '),
                                TextSpan(text: settingsController.translate.locale),
                              ],
                            ),
                          )
                        ),
                        const Divider(),
                        ListView.builder(
                          shrinkWrap:true,
                          primary: false,
                          itemCount: AppLocalizations.supportedLocales.length,
                          // itemCount: Localizations.localeOf(context).,
                          padding: EdgeInsets.zero,
                          itemBuilder: (_,index) {
                            final sd = AppLocalizations.supportedLocales[index];
                            // return Text('index $sd');
                            // final asdf = Locale.fromSubtags();
                            Locale locale = Localizations.localeOf(context);
                            // print(locale.)
                            final String localeName = Intl.canonicalizedLocale(sd.languageCode);
                            final bool adf = locale.languageCode == sd.languageCode;
                            // final asdf = Intl.systemLocale;
                            // debugPrint(settingsController.locale.languageCode);
                            return ListTile(
                              selected: adf,
                              leading: Icon(adf?Icons.radio_button_checked:Icons.radio_button_unchecked),
                              title: Text(' $localeName ${settingsController.locale.languageCode} ${sd.languageCode} $adf'),
                              onTap: () => settingsController.updateLocale(sd),
                            );
                          }
                        )
                      ]
                   )
                 ),
               ),
             ]
          )
        ),

        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 10, bottom: 10),
                child: Text('Font size and color'),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    children: [
                      Text('headline 1', style: Theme.of(context).textTheme.headline1,),
                      Text('headline 2', style: Theme.of(context).textTheme.headline2,),
                      Text('headline 3', style: Theme.of(context).textTheme.headline3,),
                      Text('headline 4', style: Theme.of(context).textTheme.headline4,),
                      Text('headline 5', style: Theme.of(context).textTheme.headline5,),
                      Text('headline 6', style: Theme.of(context).textTheme.headline6,),

                      Text('subtitle 1', style: Theme.of(context).textTheme.subtitle1,),
                      Text('subtitle 2', style: Theme.of(context).textTheme.subtitle2,),

                      Text('bodyText 1', style: Theme.of(context).textTheme.bodyText1,),
                      Text('bodyText 2', style: Theme.of(context).textTheme.bodyText2,),

                      Text('caption', style: Theme.of(context).textTheme.caption,),
                      Text('button', style: Theme.of(context).textTheme.button,),
                      Text('overline', style: Theme.of(context).textTheme.overline,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

        SliverList(
          delegate: SliverChildListDelegate(
             <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('CupertinoButton'),
                    const CupertinoButton(
                      onPressed: null,
                      child: Text('No'),
                    ),
                    const SizedBox(height: 5),
                    CupertinoButton(
                      onPressed: ()=>false,
                      child: const Text('Yes'),
                    ),
                  ],
                ),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('ElevatedButton'),
                    const ElevatedButton(
                      onPressed: null,
                      child: Text('No'),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: ()=>false,
                      child: const Text('Yes'),
                    ),
                  ],
                ),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('TextButton'),
                    const TextButton(
                      onPressed: null,
                      child: Text('No'),
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: ()=>false,
                      child: const Text('Yes'),
                    ),
                  ],
                ),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('IconButton'),
                    const IconButton(
                      icon: Icon(Icons.accessibility),
                      onPressed: null,
                    ),
                    const SizedBox(height: 5),
                    IconButton(
                      onPressed: ()=>false,
                      icon: const Icon(Icons.accessibility),
                    ),
                  ],
                ),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('TextButton.icon'),
                    TextButton.icon(
                      icon: const Icon(Icons.accessibility),
                      label: const Text('No'),
                      onPressed: null,
                    ),
                    const SizedBox(height: 5),
                    TextButton.icon(
                      icon: const Icon(Icons.accessibility),
                      label: const Text('Yes'),
                      onPressed: ()=>true,
                    ),
                  ],
                )
             ]
          )
        ),
      ]
    );
  }
}
