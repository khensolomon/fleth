part of 'main.dart';

mixin _Result on _State {
  Widget result() {
    debugPrint('result');
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: [
        Text('result: $searchQueryCurrent'),
        resultListView(),
      ],
    );
  }

  Widget resultListView() {
    SizedBox(
      height: 50,
      child: Row(
        children: const [
          Text('asdfs'),
          Text('asdfs'),
        ],
      ),
    );
    SizedBox(
      height: 50,
      child: Row(
        children: const [
          Text('a'),
          Text('b'),
          Text('a'),
        ],
      ),
    );

    return ListView.builder(
      itemCount: 25,
      primary: false,
      shrinkWrap: true,
      addAutomaticKeepAlives: false,
      // separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        // final delayedMilliseconds = 320 * (index % 10 + 1);
        const delayedMs = 320;
        return FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: delayedMs), () => true),
          builder: (_, snap) {
            if (snap.hasData == false) {
              return const SizedBox(
                height: 50,
              );
            }
            return ListTile(
              title: Text('item index: $index ms: $delayedMs'),
            );
          },
        );
      },
    );
  }
}
