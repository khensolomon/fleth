part of 'main.dart';

mixin _Bar on _State {
  Widget bar() {
    return SliverLayoutBuilder(
      builder: (BuildContext context, constraints) {
        final innerBoxIsScrolled = constraints.scrollOffset > 0;
        return SliverAppBar(
          pinned: true,
          floating: false,
          // snap: false,
          centerTitle: true,
          elevation: 0.2,
          forceElevated: innerBoxIsScrolled,
          title: WidgetAppbarTitle(
            label: preference.text.setting(true),
          ),
          // expandedHeight: 120,
          backgroundColor: innerBoxIsScrolled
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          // backgroundColor: Theme.of(context).primaryColor,
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(3, 2)),
          ),
          automaticallyImplyLeading: false,
          leading: WidgetButton(
            onPressed: null,
            child: WidgetMark(
              icon: Icons.arrow_back_ios_new_rounded,
              label: preference.text.back,
            ),
          ),

          actions: [
            IconButton(
              icon: const Icon(Icons.accessibility),
              onPressed: () => false,
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => false,
            ),
            // WidgetButton(
            //   child: const Icon(Icons.restore),
            //   // child: Icon(LideaIcon.history),
            //   onPressed: () async {
            //     // await InAppPurchase.instance.restorePurchases().whenComplete(() =>setState);
            //     // core.store.doRestore().whenComplete((){
            //     //    ScaffoldMessenger.of(context).showSnackBar(
            //     //     SnackBar(
            //     //       content: const Text('Restore purchase completed.'),
            //     //     ),
            //     //   );
            //     // });
            //   },
            // ),
          ],
          // flexibleSpace: LayoutBuilder(
          //   builder: (BuildContext context, BoxConstraints constraints) {
          //     double top = constraints.biggest.height;
          //     return FlexibleSpaceBar(
          //       // centerTitle: true,
          //       titlePadding: EdgeInsets.symmetric(vertical:10,horizontal:20),
          //       title: AnimatedOpacity(
          //         duration: Duration(milliseconds: 200),
          //         // opacity: top > 71 && top < 91 ? 1.0 : 0.0,
          //         opacity: top < 120 ? 0.0 : 1.0,
          //         child: Text(
          //           'Recent searches',
          //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          //         )
          //       ),
          //       // background: Image.network(
          //       //   "https://images.ctfassets.net/pjshm78m9jt4/383122_header/d79a41045d07d114941f7641c83eea6d/importedImage383122_header",
          //       //   fit: BoxFit.cover,
          //       // )
          //     );
          //   }
          // ),
          // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(56.0),
          //   // child: Text('a'),
          //   child: Container(
          //     padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
          //     height: 20.0,
          //     alignment: Alignment.center,
          //     width: double.infinity,
          //     child: Text('Recent searches'),
          //   ),
          // ),
        );
      },
    );
  }
}
