part of 'main.dart';

mixin _Bar on _State {
  Widget bar(BuildContext context, ViewHeaderData org) {
    double width = MediaQuery.of(context).size.width * 0.5;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: org.snapShrink * 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WidgetButton(
            constraints: const BoxConstraints(maxWidth: 56, minWidth: 50.0, maxHeight: 40),
            child: WidgetLabel(
              icon: Icons.bookmark_add,
              iconColor: Theme.of(context).primaryColorDark,
              iconSize: (org.shrink * 26).clamp(18, 26).toDouble(),
            ),
            message: preference.text.addTo(preference.text.bookmark(true)),
            // onPressed: setBookMark,
            show: hasArguments,
            onPressed: args?.currentState!.maybePop,
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetButton(
                  key: kBookButton,
                  constraints: BoxConstraints(maxWidth: width, minWidth: 48),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor.withOpacity(org.snapShrink),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.elliptical(20, 50),
                    ),
                  ),
                  child: _barButton(
                    label: '1',
                    shrink: org.shrink,
                    padding: EdgeInsets.fromLTRB(7, 0, org.snapShrink * 5, 0),
                  ),
                  message: preference.text.book(true),
                  onPressed: showBookList,
                ),
                Divider(
                  indent: 1 * org.snapShrink,
                ),
                WidgetButton(
                  key: kChapterButton,
                  constraints: BoxConstraints(maxWidth: width, minWidth: 30),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor.withOpacity(org.snapShrink),
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.elliptical(20, 50),
                    ),
                  ),
                  child: _barButton(
                    label: '150',
                    shrink: org.shrink,
                    padding: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                  ),
                  message: preference.text.chapter(true),
                  onPressed: showChapterList,
                ),
              ],
            ),
          ),
          WidgetButton(
            key: kOptionButton,
            constraints: const BoxConstraints(maxWidth: 56, minWidth: 50.0),
            child: WidgetLabel(
              icon: LideaIcon.textSize,
              iconColor: Theme.of(context).primaryColorDark,
              iconSize: (org.shrink * 22).clamp(18, 22).toDouble(),
            ),
            message: preference.text.fontSize,
            onPressed: showOptionList,
          ),
        ],
      ),
    );
  }

  // Widget _barButton(
  //     {Key? key,
  //     required double shrink,
  //     required String label,
  //     required String message,
  //     EdgeInsetsGeometry? padding = EdgeInsets.zero,
  //     required void Function()? onPressed}) {
  //   return Tooltip(
  //     message: message,
  //     child: WidgetButton(
  //       key: key,
  //       // minSize: 33,
  //       padding: const EdgeInsets.symmetric(horizontal: 7),
  //       child: Text(
  //         label,
  //         maxLines: 1,
  //         softWrap: false,
  //         overflow: TextOverflow.fade,
  //         textAlign: TextAlign.center,
  //         style: Theme.of(context)
  //             .textTheme
  //             .bodyLarge!
  //             .copyWith(fontSize: (shrink * 19).clamp(15, 19)),
  //       ),
  //       onPressed: onPressed,
  //     ),
  //   );
  // }
  Widget _barButton({
    required double shrink,
    required String label,
    required EdgeInsetsGeometry padding,
  }) {
    return WidgetLabel(
      label: label,
      // labelPadding: const EdgeInsets.symmetric(horizontal: 7),
      labelPadding: padding,
      labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: (shrink * 18).clamp(15, 18),
          ),
    );
  }

  void showOptionList() {
    Navigator.of(context)
        .push(
      PageRouteBuilder<int>(
        opaque: false,
        barrierDismissible: true,
        transitionsBuilder:
            (BuildContext _, Animation<double> x, Animation<double> y, Widget child) =>
                FadeTransition(
          opacity: x,
          child: child,
        ),
        pageBuilder: (BuildContext _, x, y) => PopOptionList(
          render: kOptionButton.currentContext!.findRenderObject() as RenderBox,
          setFontSize: setFontSize,
        ),
      ),
    )
        .whenComplete(() {
      // core.writeCollection();
    });
  }

  void showBookList() {
    // if (isNotReady) return null;
    // if(keyBookButton.currentContext!=null) return;

    Navigator.of(context)
        .push(
      PageRouteBuilder<Map<String?, int?>>(
        opaque: false,
        barrierDismissible: true,
        transitionsBuilder:
            (BuildContext _, Animation<double> x, Animation<double> y, Widget child) =>
                FadeTransition(opacity: x, child: child),
        // barrierColor: Colors.white.withOpacity(0.4),
        // barrierColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
        pageBuilder: (BuildContext context, x, y) => PopBookList(
          render: kBookButton.currentContext!.findRenderObject() as RenderBox,
        ),
      ),
    )
        .then((e) {
      if (e != null) {
        // debugPrint(e);
        // core.chapterChange(bookId: e['book'], chapterId: e['chapter']);
        // setBook(e);
      }
    });
  }

  void showChapterList() {
    // if (isNotReady) return null;
    Navigator.of(context)
        .push(
      PageRouteBuilder<int>(
        opaque: false,
        barrierDismissible: true,
        transitionsBuilder:
            (BuildContext _, Animation<double> x, Animation<double> y, Widget child) =>
                FadeTransition(opacity: x, child: child),
        // barrierColor: Colors.white.withOpacity(0.4),
        // barrierColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
        pageBuilder: (BuildContext context, x, y) => PopChapterList(
          render: kChapterButton.currentContext!.findRenderObject() as RenderBox,
        ),
      ),
    )
        .then((e) {
      // setChapter(e);
    });
  }
}
