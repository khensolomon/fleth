part of 'main.dart';

abstract class _Abstract extends UtilEngine with _Configuration, _Utility {
  final Authentication authentication;

  _Abstract(this.authentication);

  Future<void> ensureInitialized() async {
    Stopwatch initWatch = Stopwatch()..start();

    await collection.ensureInitialized(() {});
    await collection.prepareInitialized(() {});

    // if (authentication.id.isNotEmpty && authentication.id != collection.setting.userId) {
    //   final ou = collection.setting.copyWith(userId: authentication.id);
    //   await collection.settingUpdate(ou);
    // }

    debugPrint('ensureInitialized in ${initWatch.elapsedMilliseconds} ms');
  }

  Future<void> initData() async {
    await initBible();
    // await initDictionary();
    // await initMusic();
  }

  Future<void> initBible() async {
    if (collection.requireInitialized) {
      APIType api = collection.env.api.firstWhere(
        (e) => e.asset.isNotEmpty,
      );
      await UtilArchive.extractBundle(api.asset);
    }
    // if (requireInitialized) {
    //   final localData = collection.env.api.where((e) => e.asset.isNotEmpty);
    //   for (APIType api in localData) {
    //     await UtilArchive.extractBundle(api.asset).then((_) {
    //       debugPrint('Ok ${api.uid}');
    //     }).catchError((e) {
    //       debugPrint('Error ${api.uid} $e');
    //     });
    //   }
    // }
  }

  Future<void> initDictionary() async {
    if (collection.requireInitialized) {
      APIType api = collection.env.api.firstWhere(
        (e) => e.asset.isNotEmpty,
      );
      await UtilArchive.extractBundle(api.asset);
    }
  }

  Future<void> initMusic() async {
    final localData = collection.env.api.where(
      (e) => e.local.isNotEmpty && !e.local.contains('!'),
    );
    if (collection.requireInitialized) {
      APIType api = collection.env.api.firstWhere((e) => e.asset.isNotEmpty);
      await UtilArchive.extractBundle(api.asset);
    }
    collection.cacheBucket = AudioBucketType.fromJSON(
      Map.fromEntries(
        await Future.wait(
          localData.map(
            (e) async => MapEntry(
              e.uid,
              await UtilDocument.readAsJSON<List<dynamic>>(e.local),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> deleteOldLocalData(Iterable<APIType> localData) async {
  //   if (requireInitialized) {
  //     for (APIType api in localData) {
  //       await UtilDocument.exists(api.localName).then((String e) {
  //         if (e.isNotEmpty) {
  //           UtilDocument.delete(e);
  //         }
  //       });
  //     }
  //   }
  // }

  void userObserver(User? user) {
    debugPrint('userObserver begin');
  }

  Future<void> analyticsFromCollection() async {
    analyticsSearch('keyword goes here');
  }
}
