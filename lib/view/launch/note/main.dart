import 'package:flutter/material.dart';

// import 'package:lidea/hive.dart';
// import 'package:lidea/provider.dart';
// import 'package:lidea/intl.dart';
import 'package:lidea/view/main.dart';
// import 'package:lidea/icon.dart';

// import '/core/main.dart';
// import '/type/main.dart';
import '/widget/main.dart';

part 'bar.dart';
part 'state.dart';

class Main extends StatefulWidget {
  const Main({Key? key, this.arguments}) : super(key: key);

  final Object? arguments;

  static const route = '/note';
  static const icon = Icons.loyalty;
  static const name = 'Note';
  static const description = '...';
  static final uniqueKey = UniqueKey();

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
        heights: const [kToolbarHeight, 50],
        overlapsBackgroundColor: Theme.of(context).primaryColor,
        overlapsBorderColor: Theme.of(context).shadowColor,
        builder: bar,
      ),
      SliverReorderableList(
        key: reorderableKey,
        itemBuilder: (BuildContext _, int i) => listContainer(i, itemList.elementAt(i)),
        itemCount: itemList.length,
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          if (oldIndex == newIndex) return;

          final String item = itemList.removeAt(oldIndex);
          itemList.insert(newIndex, item);

          // NOTE: hiveDB
          // final itemList = box.toMap().values.toList();
          // itemList.insert(newIndex, itemList.removeAt(oldIndex));
          // box.putAll(itemList.asMap());
        },
      ),
    ];
  }

  Widget listContainer(int index, String item) {
    // return ListTile(
    //   key: Key('$index'),
    //   title: Text(item),
    //   leading: Text('$index'),
    //   trailing: dragHandler(index),
    // );
    return SwipeForMore(
      key: Key('$index'),
      menu: <Widget>[
        Container(
          color: Colors.black26,
          child: const IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: null,
          ),
        ),
        Container(
          color: Colors.red,
          child: const IconButton(
            icon: Icon(Icons.access_alarms_rounded),
            onPressed: null,
          ),
        ),
      ],
      child: ListTile(
        title: Text(item),
        leading: Text('$index'),
        trailing: dragHandler(index),
      ),
    );
  }

  Widget dragHandler(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizeTransition(
          sizeFactor: dragAnimation,
          axisAlignment: 0.5,
          child: ReorderableDragStartListener(
            index: index,
            child: Icon(
              Icons.drag_handle_rounded,
              color: Theme.of(context).highlightColor,
            ),
          ),
        ),
      ],
    );
  }
}

class SwipeForMore extends StatefulWidget {
  const SwipeForMore({
    Key? key,
    required this.child,
    required this.menu,
    this.dx = 0.2,
  }) : super(key: key);

  final Widget child;
  final List<Widget> menu;
  final double dx;

  @override
  SwipeForMoreState createState() => SwipeForMoreState();
}

class SwipeForMoreState extends State<SwipeForMore> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final offset = Tween(
    begin: const Offset(0.0, 0.0),
    end: Offset(-(widget.dx * widget.menu.length), 0.0),
  ).animate(
    CurveTween(curve: Curves.linear).animate(controller),
  );

  late final double = Tween(
    begin: 0.7,
    end: 1.0,
  ).animate(CurveTween(curve: Curves.easeIn).animate(controller));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (data) {
        controller.value -= (data.primaryDelta! / context.size!.width / 0.3);
      },
      onHorizontalDragEnd: (data) {
        if (data.primaryVelocity! > 2500) {
          controller.animateTo(.0, duration: const Duration(milliseconds: 200));
        } else if (controller.value >= .3 || data.primaryVelocity! < -2500) {
          controller.animateTo(1.0, duration: const Duration(milliseconds: 200));
        } else {
          controller.animateTo(.0, duration: const Duration(milliseconds: 200));
        }
      },
      onLongPress: () {
        if (controller.isCompleted) {
          controller.reverse();
        } else if (controller.isDismissed) {
          controller.forward();
        }
      },
      child: Stack(
        children: <Widget>[
          SlideTransition(position: offset, child: widget.child),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Stack(
                      alignment: const Alignment(0, 0),
                      children: <Widget>[
                        Positioned(
                          right: .0,
                          top: .0,
                          bottom: .0,
                          width: constraint.maxWidth * offset.value.dx * -1,
                          child: SizedBox(
                            // color: Colors.black26,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: widget.menu.map((item) {
                                return Expanded(
                                  child: FadeTransition(opacity: double, child: item),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
