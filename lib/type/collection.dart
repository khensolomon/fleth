part of data.type;

class Collection extends ClusterDocket {
  late final boxOfFavoriteWord = BoxOfFavoriteWord<FavoriteWordType>();

  SuggestionType<OfRawType> cacheSuggestion = const SuggestionType();
  ConclusionType<Map<String, dynamic>> cacheConclusion = const ConclusionType();
  // SuggestionType<Map<String, Object?>> cacheSuggestion = const SuggestionType();
  // ConclusionType<Map<String, dynamic>> cacheConclusion = const ConclusionType();

  // retrieve the instance through the app
  Collection.internal();
  // Collection.internal() : super.internal();

  @override
  Future<void> ensureInitialized() async {
    await super.ensureInitialized();
    boxOfFavoriteWord.registerAdapter(FavoriteWordAdapter());
    // Hive.registerAdapter(PersonAdapter());
  }

  @override
  Future<void> prepareInitialized() async {
    await super.prepareInitialized();
    await boxOfFavoriteWord.open('favorite');
    // boxOfPerson = await Hive.openBox<Person>('testpersonsWithLists');
    // boxOfVerseSelection = await Hive.openBox<VerseSelection>('testVerseSelection');
  }

  // NOTE: Favorite
  /// get all favorite favoriteEntries
  Iterable<MapEntry<dynamic, FavoriteWordType>> get favorites {
    return boxOfFavoriteWord.entries;
  }

  /// favorite is EXIST by word
  MapEntry<dynamic, FavoriteWordType> favoriteExist(String ord) {
    return favorites.firstWhere(
      (e) => UtilString.stringCompare(e.value.word, ord),
      orElse: () => MapEntry(null, FavoriteWordType(word: ord)),
    );
  }

  /// favorite UPDATE on exist, if not INSERT
  bool favoriteUpdate(String ord) {
    if (ord.isNotEmpty) {
      final ob = favoriteExist(ord);
      ob.value.date = DateTime.now();
      if (ob.key == null) {
        boxOfFavoriteWord.box.add(ob.value);
      } else {
        boxOfFavoriteWord.box.put(ob.key, ob.value);
      }
      // print('recentSearchUpdate ${ob.value.hit}');
      return true;
    }
    return false;
  }

  /// favorite DELETE by word
  bool favoriteDelete(String ord) {
    if (ord.isNotEmpty) {
      final ob = favoriteExist(ord);
      if (ob.key != null) {
        boxOfFavoriteWord.box.delete(ob.key);
        return true;
      }
    }
    return false;
  }

  /// favorite DELETE on exist, if not INSERT
  bool favoriteSwitch(String ord) {
    if (ord.isNotEmpty) {
      final ob = favoriteExist(ord);
      if (ob.key != null) {
        favoriteDelete(ord);
      } else {
        return favoriteUpdate(ord);
      }
    }
    return false;
  }
}
