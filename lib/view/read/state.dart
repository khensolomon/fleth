part of 'main.dart';

abstract class _State extends WidgetState {
  late final args = argumentsAs<ViewNavigationArguments>();

  // final keySheet = GlobalKey();
  final kBookButton = GlobalKey();
  final kChapterButton = GlobalKey();
  final kOptionButton = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setFontSize(bool increase) {
    // double size = collection.fontSize.asDouble;
    double size = collection.boxOfSettings.fontSize().asDouble;
    if (increase) {
      size++;
    } else {
      size--;
    }
    // setState is not required anymore
    setState(() {
      // collection.fontSize = size.clamp(10.0, 40.0);
      collection.boxOfSettings.fontSize(value: size.clamp(10.0, 40.0));
    });
  }

  void setBookMark() {
    scrollToIndex(5);
  }

  void scrollToPosition(double? pos) {
    pos ??= scrollController.position.minScrollExtent;
    scrollController.animateTo(pos,
        duration: const Duration(milliseconds: 700), curve: Curves.ease);
  }

  Future scrollToIndex(int id, {bool isId = false}) async {
    double scrollTo = 0.0;
    if (id > 0) {
      final offsetList = tmpverse.where(
          // (e) => tmpverse.indexOf(e) < index
          (e) => tmpverse.indexOf(e) < id).map<double>((e) {
        final key = e.keys.first;
        if (key.currentContext != null) {
          final render = key.currentContext!.findRenderObject() as RenderBox;
          return render.size.height;
        }
        return 0.0;
      });
      if (offsetList.isNotEmpty) {
        scrollTo = offsetList.reduce((a, b) => a + b) + scrollTo;
      }
    }

    scrollToPosition(scrollTo);
  }

  late final List<Map<GlobalKey, String>> tmpverse = List.generate(10, (index) {
    return {GlobalKey(): '??? $index'};
  });
}
