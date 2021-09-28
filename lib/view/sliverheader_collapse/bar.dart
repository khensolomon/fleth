part of 'main.dart';

mixin _Bar on _State {
  Widget bar() {
    return ViewHeaderSliverSnap(
      pinned: true,
      floating: true,
      reservedPadding: MediaQuery.of(context).padding.top,
      heights: const [kBottomNavigationBarHeight, 40],
      // overlapsBackgroundColor:Theme.of(context).primaryColor.withOpacity(0.8),
      overlapsBackgroundColor: Theme.of(context).primaryColor,
      overlapsBorderColor: Theme.of(context).shadowColor,
      builder: (BuildContext context, ViewHeaderData org, ViewHeaderData snap) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: kBottomNavigationBarHeight,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    // alignment: const Alignment(0,0.2),
                    child: Text(
                      'Collapse',
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
            Opacity(
              opacity: snap.shrink,
              child: SizedBox(
                height: snap.offset,
                width: double.infinity,
                child: _barOptional(snap.shrink),
              ),
            )
          ],
        );
      },
    );
  }

  // Start with "M, C" in "Myanmar, Mizo" at "*" has (79)
  // Start with (*) in (*) at (*) matched (2074)
  // Artists (2074) begin with (*) in (*)
  // Artists (2074) begin with (*)
  Widget _barOptional(double stretch) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7 * stretch, horizontal: 0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        children: [
          RichText(
            strutStyle: StrutStyle(height: 1 * stretch),
            text: TextSpan(
              text: 'Albums ',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(height: 1.2, fontWeight: FontWeight.w400, fontSize: 18 * stretch),
              children: const [
                TextSpan(text: '(...)'),
                TextSpan(text: '...'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showFilter() {}
}
