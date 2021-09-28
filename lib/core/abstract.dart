part of 'main.dart';

abstract class _Abstract extends UtilEngine with _Configuration, _Utility {
  double? _progressPercentage;
  double? get progressPercentage => _progressPercentage;
  set progressPercentage(double? value) =>
      notifyIf<double?>(_progressPercentage, _progressPercentage = value);

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

  Future<void> ensureInitialized() async {
    Stopwatch initWatch = Stopwatch()..start();
    await Hive.initFlutter();
    Hive.registerAdapter(SettingAdapter());
    Hive.registerAdapter(PurchaseAdapter());
    Hive.registerAdapter(RecentSearchAdapter());

    collection.env = EnvironmentType.fromJSON(
      UtilDocument.decodeJSON(await UtilDocument.loadBundleAsString('env.json')),
    );

    collection.boxOfSetting = await Hive.openBox<SettingType>(collection.env.settingName);
    SettingType active = collection.setting;

    if (collection.boxOfSetting.isEmpty) {
      collection.boxOfSetting.put(collection.env.settingKey, collection.env.setting);
      await loadArchive(collection.env.bucketAPI.archive);
    } else if (active.version != collection.env.setting.version) {
      collection.boxOfSetting.put(collection.env.settingKey, active.merge(collection.env.setting));
      await loadArchive(collection.env.bucketAPI.archive);
    }

    if (collection.setting.token.isEmpty) {
      await userTokenUpdate().catchError((e) {
        debugPrint('a1 $e');
      });
    }

    if (authentication.id.isNotEmpty && authentication.id != collection.setting.userId) {
      final ou = collection.setting.copyWith(userId: authentication.id);
      await collection.settingUpdate(ou);
    }

    userGist = GistData(
      owner: collection.env.token.name,
      repo: collection.setting.repo,
      token: collection.setting.token,
      // file: '${authentication.id}.json',
    );
    debugPrint('ensureInitialized in ${initWatch.elapsedMilliseconds} ms');
  }

  Future<String> userTokenUpdate() {
    final gist = GistData(owner: collection.env.token.name, repo: collection.env.token.key);
    return gist.gitContent<String>(file: 'token.json').then((String res) {
      final oj = UtilDocument.decodeJSON<List<dynamic>>(res);
      final om = oj.map<TokenType>((e) => TokenType.fromJSON(e));
      final ob = om.where((e) => e.name == collection.env.name.toLowerCase());
      if (ob.isNotEmpty) {
        collection.settingUpdate(collection.setting.copyWith(
          token: ob.first.id,
          repo: ob.first.key,
        ));
        return 'Updated';
      }
      return '?';
    });
  }

  Future<void> initData() async {
    collection.cacheBucket = AudioBucketType.fromJSON(
      Map.fromEntries(
        await Future.wait(
          collection.env.apis.map(
            (e) async => MapEntry(e.uid, await readArchive(e.archive)),
          ),
        ),
      ),
    );

    // final album = collection.cacheBucket.album;
    // final artist = collection.cacheBucket.artist;
    // final genre = collection.cacheBucket.genre;
    // final lang = collection.cacheBucket.lang;
    // final totalTrack = album.map((e) => e.track.length).reduce((a, b) => a+b);
    // print('al ${album.length} tt $totalTrack ar ${artist.length} gr ${genre.length} lg ${lang.length}');

    collection.boxOfPurchase = await Hive.openBox<PurchaseType>('purchase-tmp');
    // collection.boxOfSetting.clear();

    collection.boxOfRecentSearch = await Hive.openBox<RecentSearchType>('recent-search');
    // await collection.boxOfRecentSearch.clear();
  }

  // NOTE: Archive extract File
  Future<List<String>> loadArchive(file) async {
    // return [file];
    List<int>? bytes = await UtilDocument.loadBundleAsByte(file)
        .then((data) => UtilDocument.byteToListInt(data).catchError((_) => null))
        .catchError((e) => null);
    if (bytes != null && bytes.isNotEmpty) {
      final res = await UtilArchive().extract(bytes).catchError((_) {
        debugPrint('$_');
        return null;
      });
      if (res != null) {
        return res;
      }
    }
    return Future.error("Failed to load");
  }

  // NOTE: Archive read File
  Future<List<dynamic>> readArchive(file) {
    return UtilDocument.exists(file).then((String e) async {
      if (e.isEmpty) {
        await loadArchive(collection.env.bucketAPI.archive);
      }
      return UtilDocument.decodeJSON<List<dynamic>>(await UtilDocument.readAsString(file));
      // print('album ${collection.env.bucketAPI.archive} is ${e.isNotEmpty} ');
    });
    // return Future.error("Failed to load");
  }

  // ignore: todo
  void userObserver(User? user) {
    debugPrint('userObserver begin');
  }

  // ignore: todo
  Future<void> analyticsFromCollection() async {
    analyticsSearch('keyword goes here');
  }
}
