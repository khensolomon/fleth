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
      // overlapsForce:focusNode.hasFocus,
      // overlapsForce:core.nodeFocus,
      overlapsForce: true,
      // borderRadius: Radius.elliptical(20, 5),
      builder: (BuildContext context, ViewHeaderData org, ViewHeaderData snap) {
        return Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 11),
                child: Hero(
                  tag: 'searchHero-0',
                  child: Material(
                    type: MaterialType.transparency,
                    // child: _barForm()
                    child: MediaQuery(
                      data: MediaQuery.of(context),
                      child: _barForm(),
                    ),
                  ),
                ),
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.only(right: 15),
              child: Hero(
                tag: 'appbar-right-0',
                child: Material(
                  type: MaterialType.transparency,
                  child: WidgetLabel(
                    label: translate.cancel,
                  ),
                ),
              ),
              onPressed: onCancel,
            ),
          ],
        );
      },
    );
  }

  Widget _barForm() {
    return TextFormField(
      key: formKey,
      controller: textController,
      focusNode: focusNode,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      onChanged: onSuggest,
      onFieldSubmitted: onSearch,
      // autofocus: true,
      // enabled: true,
      // enableInteractiveSelection: true,
      // enableSuggestions: true,
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: const Icon(LideaIcon.find, size: 17),
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: clearAnimation,
              // axis: Axis.horizontal,
              // axisAlignment: 1,
              child: Semantics(
                enabled: true,
                label: translate.clear,
                child: CupertinoButton(
                  onPressed: onClear,
                  padding: const EdgeInsets.all(0),
                  child: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.4),
                    size: 17,
                    semanticLabel: "input",
                  ),
                ),
              ),
            ),
            // SizeTransition(
            //   sizeFactor: clearAnimation,
            //   axis: Axis.horizontal,
            //   // axisAlignment: 1,
            //   child: Semantics(
            //     enabled: true,
            //     label: translate.clear,
            //     child: CupertinoButton(
            //       onPressed: onClear,
            //       padding: const EdgeInsets.all(0),
            //       child: Icon(
            //         CupertinoIcons.xmark_circle_fill,
            //         color: Theme.of(context).iconTheme.color!.withOpacity(0.4),
            //         size: 17,
            //         semanticLabel: "input",
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        hintText: translate.aWordOrTwo,
        fillColor: Theme.of(context)
            .inputDecorationTheme
            .fillColor!
            .withOpacity(focusNode.hasFocus ? 0.6 : 0.4),
      ),
    );
  }
}