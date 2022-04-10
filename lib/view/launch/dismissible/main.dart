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

  static const route = '/dismissible';
  static const icon = Icons.delete_sweep;
  static const name = 'Dismissible';
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
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return listContainer(index, itemList.elementAt(index));
          },
          childCount: itemList.length,
        ),
      ),
    ];
  }

  Widget listContainer(int index, String item) {
    return Dismissible(
      key: Key(item),
      direction: DismissDirection.endToStart,
      // onDismissed: (direction) async {
      //   onDelete(index);
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$item dismissed')));
      // },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final bool? confirmation = await doConfirmWithDialog(
            context: context,
            message: 'Do you want to delete Index: "$index"?',
          );
          if (confirmation != null && confirmation) {
            onDelete(index);
            return true;
          }
        }
        return false;
      },
      // Show a red background as the item is swiped away.
      background: _listDismissibleBackground(),
      child: ListTile(
        leading: Text('$index'),
        title: Text(item),
      ),
    );
  }

  Widget _listDismissibleBackground() {
    return Container(
      color: Theme.of(context).disabledColor,
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          preference.text.delete,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
