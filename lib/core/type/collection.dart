part of 'main.dart';

class Collection {
  late EnvironmentType env;

  late AudioBucketType cacheBucket;

  late Box<SettingType> boxOfSetting;
  late Box<PurchaseType> boxOfPurchase;
  late Box<RecentSearchType> boxOfRecentSearch;

  SuggestionType cacheSuggestion = const SuggestionType();
  ConclusionType cacheConclusion = const ConclusionType();

  // final time = watch..start(); time.elapsedMilliseconds
  // final Stopwatch watch = new Stopwatch();

  static final Collection _instance = Collection.internal();
  factory Collection() => _instance;
  Collection.internal();
  // retrieve the instance through the app
  static Collection get instance => _instance;

  SettingType get setting => boxOfSetting.get(env.settingKey, defaultValue: env.setting)!;

  Future<void> settingUpdate(SettingType? value) async {
    if (value != null) {
      boxOfSetting.put(env.settingKey, value);
    }
  }

  String get searchQuery => setting.searchQuery;

  set searchQuery(String ord) {
    if (setting.searchQuery != ord) {
      setting.searchQuery = ord;
      settingUpdate(setting);
    }
  }

  double get fontSize => setting.fontSize;
  set fontSize(double size) {
    if (setting.fontSize != size) {
      settingUpdate(setting.copyWith(fontSize: size));
    }
  }

  bool stringCompare(String? a, String b) => a!.toLowerCase() == b.toLowerCase();

  // boxOfRecentSearch addWordHistory
  // bool hasNotHistory(String ord) => this.boxOfRecentSearch.values.firstWhere((e) => stringCompare(e,ord),orElse: ()=>'') == null;
  // bool hasNotHistory(String ord) => this.boxOfRecentSearch.values.firstWhere((e) => stringCompare(e,ord),orElse: () => '')!.isEmpty;

  MapEntry<dynamic, PurchaseType> boxOfPurchaseExist(String id) {
    return boxOfPurchase.toMap().entries.firstWhere(
          (e) => stringCompare(e.value.purchaseId, id),
          orElse: () => MapEntry(null, PurchaseType()),
        );
  }

  bool boxOfPurchaseDeleteByPurchaseId(String id) {
    if (id.isNotEmpty) {
      final purchase = boxOfPurchaseExist(id);
      if (purchase.key != null) {
        // this.boxOfRecentSearch.deleteAt(history.key);
        boxOfPurchase.delete(purchase.key);
        return true;
      }
    }
    return false;
  }

  // NOTE: History
  /// get all recentSearches
  Iterable<MapEntry<dynamic, RecentSearchType>> get recentSearches {
    return boxOfRecentSearch.toMap().entries;
  }

  /// recentSearch Exist of word
  MapEntry<dynamic, RecentSearchType> recentSearchExist(String ord) {
    return recentSearches.firstWhere(
      (e) => stringCompare(e.value.word, ord),
      orElse: () => MapEntry(null, RecentSearchType(word: ord)),
    );
  }

  /// recentSearch Update item if exist, if not insert
  bool recentSearchUpdate(String ord) {
    debugPrint('recentSearchUpdate: $ord');
    if (ord.isNotEmpty) {
      final ob = recentSearchExist(ord);
      ob.value.date = DateTime.now();
      ob.value.hit++;
      if (ob.key == null) {
        boxOfRecentSearch.add(ob.value);
      } else {
        boxOfRecentSearch.put(ob.key, ob.value);
      }
      return true;
    }
    return false;
  }

  /// recentSearch Delete item by word
  bool recentSearchDelete(String ord) {
    if (ord.isNotEmpty) {
      final ob = recentSearchExist(ord);
      if (ob.key != null) {
        boxOfRecentSearch.delete(ob.key);
        return true;
      }
    }
    return false;
  }

  // Iterable<MapEntry<dynamic, RecentSearchType>> recentSearch() {
  //   if (searchQuery.isEmpty) {
  //     return recentSearches;
  //   } else {
  //     return recentSearches.where(
  //       (e) => e.value.word.toLowerCase().startsWith(searchQuery.toLowerCase()),
  //     );
  //   }
  // }

  // recentSearchClear
  // void boxOfRecentSearchClear() {
  //   boxOfRecentSearch.clear();
  // }
}
