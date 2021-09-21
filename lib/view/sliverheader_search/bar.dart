part of 'main.dart';

mixin _Bar on _State {
  Widget bar() {
    return ViewHeaderSliverSnap(
      pinned: true,
      floating:false,
      reservedPadding: MediaQuery.of(context).padding.top,
      heights: const [kBottomNavigationBarHeight],
      overlapsBackgroundColor:Theme.of(context).primaryColor,
      overlapsBorderColor:Theme.of(context).shadowColor,
      // overlapsForce:focusNode.hasFocus,
      // overlapsForce:core.nodeFocus,
      overlapsForce: true,
      // borderRadius: Radius.elliptical(20, 5),
      builder: (BuildContext context, ViewHeaderData org, ViewHeaderData snap){
        return Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 11),
                child: Hero(
                  tag: 'searchHero',
                  child: Material(
                    type: MaterialType.transparency,
                    // child: _barForm()
                    child: MediaQuery(
                      data: MediaQuery.of(context),
                      child: _barForm()
                    ),
                  )
                ),
              )
            ),
            // Hero(
            //   tag: 'appbar-right',
            //   child: Material(
            //     type: MaterialType.transparency,
            //     child: Semantics(
            //     label: "Cancel",
            //       child: new CupertinoButton(
            //         onPressed: onCancel,
            //         padding: const EdgeInsets.only(left: 15),
            //         minSize: 40.0,
            //         child:const Text('Cancel Apple', maxLines: 1,)
            //       )
            //     )
            //   )
            // )
            CupertinoButton(
              padding: const EdgeInsets.only(right: 15),
              // padding: EdgeInsets.symmetric(horizontal: ),
              child: Hero(
                tag: 'appbar-right',
                child: Material(
                  type: MaterialType.transparency,
                  child: WidgetLabel(
                    label: translationInstance.cancel,
                    // icon: ZaideihIcon.search,
                  ),
                ),
              ),
              onPressed: onCancel,
            )
          ]
        );
      },
    );
  }

  Widget _barForm(){
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
      // buildCounter: Text('aaa'),
      // buildCounter:(BuildContext context, {required int currentLength, required bool isFocused, required int? maxLength}){
      //   return Text('data $isFocused');
      // },
      decoration: InputDecoration(
        // floatingLabelStyle: const TextStyle( color: Colors.red),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // label: const Text('Label'),

        prefixIcon: const Icon(
          ZaideihIcon.find,
          size: 17
        ),
        suffixIcon: Selector<Core, bool>(
          selector: (BuildContext _, Core e) => e.nodeFocus && searchQueryCurrent.isNotEmpty,
          builder: (BuildContext _, bool word, Widget? child) {
            return word?SizedBox.shrink(
              child: Semantics(
                label: translationInstance.clear,
                child: CupertinoButton(
                  onPressed: onClear,
                  padding: const EdgeInsets.all(0),
                  child:Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.4),
                    size: 17,
                    semanticLabel: "input"
                  ),
                )
              )
            ):child!;
          },
          child: const SizedBox(),
        ),

        hintText: translationInstance.aWordOrTwo,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor!.withOpacity(focusNode.hasFocus?0.6:0.4),
      )
    );
  }
}