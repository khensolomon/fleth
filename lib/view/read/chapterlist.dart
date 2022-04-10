part of 'main.dart';

class PopChapterList extends StatefulWidget {
  final RenderBox render;

  const PopChapterList({
    Key? key,
    required this.render,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopChapterListState();
}

class _PopChapterListState extends State<PopChapterList> {
  final double arrowWidth = 10;
  final double arrowHeight = 12;

  // late final Core core = context.read<Core>();
  late final Size mediaSize = MediaQuery.of(context).size;
  late final double mediaWidthHaft = mediaSize.width * 0.4;

  late final Size widgetSize = widget.render.size;
  late final Offset widgetPosition = widget.render.localToGlobal(Offset.zero);

  late final double bottomOfWidget = widgetPosition.dy + widgetSize.height + arrowHeight;

  int get chapterCount => 5;
  // int get chapterCount => book.info.chapterCount;
  int get perItem => chapterCount > 4 ? 4 : chapterCount;
  // double get height => (chapterCount < 4)?(250 / chapterCount).toDouble():(chapterCount/perItem).ceilToDouble()*62;
  double get height => (chapterCount < 4)
      ? (200 / chapterCount).toDouble()
      : (chapterCount / perItem).ceilToDouble() * 52;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    // double halfWidth = (MediaQuery.of(context).size.width / 2) - 50;
    return WidgetPopupShapedArrow(
      left: mediaWidthHaft,
      right: 30,
      top: bottomOfWidget,
      height: height,
      // arrow: targetPosition.dx - halfWidth + (targetSize.width / 2) - 10,
      // arrow: widgetPosition.dx - mediaWidthHaft,
      arrow: widgetPosition.dx - mediaWidthHaft + (widgetSize.width * 0.2),
      backgroundColor: Theme.of(context).backgroundColor,
      child: view(),
    );
  }

  Widget view() {
    return GridTile(
      header: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).backgroundColor,
              blurRadius: 10,
              spreadRadius: 20,
              offset: const Offset(0, 0),
            ),
          ],
        ),
      ),
      footer: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).backgroundColor,
              blurRadius: 5,
              spreadRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
      ),
      // footer: Text('...'),
      child: GridView.count(
        padding: const EdgeInsets.all(3),
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: 1,
        crossAxisCount: perItem,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: List<Widget>.generate(
          chapterCount,
          (index) => chapterButton(index + 1),
        ),
      ),
    );
    // return GridView.count(
    //   padding: EdgeInsets.zero,
    //   mainAxisSpacing: 0,
    //   crossAxisSpacing: 0,
    //   childAspectRatio: 1,
    //   crossAxisCount: perItem,
    //   physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    //   children: List<Widget>.generate(
    //     chapterCount,
    //     (index) => chapterButton(index + 1),
    //   ),
    // );
  }

  Widget chapterButton(int index) {
    // bool isCurrentChapter = false;
    // bool isCurrentChapter = core.collection.chapterId == index;
    // bool isCurrentChapter = chapter.id == index;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: WidgetButton(
        // minSize: 55,
        // borderRadius: BorderRadius.all(Radius.circular(2.0)),
        padding: EdgeInsets.zero,
        // color: Theme.of(context).scaffoldBackgroundColor,
        child: Text(
          '$index',
          // scripture.digit(index),
          // style: TextStyle(
          //   color: isCurrentChapter ? null : Theme.of(context).highlightColor,
          //   // fontSize:19
          // ),
        ),
        onPressed: () => Navigator.pop<int>(context, index),
      ),
    );
  }
}
