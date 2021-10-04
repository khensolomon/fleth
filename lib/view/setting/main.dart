import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'package:intl/intl.dart';

import 'package:lidea/provider.dart';
import 'package:lidea/view.dart';
import 'package:lidea/authentication.dart';
// import 'package:lidea/icon.dart';

import 'package:fleth/core.dart';
import 'package:fleth/settings.dart';
import 'package:fleth/widget.dart';
// import 'package:fleth/type.dart';

import 'package:fleth/view/setting/demo/text_translate.dart';
import 'package:fleth/view/setting/demo/button_style.dart';
import 'package:fleth/view/setting/demo/do_confirm.dart';
import 'package:fleth/view/setting/demo/sliver_grid.dart';
import 'package:fleth/view/setting/demo/sliver_list.dart';
import 'package:fleth/view/setting/demo/text_height.dart';
import 'package:fleth/view/setting/demo/text_size.dart';

part 'bar.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.settings, this.navigatorKey}) : super(key: key);
  final SettingsController? settings;
  final GlobalKey<NavigatorState>? navigatorKey;

  static const route = '/settings';
  static const icon = Icons.settings;
  static const name = 'Settings';
  static const description = 'Settings';
  static final uniqueKey = UniqueKey();
  // static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<StatefulWidget> createState() => _View();
}

abstract class _State extends State<Main> with SingleTickerProviderStateMixin {
  late final Core core = context.read<Core>();
  late final SettingsController settings = context.read<SettingsController>();
  // late final AppLocalizations translate = AppLocalizations.of(context)!;
  late final Authentication authenticate = context.read<Authentication>();
  late final scrollController = ScrollController();

  // SettingsController get settings => context.read<SettingsController>();
  AppLocalizations get translate => AppLocalizations.of(context)!;
  // Authentication get authenticate => context.read<Authentication>();

  List<String> get themeName => [
        translate.automatic,
        translate.light,
        translate.dark,
      ];

  @override
  void initState() {
    super.initState();
    // Future.microtask((){});
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void onClearAll() {
    Future.microtask(() {});
  }

  void onSearch(String word) {}

  void onDelete(String word) {
    Future.delayed(Duration.zero, () {});
  }
}

class _View extends _State with _Bar {
  @override
  Widget build(BuildContext context) {
    return ViewPage(
      key: widget.key,
      controller: scrollController,
      child: body(),
    );
  }

  CustomScrollView body() {
    return CustomScrollView(
      // primary: true,
      controller: scrollController,
      slivers: <Widget>[
        bar(),
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
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: WidgetLabel(
                          icon: Icons.lightbulb,
                          label: translate.themeMode,
                        ),
                      ),
                      const Divider(),
                      Selector<SettingsController, ThemeMode>(
                        selector: (_, e) => e.themeMode,
                        builder: (BuildContext context, ThemeMode theme, Widget? child) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: ThemeMode.values.map<Widget>((e) {
                            bool active = theme == e;
                            return CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              child: WidgetLabel(
                                enable: !active,
                                label: themeName[e.index],
                              ),
                              onPressed: active ? null : () => settings.updateThemeMode(e),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: WidgetLabel(
                          icon: Icons.translate,
                          label: translate.locale,
                        ),
                      ),
                      const Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: AppLocalizations.supportedLocales.length,
                        // itemCount: Localizations.localeOf(context).,
                        padding: EdgeInsets.zero,
                        itemBuilder: (_, index) {
                          final lang = AppLocalizations.supportedLocales[index];

                          Locale locale = Localizations.localeOf(context);
                          final String localeName = Intl.canonicalizedLocale(lang.languageCode);
                          final bool isCurrent = locale.languageCode == lang.languageCode;

                          return ListTile(
                            selected: isCurrent,
                            leading: Icon(isCurrent
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked),
                            title: Text(localeName),
                            onTap: () => settings.updateLocale(lang),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const DemoTextTranslate(),
        const DemoButtonStyle(),
        const DemoDoConfirm(),
        const DemoSliverGrid(),
        const DemoSliverList(),
        const DemoTextHeight(),
        const DemoTextSize(),
      ],
    );
  }
}
