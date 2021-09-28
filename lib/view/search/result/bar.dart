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
                tag: 'appbar-left',
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
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 11),
                child: Hero(
                  tag: 'searchHero',
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
                              prefixIcon: const Icon(ZaideihIcon.find, size: 17),
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
            Align(
              child: Hero(
                tag: 'appbar-right',
                child: canPop
                    ? CupertinoButton(
                        padding: const EdgeInsets.only(right: 10),
                        onPressed: () => parent.navigator.currentState!.maybePop(),
                        child: const WidgetLabel(icon: CupertinoIcons.home),
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        );
      },
    );
  }
}
