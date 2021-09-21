part of 'main.dart';

mixin _Bar on _State {
  Widget bar() {
    return ViewHeaderSliverSnap(
      pinned: true,
      floating:false,
      reservedPadding: MediaQuery.of(context).padding.top,
      heights: const [kBottomNavigationBarHeight,50],
      overlapsBackgroundColor:Theme.of(context).primaryColor,
      overlapsBorderColor:Theme.of(context).shadowColor,
      builder: (BuildContext context, ViewHeaderData org, ViewHeaderData snap){
        return Stack(
          alignment: const Alignment(0,0),
          children: [
            // This make the return "appbar-left" Hero animation smooth
            const Positioned(
              left: 0,
              top: 4,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Hero(
                  tag: 'appbar-left',
                  child: Material(
                    type: MaterialType.transparency,
                    child: WidgetLabel(),
                  ),
                ),
                onPressed: null,
              ),
            ),
            // TweenAnimationBuilder<double>(
            //   // tween: Tween<double>(begin: arguments.canPop?0:50, end: 0),
            //   tween: Tween<double>(begin: 50, end: 0),
            //   duration: const Duration(milliseconds: 300),
            //   builder: (BuildContext context, double align, Widget? child) {
            //     return Positioned(
            //       left: align,
            //       top: 4,
            //       child: (align == 0)?CupertinoButton(
            //         padding: EdgeInsets.zero,
            //         child: const Hero(
            //           tag: 'appbar-left',
            //           child: WidgetLabel( icon: CupertinoIcons.left_chevron, label: 'Back',),
            //         ),
            //         onPressed: () => false
            //       ):const Padding(
            //         padding: EdgeInsets.zero,
            //         child: WidgetLabel( icon: CupertinoIcons.left_chevron, label: 'Back',)
            //       )
            //     );
            //   },
            // ),

            Align(
              alignment: Alignment.lerp(const Alignment(0,0), const Alignment(0,.5), snap.shrink)!,
              // child: PageAttribute(label: 'Album',fontSize: (30*org.shrink).clamp(20, 30).toDouble()),
              child: Hero(
                tag: 'appbar-center',
                child: Material(
                  type: MaterialType.transparency,
                  // child: WidgetLabel(label: 'Album',fontSize: (30*org.shrink).clamp(20, 30).toDouble()),
                  child: Text(
                    translationInstance.appTitle,
                    style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: (30*org.shrink).clamp(20.0, 30.0).toDouble()),
                    maxLines: 1, overflow: TextOverflow.fade,
                  ),
                )
              ),
            ),

            Positioned(
              right: 0,
              top: 4,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Hero(
                  tag: 'appbar-right',
                  child: Material(
                    type: MaterialType.transparency,
                    child: WidgetLabel(
                      icon: ZaideihIcon.search,
                      // icon: CupertinoIcons.search,
                      // icon: Icons.search,
                    ),
                  ),
                ),
                onPressed: () => core.navigate(to: '/search'),
              )
            ),
          ]
        );
      }
    );
  }
}