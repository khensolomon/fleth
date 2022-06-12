part of ui.widget;

// PullToActivate(
//   onUpdate: Future.value(),
// );
// const PullToRefresh();

// class PullToRefresh extends PullToActivate {
//   const PullToRefresh({
//     Key? key,
//     Future<void> Function()? onUpdate,
//   }) : super(key: key, onUpdate: onUpdate);
// }

class PullToRefresh extends PullToActivate {
  const PullToRefresh({Key? key}) : super(key: key);

  @override
  State<PullToActivate> createState() => _PullToRefreshState();
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
