part of 'main.dart';

mixin _Bar on _State {
  Widget bar() {
    return ViewHeaderSliverSnap(
      pinned: true,
      floating: false,
      reservedPadding: MediaQuery.of(context).padding.top,
      heights: const [kBottomNavigationBarHeight, 50],
      overlapsBackgroundColor: Theme.of(context).primaryColor,
      overlapsBorderColor: Theme.of(context).shadowColor,
      builder: (BuildContext context, ViewHeaderData org, ViewHeaderData snap) {
        return Stack(
          alignment: const Alignment(0, 0),
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
              alignment: Alignment.lerp(
                const Alignment(0, 0),
                const Alignment(0, .5),
                snap.shrink,
              )!,
              // child: PageAttribute(label: 'Album',fontSize: (30*org.shrink).clamp(20, 30).toDouble()),
              child: Hero(
                tag: 'appbar-center',
                child: Material(
                  type: MaterialType.transparency,
                  // child: WidgetLabel(label: 'Album',fontSize: (30*org.shrink).clamp(20, 30).toDouble()),
                  child: Text(
                    translate.appLaiSiangtho,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: (30 * org.shrink).clamp(20.0, 30.0).toDouble()),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ),

            // Positioned(
            //   right: 0,
            //   top: 4,
            //   child: CupertinoButton(
            //     padding: EdgeInsets.zero,
            //     child: const Hero(
            //       tag: 'appbar-right',
            //       child: Material(
            //         type: MaterialType.transparency,
            //         child: WidgetLabel(
            //           icon: LideaIcon.search,
            //           // icon: CupertinoIcons.search,
            //           // icon: Icons.search,
            //         ),
            //       ),
            //     ),
            //     onPressed: () => core.navigate(to: '/search'),
            //   ),
            // ),
            Positioned(
              right: 0,
              top: 4,
              child: Hero(
                tag: 'appbar-right',
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Selector<Authentication, bool>(
                    selector: (_, e) => e.hasUser,
                    builder: (BuildContext context, bool hasUser, Widget? child) {
                      return userPhoto();
                    },
                  ),
                  onPressed: () => core.navigate(to: '/user'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget userPhoto() {
    final user = authenticate.user;
    if (user != null) {
      if (user.photoURL != null) {
        return CircleAvatar(
          radius: 15,
          child: ClipOval(
            child: Material(
              // child: Image.network(
              //   user.photoURL!,
              //   fit: BoxFit.cover,
              // ),
              child: CachedNetworkImage(
                placeholder: (context, url) {
                  return const Padding(
                    padding: EdgeInsets.all(3),
                    child: Icon(
                      Icons.face_retouching_natural_rounded,
                      size: 25,
                    ),
                  );
                },
                imageUrl: user.photoURL!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }
      return ClipOval(
        child: Material(
          elevation: 10,
          shape: CircleBorder(
            side: BorderSide(
              color: Theme.of(context).backgroundColor,
              width: .5,
            ),
          ),
          shadowColor: Theme.of(context).primaryColor,
          child: const Padding(
            padding: EdgeInsets.all(3),
            child: Icon(
              Icons.face_retouching_natural_rounded,
              size: 25,
            ),
          ),
        ),
      );
    }

    return ClipOval(
      child: Material(
        elevation: 30,
        shape: CircleBorder(
          side: BorderSide(
            color: Theme.of(context).backgroundColor,
            width: .7,
          ),
        ),
        shadowColor: Theme.of(context).primaryColor,
        child: const Padding(
          padding: EdgeInsets.all(3),
          child: Icon(
            Icons.face,
            size: 25,
          ),
        ),
      ),
    );
  }
}
