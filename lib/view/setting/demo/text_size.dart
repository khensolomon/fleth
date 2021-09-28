import 'package:flutter/material.dart';
import 'package:fleth/settings.dart';

class DemoTextSize extends StatelessWidget {
  const DemoTextSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 10, bottom: 10),
            child: Text('Font size and color'),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                children: [
                  Text(
                    translate.headline + ' 1',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    translate.headline + ' 2',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    translate.headline + ' 3',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    translate.headline + ' 4',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    translate.headline + ' 5',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    translate.headline + ' 6',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    translate.subtitle + ' 1',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    translate.subtitle + ' 2',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    translate.text + ' 1',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    translate.text + ' 2',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    translate.caption,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    translate.button,
                    style: Theme.of(context).textTheme.button,
                  ),
                  Text(
                    translate.overline,
                    style: Theme.of(context).textTheme.overline,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
