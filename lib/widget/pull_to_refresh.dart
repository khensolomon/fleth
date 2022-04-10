part of ui.widget;

// PullToAny(
//   onUpdate: Future.value(),
// );
// const PullToRefresh();

// class PullToRefresh extends PullToAny {
//   const PullToRefresh({
//     Key? key,
//     Future<void> Function()? onUpdate,
//   }) : super(key: key, onUpdate: onUpdate);
// }

class PullToRefresh extends PullToAny {
  const PullToRefresh({Key? key}) : super(key: key);

  @override
  State<PullToAny> createState() => _PullToRefreshState();
}

class _PullToRefreshState extends PullOfState {
  late final Core core = context.read<Core>();

  @override
  Future<void> refreshUpdate() {
    // await Future.delayed(const Duration(milliseconds: 700));
    // throw Exception('Mocking update');
    // return Future.error('Mocking update');
    return Future.value();
  }
}
