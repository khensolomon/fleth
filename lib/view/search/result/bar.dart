part of 'main.dart';

mixin _Bar on _State {
  Widget bar() {
    return ViewHeaderSliverSnap(
      pinned: true,
      floating: false,
      reservedPadding: MediaQuery.of(context).padding.top,
      heights: const [kBottomNavigationBarHeight],
      overlapsBackgroundColor: Theme.of(context).primaryColor,
      overlapsBorderColor: Theme.of(context).shadowColor,
      overlapsForce: true,
      builder: (BuildContext context, ViewHeaderData org, ViewHeaderData snap) {
        return Row(
          children: [
            const Align(
              child: Hero(
                tag: 'appbar-left-0',
                child: SizedBox(),
              ),
            ),
            const Align(
              child: Hero(
                tag: 'appbar-title',
                child: SizedBox(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 11),
                child: Hero(
                  tag: 'searchHero-0',
                  child: GestureDetector(
                    child: Material(
                      type: MaterialType.transparency,
                      child: MediaQuery(
                        data: MediaQuery.of(context),
                        child: Selector<Core, String>(
                          selector: (BuildContext _, Core e) => e.collection.searchQuery,
                          builder: (BuildContext _, String initialValue, Widget? child) =>
                              TextFormField(
                            readOnly: true,
                            enabled: false,
                            initialValue: initialValue,
                            decoration: InputDecoration(
                              hintText: translate.aWordOrTwo,
                              prefixIcon: const Icon(LideaIcon.find, size: 17),
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor!
                                  .withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      // core.navigate(to: '/search');
                      final word = await navigator.currentState!.pushNamed('/suggest');
                      onSearch(word as bool);
                    },
                  ),
                ),
              ),
            ),
            Hero(
              tag: 'appbar-right-0',
              child: canPop
                  ? CupertinoButton(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      // padding: EdgeInsets.zero,
                      onPressed: () => parent.navigator!.currentState!.maybePop(),
                      child: const WidgetLabel(icon: CupertinoIcons.home),
                      // child: const Icon(CupertinoIcons.home),
                    )
                  : const SizedBox(),
            ),
          ],
        );
      },
    );
  }
}
