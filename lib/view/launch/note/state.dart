part of 'main.dart';

abstract class _State extends WidgetState with SingleTickerProviderStateMixin {
  late final args = argumentsAs<ViewNavigationArguments>();
  late final reorderableKey = GlobalKey<SliverReorderableListState>();

  late final AnimationController dragController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<double> dragAnimation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(dragController);
  late final Animation<Color?> colorAnimation = ColorTween(
    begin: null,
    end: Theme.of(context).highlightColor,
  ).animate(dragController);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    dragController.dispose();
    super.dispose();
  }

  void onSort() {
    debugPrint('sorting');
    // if ()
    // dragController.forward()
    if (dragController.isCompleted) {
      dragController.reverse();
    } else {
      dragController.forward();
    }
  }

  final List<String> itemList = List<String>.generate(20, (i) => "Item ${i + 1}");
}
