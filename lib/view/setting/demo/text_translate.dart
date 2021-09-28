import 'package:fleth/settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DemoTextTranslate extends StatefulWidget {
  const DemoTextTranslate({Key? key}) : super(key: key);

  @override
  _DemoTextTranslateState createState() => _DemoTextTranslateState();
}

class _DemoTextTranslateState extends State<DemoTextTranslate> {
  AppLocalizations get translate => AppLocalizations.of(context)!;
  Locale get locale => Localizations.localeOf(context);
  // String get localeName => locale.countryCode;
  String get localeName => translate.localeName;
  String myanmar(int i) => NumberFormat.simpleCurrency(
        locale: localeName,
        name: '',
        decimalDigits: 0,
      ).format(i);

  @override
  void initState() {
    super.initState();
    // core = context.read<Core>();
    // settings = context.read<SettingsController>();
    // settings = SettingsController.instance;
    // settings = widget.settings!;
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          const Padding(padding: EdgeInsets.all(8.0), child: Text('Number with plural')),
          _number(),
          const Divider(),
          const Padding(padding: EdgeInsets.all(8.0), child: Text('Date')),
          _date(),
          const Divider(),
          const Padding(padding: EdgeInsets.all(8.0), child: Text('Message')),
          _message(),
          const Divider(),
          const Padding(padding: EdgeInsets.all(8.0), child: Text('Percent')),
          _percent(),
          const Divider(),
          const Padding(padding: EdgeInsets.all(8.0), child: Text('Currency')),
          _currency(),
          const Divider(),
          const Padding(padding: EdgeInsets.all(8.0), child: Text('Select')),
          _select(),
          const Divider(),
          const Padding(padding: EdgeInsets.all(8.0), child: Text('twoArgs')),
          _twoArgs(),
        ],
      ),
    );
  }

  Widget _number() {
    return Column(
      children: [
        Text(translate.itemCount(0)),
        Text(translate.itemCount(1)),
        Text(translate.itemCount(2)),
        Text(translate.itemCount(18)),
        Text(translate.itemCount(120)),
        Text(translate.itemCount(2503)),
        Text(translate.itemCount(25030000)),
        Text(translate.itemCountNumber(0, myanmar(0))),
        Text(translate.itemCountNumber(1, myanmar(1))),
        Text(translate.itemCountNumber(10, myanmar(10))),
        Text(translate.itemCountNumber(101, myanmar(101))),
        Text(translate.itemCountNumber(10888, myanmar(10888))),
      ],
    );
  }

  Widget _date() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'formatDate = ',
            style: Theme.of(context).textTheme.bodyText2,
            children: [
              TextSpan(
                text: translate.formatDate(
                  DateFormat('d MMMM yyyy').parse('8 July 1981'),
                ),
                children: const [
                  TextSpan(text: '\nd MMMM yyyy'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _message() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'areYouSureTo = ',
            style: Theme.of(context).textTheme.bodyText2,
            children: [
              TextSpan(
                text: translate.confirmToDelete('all'),
              ),
              TextSpan(
                text: translate.confirmToDelete('this'),
              ),
              TextSpan(
                text: translate.confirmToDelete('none'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _percent() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '*.percentPattern = ',
            style: Theme.of(context).textTheme.bodyText2,
            children: [
              TextSpan(
                text: NumberFormat.percentPattern(locale.languageCode).format(60.23),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _currency() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '*.compact = ',
            style: Theme.of(context).textTheme.bodyText2,
            children: [
              TextSpan(
                text: NumberFormat.compact(locale: localeName).format(12345678),
              ),
            ],
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '*.simpleCurrency = ',
            style: Theme.of(context).textTheme.bodyText2,
            children: [
              TextSpan(
                text: NumberFormat.simpleCurrency(locale: localeName).format(12345678),
              ),
            ],
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '*.currency = ',
            style: Theme.of(context).textTheme.bodyText2,
            children: [
              TextSpan(
                text: NumberFormat.currency(locale: localeName).format(12345678),
              ),
            ],
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'formatCurrency = ',
            style: Theme.of(context).textTheme.bodyText2,
            children: [
              TextSpan(
                text: translate.formatCurrency(12345),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _select() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'mockSelect = ',
            style: Theme.of(context).textTheme.bodyText2,
            children: [
              TextSpan(
                text: translate.mockSelect('male'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _twoArgs() {
    return Column(
      children: [
        Text(translate.twoArgs('first', 'second')),
      ],
    );
  }
}
