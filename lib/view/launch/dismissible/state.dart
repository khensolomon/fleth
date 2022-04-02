part of 'main.dart';

abstract class _State extends WidgetState {
  late final args = argumentsAs<ViewNavigationArguments>();
  late final reorderableKey = GlobalKey<SliverReorderableListState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onDelete(int index) {
    setState(() {
      itemList.removeAt(index);
    });
  }

  final List<String> itemList = List<String>.generate(20, (i) => "Item ${i + 1}");
}
