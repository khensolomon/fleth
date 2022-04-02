part of 'main.dart';

class PopBookList extends StatefulWidget {
  final RenderBox render;

  const PopBookList({
    Key? key,
    required this.render,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopBookListState();
}

class _PopBookListState extends State<PopBookList> {
  final double arrowWidth = 10;
  final double arrowHeight = 12;

  // late final Core core = context.read<Core>();
  late final Size mediaSize = MediaQuery.of(context).size;

  late final Size widgetSize = widget.render.size;
  late final Offset widgetPosition = widget.render.localToGlobal(Offset.zero);

  late final double bottomOfWidget = widgetPosition.dy + widgetSize.height + arrowHeight;

  List<Map<String, int>> get books => [
        {'first': 50},
        {'second': 3},
        {'first': 4},
        {'second': 3},
        {'first': 25},
        {'second': 3},
        {'first': 150},
        {'second': 3},
        {'first': 4},
        {'second': 3},
        {'first': 40},
        {'second': 3},
        {'first': 4},
        {'second': 60},
        {'second': 3},
        {'first': 40},
        {'second': 3},
        {'first': 4},
        {'second': 60},
        {'second': 3},
        {'first': 40},
        {'second': 3},
        {'first': 4},
        {'second': 60},
        {'second': 3},
        {'first': 40},
        {'second': 3},
        {'first': 4},
        {'second': 60},
        {'second': 3},
        {'first': 40},
        {'second': 3},
        {'first': 4},
        {'second': 60},
        {'second': 3},
        {'first': 40},
        {'second': 3},
        {'first': 4},
        {'second': 60},
        {'second': 3},
        {'first': 40},
        {'second': 3},
        {'first': 4},
        {'second': 60},
        {'second': 3},
        {'first': 40},
        {'second': 3},
        {'first': 4},
        {'second': 60},
      ];
  final List<int> expandedList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetPopupShapedArrow(
      left: 20,
      right: 20,
      height: mediaSize.height,
      top: bottomOfWidget,
      arrow: widgetPosition.dx + (widgetSize.width * 0.5) - 27,
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
      child: ListView.separated(
        padding: const EdgeInsets.all(0),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        separatorBuilder: (BuildContext _, int index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              height: 0,
            ),
          );
        },
        itemBuilder: (BuildContext _, int index) {
          return bookItem(index, books[index]);
        },
        itemCount: books.length,
      ),
    );
  }

  Widget bookItem(int index, Map<String, int> book) {
    // bool isCurrentBook = core.collection.bookId == book.id;
    // int bookId = index+1;
    bool isExpanded = expandedList.where((e) => e == index).isNotEmpty;
    return ExpansionPanelList(
      animationDuration: Duration(milliseconds: isExpanded ? 500 : 200),
      dividerColor: Colors.red,
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      children: [
        ExpansionPanel(
          body: chapterList(isExpanded, book),
          backgroundColor: Colors.transparent,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return CupertinoButton(
              // color: Colors.blue,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                // book.name,
                book.entries.first.key,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
              onPressed: () {
                // Navigator.pop<Map<String?, int?>>(context, {'book': book.id});
                Navigator.pop<Map<String?, int?>>(context, {'book': 1});
              },
            );
          },
          isExpanded: isExpanded,
        )
      ],
      expansionCallback: (int item, bool status) {
        // final abc = expandedList.where((e) => e == index).length;
        if (status) {
          expandedList.remove(index);
        } else {
          expandedList.add(index);
        }
        setState(() {
          // itemData[index].expanded = !itemData[index].expanded;
        });
      },
    );
  }

  Widget chapterList(bool isExpanded, Map<String, int> book) {
    if (!isExpanded) return const SizedBox();
    // List<Widget> abc = isExpanded == false
    //     ? []
    //     : List<Widget>.generate(book.entries.first.value, (index) => chapterButton(1, index + 1));

    return LayoutBuilder(
      builder: (_, constraints) {
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 2.0,
          runSpacing: 2.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          // textDirection: TextDirection.ltr,
          children: List<Widget>.generate(
            book.entries.first.value,
            (index) => chapterButton(1, index + 1),
          ),
        );
      },
    );
  }

  Widget chapterButton(int bookId, int chapterId) {
    // bool isCurrentChapter = 2 == index;
    return CupertinoButton(
      minSize: 55,
      borderRadius: const BorderRadius.all(Radius.circular(2.0)),
      padding: const EdgeInsets.all(5),
      child: Text(
          // scripture.digit(chapterId),
          '$chapterId'),
      onPressed: () {
        Navigator.pop<Map<String?, int?>>(context, {'book': bookId, 'chapter': chapterId});
      },
    );
  }
}
