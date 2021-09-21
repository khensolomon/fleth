
part of 'main.dart';

class CoreNotifier extends Notify with _CoreNotifiable {
  double? _progressPercentage;
  double? get progressPercentage => _progressPercentage;
  set progressPercentage(double? value) => notifyIf<double?>(_progressPercentage, _progressPercentage = value);

  String _message = 'Initializing';
  String get message => _message;
  set message(String value) => notifyIf<String>(_message, _message = value);

  bool _nodeFocus = false;
  bool get nodeFocus => _nodeFocus;
  set nodeFocus(bool value) => notifyIf<bool>(_nodeFocus, _nodeFocus = value);

  // String _suggestQuery = '';
  // String get suggestQuery => _suggestQuery;
  // set suggestQuery(String value) => notifyIf<String>(_suggestQuery, _suggestQuery = value);

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  set searchQuery(String value) => notifyIf<String>(_searchQuery, _searchQuery = value);
}

mixin _CoreNotifiable{}