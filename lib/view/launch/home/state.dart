part of 'main.dart';

abstract class _State extends WidgetState with TickerProviderStateMixin {
  late final args = argumentsAs<ViewNavigationArguments>();

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  );
  @override
  void initState() {
    // late final tmp = context.read<PreferenceTest>();
    // debugPrint('??? aMoment ${asdf.language('abc')}');
    // debugPrint('??? aMoment ${tmp.text.aMoment}');
    debugPrint('??? aMoment ${preference.text.aMoment}');

    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // _scrollController.addListener(() {
      //   print('scrolling');
      // });
      // _scrollController.position.isScrollingNotifier.dispose();

      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          // if (_animationController.isDismissed && snap.shrink == 1.0) {
          //   _animationController.forward();
          // } else if (_animationController.isCompleted && snap.shrink < 1.0) {
          //   _animationController.reverse(from: snap.shrink);
          // }
          final userScrollIndex = scrollController.position.userScrollDirection.index;
          // final userScrollName = _scrollController.position.userScrollDirection.name;
          if (userScrollIndex == 1 && _animationController.value < 1.0) {
            _animationController.forward(from: _animationController.value);
          } else if (userScrollIndex == 2 && _animationController.value > 0.0) {
            _animationController.reverse(from: _animationController.value);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onClearAll() {
    Future.microtask(() {});
  }

  void onSearch(String ord) {
    suggestQuery = ord;
    searchQuery = suggestQuery;

    Future.microtask(() {
      core.conclusionGenerate();
    });
    core.navigate(to: '/search-result');
  }

  void testing() async {
    // final persons = core.collection.boxOfPerson;
    // // persons.clear();
    // var mario = Person(name: 'Mario');
    // var luna = Person(name: 'Luna');
    // var alex = Person(name: 'Alex');
    // var khen = Person(name: 'Khen');
    // persons.addAll([mario, luna, alex, khen]);

    // mario.friends = HiveList(persons); // Create a HiveList
    // mario.friends?.addAll([luna, alex]); // Update Mario's friends
    // await mario.save(); // make persistent the change,
    // debugPrint('mario ${mario.friends}');

    // await luna.delete(); // Remove Luna from Hive
    // debugPrint('mario ${mario.friends}');
    // debugPrint('khen ${khen.friends}');

    // // if (mario.isInBox) {
    // //   mario.friends?.add(Person(name: 'one'));
    // //   mario.friends?.add(Person(name: 'two'));
    // //   mario.save();
    // // } else {
    // //   persons.addAll([Person(name: 'one'), Person(name: 'two')]);
    // // }

    // // final asdf = persons.put('44', Person(name: 'one'));
    // // final single = persons.get('44');
    // // single.box.
    // // persons.toMap().entries;
    // // persons.listenable
    // // persons.put(key, value)
    // debugPrint('all ${persons.values}');

    // persons.clear();

    // ValueListenableBuilder(
    //   valueListenable: persons.listenable(),
    //   builder: (context, Box<Person> box, _) {
    //     return Text(box.toString());
    //   },
    // );

    // final ValueListenable<Box<VerseSelection>> fesfe = persons.listenable;
    // final asfasss = persons.l
  }

  // void onDelete(String word) {
  //   Future.delayed(Duration.zero, () {});
  // }

  // bool get canPop => Navigator.of(context).canPop();
}
