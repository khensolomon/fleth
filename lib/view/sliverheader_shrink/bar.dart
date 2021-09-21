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
            Align(
              alignment: Alignment.lerp(const Alignment(0,0), const Alignment(0,.5), snap.shrink)!,
              // child: PageAttribute(label: 'Album',fontSize: (30*org.shrink).clamp(20, 30).toDouble()),
              child: Text(
                'Shrink',
                style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: (30*org.shrink).clamp(20, 30).toDouble()),
                maxLines: 1, overflow: TextOverflow.fade,
              ),
            ),
          ]
        );
      }
    );
  }
}