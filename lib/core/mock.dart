part of 'main.dart';

/// check
mixin _Mock on _Abstract {
  Future<dynamic> mockTest() async {
    Stopwatch mockWatch = Stopwatch()..start();

    final a3 = UtilDocument.encodeJSON({'hello': getRandomString(10)});
    userGist.updateFile(file: userFile, content: a3).then((e) {
      debugPrint('$e');
    }).catchError((e) async {
      if (e == 'Failed to load') {
        await userTokenUpdate().then((e) {
          debugPrint(e);
        }).catchError((e) {
          debugPrint('$e');
        });
      } else {
        debugPrint('$e');
      }
    });

    // await gist.gitFiles().then((res) {
    //   debugPrint('result $res');
    // }).catchError((e) {
    //   debugPrint('error $e');
    // });
    // await gist.updateFile('other.csv', 'id,\nfirst-,\nsecond-,').then((res) {
    //   debugPrint('result $res');
    // }).catchError((e) {
    //   debugPrint('error $e');
    // });
    // await gist.removeFile('others.csv').then((res) {
    //   debugPrint('result $res');
    // }).catchError((e) {
    //   debugPrint('error $e');
    // });

    debugPrint('mockTest in ${mockWatch.elapsedMilliseconds} ms');
  }

  String get userFile => authentication.id.isNotEmpty ? '${authentication.id}.json' : '';

  // Future<bool> initArchive() async{
  //   bool toChecks = false;
  //   for (var item in collection.env.listOfDatabase) {
  //     toChecks = await UtilDocument.exists(item.file).then(
  //       (e) => e.isEmpty
  //     ).catchError((_)=>true);
  //     if (toChecks){
  //       // stop checking at ${item.uid}
  //       debugPrint('stop checking at ${item.uid}');
  //       break;
  //     }
  //     // continuous checking on ${item.uid}
  //     debugPrint('continuous checking on ${item.uid}');
  //   }
  //   if (toChecks) {
  //     return await loadArchiveMock(collection.env.primary).then((e) => true).catchError((_)=>false);
  //   }
  //   // Nothing to unpack so everything is Ok!
  //   debugPrint('Nothing to unpack, everything seems fine!');
  //   return true;
  // }

  // // Archive: extract File
  // Future<List<String>> loadArchiveMock(APIType id) async{
  //   for (var item in id.src) {
  //     List<int>? bytes;
  //     bool _validURL = Uri.parse(item).isAbsolute;
  //     if (_validURL){
  //       bytes = await UtilClient(item).get<Uint8List?>().catchError((_) => null);
  //     } else {
  //       bytes = await UtilDocument.loadBundleAsByte(item).then(
  //         (value) => UtilDocument.byteToListInt(value).catchError((_) => null)
  //       ).catchError((e) => null);
  //     }
  //     if (bytes != null && bytes.isNotEmpty) {
  //       // load at $item
  //       debugPrint('load at $item');
  //       final res = await UtilArchive().extract(bytes).catchError((_) => null);
  //       if (res != null) {
  //         // loaded file $res
  //         debugPrint('loaded file $res');
  //         return res;
  //       }
  //     }
  //   }
  //   return Future.error("Failed to load");
  // }

  String getRandomString(int length) {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(length, (index) => _chars[Random().nextInt(_chars.length)]).join();
  }

  /// ```dart
  /// [query: String, raw: List<Map<String, Object?>>]
  /// ```
  /// typeof [SuggestionType]
  Future<void> suggestionGenerate() async {
    Stopwatch suggestionWatch = Stopwatch()..start();
    int randomNumber = Random().nextInt(100);
    collection.cacheSuggestion = SuggestionType(
      query: searchQuery,
      // raw: await _sql.suggestion()
      raw: List.generate(randomNumber, (_) => {'word': 'random $randomNumber $searchQuery'}),
    );
    notify();
    debugPrint('suggestionGenerate in ${suggestionWatch.elapsedMilliseconds} ms');
  }

  // ignore: todo
  // TODO: definition on multi words
  /// ```dart
  /// [query: String, raw: List<Map<String, Object?>>]
  /// ```
  /// typeof [ConclusionType]
  Future<void> conclusionGenerate({bool init = false}) async {
    // Stopwatch conclusionWatch = Stopwatch()..start();
    int _random = Random().nextInt(100);
    // collection.cacheConclusion = ConclusionType(
    //   query: collection.searchQuery,
    //   raw: List.generate(randomNumber, (_) => {'word': 'random $randomNumber'}),
    // );
    // notify();

    // debugPrint('conclusionGenerate in ${conclusionWatch.elapsedMilliseconds} ms');

    debugPrint('conclusionGenerate ${collection.searchQuery}');

    if (collection.cacheConclusion.query != collection.searchQuery) {
      collection.cacheConclusion = ConclusionType(
        query: collection.searchQuery,
        // raw: await _definitionGenerator()
        raw: List.generate(_random, (_) => {'word': '${collection.searchQuery} $_random'}),
      );
      collection.recentSearchUpdate(collection.searchQuery);
      if (!init) {
        notify();
      }
    }
    // collection.recentSearchUpdate(word);
    // collection.searchQuery = word;
    // analyticsSearch(collection.searchQuery);
  }
}
