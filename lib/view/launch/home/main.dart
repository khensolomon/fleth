import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// TODO replace with extended PullToAny
import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';

import 'package:lidea/provider.dart';
// import 'package:lidea/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:lidea/view/main.dart';
import 'package:lidea/icon.dart';

import '/core/main.dart';
import '/type/main.dart';
import '/widget/main.dart';

part 'bar.dart';
part 'state.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.arguments}) : super(key: key);

  final Object? arguments;

  static const route = '/launch/home';
  static const icon = LideaIcon.search;
  static const name = 'Home';
  static const description = '...';

  @override
  State<StatefulWidget> createState() => _View();
}

class _View extends _State with _Bar {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewPage(
        controller: scrollController,
        child: CustomScrollView(
          controller: scrollController,
          slivers: sliverWidgets(),
        ),
      ),
    );
  }

  List<Widget> sliverWidgets() {
    return [
      ViewHeaderSliverSnap(
        pinned: true,
        floating: false,
        padding: MediaQuery.of(context).viewPadding,
        heights: const [kToolbarHeight, 70],
        overlapsBackgroundColor: Theme.of(context).primaryColor,
        overlapsBorderColor: Theme.of(context).shadowColor,
        builder: bar,
      ),
      const PullToRefresh(),
      SliverList(
        delegate: SliverChildListDelegate(
          [
            WidgetBlockTile(
              title: Text(preference.text.recentSearch(true)),
              trailing: WidgetButton(
                child: const WidgetLabel(
                  icon: Icons.more_horiz,
                ),
                message: preference.text.addTo(preference.text.recentSearch(true)),
                duration: const Duration(milliseconds: 300),
                onPressed: () {
                  core.navigate(to: '/recent-search');
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: researchWrap(),
              ),
            ),
          ],
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          [
            WidgetBlockTile(
              title: Text(preference.text.favorite(true)),
              trailing: WidgetButton(
                child: const WidgetLabel(
                  icon: Icons.more_horiz,
                ),
                message: preference.text.addTo(preference.text.favorite(true)),
                duration: const Duration(milliseconds: 300),
                onPressed: () {
                  core.navigate(to: '/favorite-word');
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: favoriteWrap(),
              ),
            ),
          ],
        ),
      ),
      // const SliverToBoxAdapter(
      //   child: Text('promote'),
      // ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
              ListTile(
                title: const Text('BoxOfPerson'),
                onTap: testing,
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Search: suggest'),
                onTap: () => core.navigate(to: '/search'),
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Search: result'),
                onTap: () => core.navigate(to: '/search-result'),
              ),
              ListTile(
                leading: const Icon(Icons.manage_search_rounded),
                title: const Text('Recent search'),
                onTap: () => core.navigate(to: '/recent-search'),
              ),
              ListTile(
                leading: const Icon(Icons.low_priority_outlined),
                title: const Text('Navigate to Blog'),
                onTap: () => core.navigate(to: '/blog'),
              ),
              ListTile(
                leading: const Icon(Icons.article),
                title: const Text('Navigate to article'),
                onTap: () => core.navigate(to: '/article'),
              ),
              ListTile(
                leading: const Icon(LideaIcon.bookOpen),
                title: const Text('Navigate to reader'),
                onTap: () => core.navigate(to: '/read'),
              ),
              ListTile(
                leading: const Icon(Icons.sort),
                title: const Text('Reorderable with Swipe for more'),
                onTap: () => core.navigate(to: '/reorderable'),
              ),
              ListTile(
                leading: const Icon(Icons.list_rounded),
                title: const Text('Dismissible'),
                onTap: () => core.navigate(to: '/dismissible'),
              ),
              ListTile(
                leading: const Icon(Icons.note_alt),
                title: const Text('Note'),
                onTap: () => core.navigate(to: '/note'),
              ),
              ListTile(
                leading: const Icon(Icons.inventory_rounded),
                title: const Text('Store'),
                onTap: () => core.navigate(to: '/store'),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () => core.navigate(to: '/settings'),
              ),
            ],
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
              TextButton.icon(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  // textStyle: TextStyle(color: Colors.blue),
                  // backgroundColor: Colors.white,
                  // shape:RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(24.0),
                  // ),
                ),
                icon: const Icon(Icons.baby_changing_station),
                label: const Text('TextButton NoSplash'),
                onPressed: () => core.mockTest1(),
              ),
              TextButton.icon(
                icon: const Icon(Icons.icecream_outlined),
                label: const Text('TextButton.icon'),
                onPressed: () => core.mockTest2(),
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => const Color(0xfffbba3d).withOpacity(0.3),
                  ),
                ),
                child: const Text('TextButton custom overlayColor'),
                onPressed: () => false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Chip(
                    avatar: Icon(Icons.style_sharp),
                    label: Text(
                      'Chip',
                      strutStyle: StrutStyle(),
                    ),
                  ),
                  Chip(
                    avatar: const Icon(Icons.style_sharp),
                    deleteIcon: const Icon(Icons.style_sharp),
                    onDeleted: () {},
                    label: const Text(
                      'စမ်းသပ်မှု',
                      strutStyle: StrutStyle(),
                    ),
                  ),
                  CupertinoButton(
                    child: const Chip(
                      avatar: Icon(CupertinoIcons.back),
                      labelPadding: EdgeInsets.zero,
                      label: Text(
                        'Back',
                        strutStyle: StrutStyle(),
                      ),
                    ),
                    onPressed: () => {},
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  WidgetLabel(
                    label: 'abc',
                  ),
                  WidgetLabel(
                    label: '23',
                  ),
                  WidgetLabel(
                    icon: Icons.arrow_back_ios_new_rounded,
                    textAlign: TextAlign.right,
                    label: 'နောက်',
                  ),
                  WidgetLabel(
                    icon: Icons.arrow_back_ios_new_rounded,
                    textAlign: TextAlign.left,
                    label: 'Back',
                  ),
                ],
              ),
              ListTile(
                title: const Text('data Wrap'),
                trailing: Padding(
                  padding: EdgeInsets.zero,
                  child: SizedBox(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Icon(Icons.arrow_back_ios_new_rounded),
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Text('Back'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const ListTile(
                title: Text('data WidgetLabel'),
                trailing: WidgetLabel(
                  icon: Icons.arrow_back_ios_new_rounded,
                  textAlign: TextAlign.left,
                  label: 'Back',
                ),
              ),
              ListTile(
                title: const Text('data row'),
                trailing: Padding(
                  padding: EdgeInsets.zero,
                  child: SizedBox(
                    child: Row(
                      // crossAxisAlignment: WrapCrossAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.arrow_back_ios_new_rounded),
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Text('နောက်'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const ListTile(
                title: Text('data WidgetLabel'),
                trailing: WidgetLabel(
                  icon: Icons.arrow_back_ios_new_rounded,
                  textAlign: TextAlign.left,
                  label: 'နောက်',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.zero,
                    child: SizedBox(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          Icon(Icons.arrow_back_ios_new_rounded),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: Text('Back'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: SizedBox(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          Icon(Icons.arrow_back_ios_new_rounded),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: Text('နောက်'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const ListTile(
                title: Text('နောက် WidgetMark'),
                trailing: WidgetMark(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  icon: Icons.arrow_back_ios_new_rounded,
                  textAlign: TextAlign.left,
                  // constraints: BoxConstraints(maxWidth: 80),
                  // constraints: BoxConstraints(minHeight: 30),
                  label: 'နောက်',
                ),
              ),
              const ListTile(
                title: Text('Back WidgetMark'),
                trailing: WidgetMark(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  icon: Icons.arrow_back_ios_new_rounded,
                  textAlign: TextAlign.left,
                  // constraints: BoxConstraints(minHeight: 30),
                  label: 'Back',
                ),
              ),
              Wrap(
                children: [
                  const WidgetMark(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    badge: '78',
                    label: 'A',
                  ),
                  const WidgetLabel(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    label: 'B',
                    icon: Icons.ac_unit,
                  ),
                  const WidgetMark(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    // padding: EdgeInsets.all(10),
                    iconLeft: false,
                    badge: '2',
                    icon: Icons.ac_unit,
                    label: 'B',
                  ),
                  CupertinoButton(
                    // padding: EdgeInsets.zero,
                    color: Colors.red,
                    child: const Text('ABc'),
                    onPressed: () {},
                  ),
                ],
              ),
              const WidgetMark(
                // alignment: WrapAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                icon: Icons.arrow_back_ios_new_rounded,
                textAlign: TextAlign.left,
                badge: '212',
                // constraints: BoxConstraints(maxWidth: 100),
                label: 'Long',
              ),
              const WidgetLabel(
                // alignment: WrapAlignment.center,

                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                icon: Icons.arrow_back_ios_new_rounded,
                textAlign: TextAlign.left,
                // constraints: BoxConstraints(maxWidth: 100),
                label: 'Long',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    child: const Chip(
                      avatar: Icon(CupertinoIcons.back),
                      labelPadding: EdgeInsets.zero,
                      label: Text(
                        'ပြန်',
                        strutStyle: StrutStyle(),
                      ),
                    ),
                    onPressed: () => {},
                  ),
                  CupertinoButton(
                    child: const Chip(
                      avatar: Icon(CupertinoIcons.back),
                      labelPadding: EdgeInsets.zero,
                      label: Text(
                        'နောက်',
                        strutStyle: StrutStyle(),
                      ),
                    ),
                    onPressed: () => {},
                  ),
                  CupertinoButton(
                    child: const Chip(
                      avatar: Icon(CupertinoIcons.back),
                      labelPadding: EdgeInsets.zero,
                      label: Text(
                        'အိမ်',
                        strutStyle: StrutStyle(),
                      ),
                    ),
                    onPressed: () => {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ];
  }

  Widget researchWrap() {
    return Selector<Core, List<MapEntry<dynamic, RecentSearchType>>>(
      selector: (_, e) => e.collection.boxOfRecentSearch.entries.toList(),
      builder: (BuildContext _, List<MapEntry<dynamic, RecentSearchType>> items, Widget? __) {
        items.sort((a, b) => b.value.date!.compareTo(a.value.date!));
        if (items.isEmpty) {
          return const Icon(LideaIcon.dotHoriz);
        }
        return Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          textDirection: TextDirection.ltr,
          children: items.take(3).map(
            (e) {
              return CupertinoButton(
                child: Text(
                  e.value.word,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onPressed: () => onSearch(e.value.word),
              );
            },
          ).toList(),
        );
      },
    );
  }

  Widget favoriteWrap() {
    return Selector<Core, List<MapEntry<dynamic, FavoriteWordType>>>(
      selector: (_, e) => e.collection.favorites.toList(),
      builder: (BuildContext _, List<MapEntry<dynamic, FavoriteWordType>> items, Widget? __) {
        items.sort((a, b) => b.value.date!.compareTo(a.value.date!));
        if (items.isEmpty) {
          return const Icon(LideaIcon.dotHoriz);
        }
        return Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          textDirection: TextDirection.ltr,
          children: items.take(3).map(
            (e) {
              return CupertinoButton(
                child: Text(
                  e.value.word,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onPressed: () => onSearch(e.value.word),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
