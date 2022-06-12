part of 'main.dart';

mixin _Bar on _State {
  Widget bar(BuildContext context, ViewHeaderData org) {
    return ViewHeaderLayoutStack(
      leftAction: [
        WidgetButton(
          show: hasArguments,
          onPressed: args?.currentState!.maybePop,
          child: WidgetMark(
            icon: Icons.arrow_back_ios_new_rounded,
            label: preference.text.back,
          ),
        ),
      ],
      primary: WidgetAppbarTitle(
        alignment: Alignment.lerp(
          const Alignment(0, 0),
          const Alignment(0, .5),
          org.snapShrink,
        ),
        label: 'Note',
        shrink: org.shrink,
      ),
      rightAction: [
        WidgetButton(
          onPressed: onSort,
          child: AnimatedBuilder(
            animation: dragController,
            builder: (context, _) {
              return WidgetMark(
                icon: Icons.sort,
                iconColor: colorAnimation.value,
              );
            },
          ),
        )
      ],
    );
  }
}
