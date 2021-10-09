part of 'main.dart';

mixin _Configuration {
  final Collection collection = Collection.internal();
  // final Authentication authentication;
  // late Authentication authentication;
  late void Function({int at, String? to, Object? args, bool routePush}) navigate;

  late Store store;

  // late SQLite _sql;
  // late Audio audio;

  List<String> artistFilterCharList = [];
  List<int> artistFilterLangList = [];

  List<String> albumFilterCharList = [];
  List<int> albumFilterLangList = [];
  List<int> albumFilterGenreList = [];
}
