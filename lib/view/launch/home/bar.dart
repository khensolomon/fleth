part of 'main.dart';

mixin _Bar on _State {
  Widget bar(BuildContext context, ViewHeaderData org) {
    _animationController.animateTo(org.shrinkOffsetDouble(20));
    return ViewHeaderLayoutStack(
      primary: WidgetAppbarTitle(
        alignment: Alignment.lerp(
          const Alignment(0, 0),
          const Alignment(0, -.3),
          org.snapShrink,
        ),
        label: collection.env.name,
        shrink: org.shrink,
      ),
      rightAction: [
        WidgetButton(
          message: preference.text.option(true),
          onPressed: () => core.navigate(to: '/user'),
          child: WidgetMark(
            child: Selector<Authentication, bool>(
              selector: (_, e) => e.hasUser,
              builder: (BuildContext _, bool hasUser, Widget? child) {
                return UserIcon(authenticate: authenticate);
              },
            ),
          ),
        ),
      ],
      secondary: Positioned(
        right: 0,
        left: 0,
        bottom: 10,
        height: 40 * org.snapShrink,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: GestureDetector(
            child: Material(
              type: MaterialType.transparency,
              child: MediaQuery(
                data: MediaQuery.of(context),
                child: FadeTransition(
                  opacity: _animation,
                  child: SizeTransition(
                    sizeFactor: _animation,
                    child: TextFormField(
                      // initialValue: searchQuery,
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: preference.text.aWordOrTwo,
                        prefixIcon: const Icon(
                          LideaIcon.find,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              core.navigate(to: '/search');
              // args?.currentState!.pushNamed('/search');
            },
          ),
        ),
      ),
    );
  }
}
