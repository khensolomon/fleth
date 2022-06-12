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
      primary: Positioned(
        top: 15.5,
        child: WidgetAppbarTitle(
          label: preference.text.album(true),
        ),
      ),
      rightAction: [
        WidgetButton(
          message: preference.text.filter(false),
          onPressed: showFilter,
          child: const WidgetMark(
            icon: Icons.tune_rounded,
          ),
        )
      ],
      secondary: Align(
        alignment: const Alignment(0, .7),
        child: Opacity(
          opacity: org.snapShrink,
          child: SizedBox(
            height: org.snapHeight,
            width: double.infinity,
            child: _barOptional(org.snapShrink),
          ),
        ),
      ),
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
              text: 'Selected ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 18 * stretch,
                  ),
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
