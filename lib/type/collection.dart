part of "main.dart";

class Collection extends ClusterDocket {
  late Box<FavoriteWordType> boxOfFavoriteWord;

  SuggestionType<OfRawType> cacheSuggestion = const SuggestionType();
  ConclusionType<Map<String, dynamic>> cacheConclusion = const ConclusionType();
  // SuggestionType<Map<String, Object?>> cacheSuggestion = const SuggestionType();
  // ConclusionType<Map<String, dynamic>> cacheConclusion = const ConclusionType();

  // retrieve the instance through the app
  Collection.internal();

  @override
  Future<void> ensureInitialized() async {
    await super.ensureInitialized();
    Hive.registerAdapter(FavoriteWordAdapter());
  }

  @override
  Future<void> prepareInitialized() async {
    await super.prepareInitialized();
    boxOfFavoriteWord = await Hive.openBox<FavoriteWordType>('favorite');
  }

  // NOTE: Favorite
  /// get all favorite favoriteEntries
  Iterable<MapEntry<dynamic, FavoriteWordType>> get favorites {
    return boxOfFavoriteWord.toMap().entries;
  }

  /// favorite is EXIST by word
  MapEntry<dynamic, FavoriteWordType> favoriteExist(String ord) {
    return favorites.firstWhere(
      (e) => stringCompare(e.value.word, ord),
      orElse: () => MapEntry(null, FavoriteWordType(word: ord)),
    );
  }

  /// favorite UPDATE on exist, if not INSERT
  bool favoriteUpdate(String ord) {
    if (ord.isNotEmpty) {
      final ob = favoriteExist(ord);
      ob.value.date = DateTime.now();
      if (ob.key == null) {
        boxOfFavoriteWord.add(ob.value);
      } else {
        boxOfFavoriteWord.put(ob.key, ob.value);
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
        boxOfFavoriteWord.delete(ob.key);
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
