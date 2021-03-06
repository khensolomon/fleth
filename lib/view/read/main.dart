import 'package:flutter/material.dart';

import 'package:lidea/provider.dart';
import 'package:lidea/view/main.dart';
import 'package:lidea/icon.dart';

import '/core/main.dart';

import '/widget/main.dart';
// import '/type/main.dart';

part 'bar.dart';
part 'state.dart';
part 'optionlist.dart';
part 'booklist.dart';
part 'chapterlist.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.arguments}) : super(key: key);
  final Object? arguments;
  // final GlobalKey<NavigatorState>? navigatorKey;

  static const route = '/read';
  static const icon = LideaIcon.bookOpen;
  static const name = 'Read';
  static const description = 'Read';
  static final uniqueKey = UniqueKey();
  // static final scaffoldKey = GlobalKey<ScaffoldState>();

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
        heights: const [kToolbarHeight - 20, 20],
        overlapsBorderColor: Theme.of(context).shadowColor,
        builder: bar,
      ),
      // signInList(),
      // signInWrap(),
      // const SliverToBoxAdapter(
      //   child: Text('?'),
      // ),

      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _inheritedChapter(tmpverse.elementAt(index));
          },
          childCount: tmpverse.length,
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(10),
          // color: Colors.white,

          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.elliptical(4, 3),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: WidgetButton(
                  // key: kOptionButton,
                  constraints: const BoxConstraints(maxWidth: 56, minWidth: 40.0),
                  message: preference.text.fontSize,
                  onPressed: showOptionList,
                  child: WidgetLabel(
                    icon: LideaIcon.textSize,
                    iconColor: Theme.of(context).primaryColorDark,
                  ),
                )),
          ),
        ),
      )
    ];
  }

  Widget _inheritedChapter(Map<GlobalKey, String> verse) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: SelectableText.rich(
          TextSpan(
            // text: 'header\n',
            children: [
              TextSpan(
                text:
                    '???????????????????????????????????? ${verse.values.first} ?????????????????????????????? ???????????????????????? ????????????????????????????????????????????? ?????????????????????????????? ???????????????????????????????????????????????????????????? ??????????????? ?????????????????????????????? Child Builder Delegate 3434',
              ),
            ],
          ),
          // key: Key('${verse.keys.first}'),
          key: verse.keys.first,
          scrollPhysics: const NeverScrollableScrollPhysics(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                // fontSize: collection.fontSize.asDouble,
                fontSize: collection.boxOfSettings.fontSize().asDouble,
              ),
        ),
      ),
    );
  }

  // List<TextSpan> _inheritedVerse() {

  //   return List.generate(10, (index) {
  //     return TextSpan(
  //       text: '\n\n$index\t',
  //       children: [
  //         TextSpan(
  //           text:
  //               '434',
  //         ),
  //       ],
  //     );
  //   });

  //   // return VerseInheritedWidget(
  //   //   key: verse.key,
  //   //   size: core.collection.fontSize,
  //   //   lang: core.scripturePrimary.info.langCode,
  //   //   selected: verseSelectionList.indexWhere((id) => id == verse.id) >= 0,
  //   //   child: WidgetVerse(
  //   //     verse: verse,
  //   //     onPressed: verseSelection,
  //   //   )
  //   // );
  // }
}
