part of "main.dart";

class Collection extends ClusterDocket {
  late Box<FavoriteType> boxOfFavorite;

  // retrieve the instance through the app
  Collection.internal();

  @override
  Future<void> ensureInitialized() async {
    await super.ensureInitialized();
    Hive.registerAdapter(FavoriteAdapter());
  }

  @override
  Future<void> prepareInitialized() async {
    await super.prepareInitialized();
    boxOfFavorite = await Hive.openBox<FavoriteType>('favorite');
  }

  // NOTE: Favorite
  /// get all favorite favoriteEntries
  Iterable<MapEntry<dynamic, FavoriteType>> get favorites {
    return boxOfFavorite.toMap().entries;
  }

  /// favorite is EXIST by word
  MapEntry<dynamic, FavoriteType> favoriteExist(String ord) {
    return favorites.firstWhere(
      (e) => stringCompare(e.value.word, ord),
      orElse: () => MapEntry(null, FavoriteType(word: ord)),
    );
  }

  /// favorite UPDATE on exist, if not INSERT
  bool favoriteUpdate(String ord) {
    if (ord.isNotEmpty) {
      final ob = favoriteExist(ord);
      ob.value.date = DateTime.now();
      if (ob.key == null) {
        boxOfFavorite.add(ob.value);
      } else {
        boxOfFavorite.put(ob.key, ob.value);
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
        boxOfFavorite.delete(ob.key);
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
