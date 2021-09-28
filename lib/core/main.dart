import 'dart:async';
// import 'dart:io';
import 'dart:math';
// import 'dart:typed_data';
// import 'dart:io';
// import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// import 'package:audio_session/audio_session.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart';

// import 'package:flutter/widgets.dart';
// import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';

// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

import 'package:lidea/hive.dart';
import 'package:lidea/authentication.dart';

import 'package:lidea/analytics.dart';
import 'package:lidea/engine.dart';
// import 'package:lidea/intl.dart';

import 'type/main.dart';

import 'purchase.dart';

part 'configuration.dart';
part 'abstract.dart';
part 'utility.dart';
part 'mock.dart';
// part 'store.dart';
// part 'sqlite.dart';
// part 'audio.dart';

class Core extends _Abstract with _Mock {
  // Creates instance through `_internal` constructor
  // static final Core _instance = Core.internal();
  // Core.internal();
  // factory Core() => _instance;
  // // retrieve the instance through the app
  // static Core get instance => _instance;

  Future<void> init() async {
    Stopwatch initWatch = Stopwatch()..start();

    if (progressPercentage == 1.0) return;
    // await Future.delayed(const Duration(milliseconds: 1000));
    await Future.microtask(() => null);

    await initData();

    // progressPercentage = 0.3;

    // store = new Store(notify:notify,collection: collection);

    // await store.init();
    // progressPercentage = 0.5;

    // // _sql = new SQLite(collection: collection);
    // // await _sql.init();

    await collection.cacheBucket.artistInit();
    await collection.cacheBucket.trackInit();
    await collection.cacheBucket.albumInit();
    await collection.cacheBucket.langInit();

    // audio = new Audio(notifyIf:notifyIf, collection: collection);
    // await audio.init();

    // progressPercentage = 0.9;

    // await definitionGenerate();
    // await mockTest();

    debugPrint('Initiated in ${initWatch.elapsedMilliseconds} ms');
    // progressPercentage = 1.0;
    // _message = 'Done';
    // suggestionQuery = 'god';
    // suggestionQuery = collection.setting.searchQuery!;
    searchQuery = collection.searchQuery;
  }

  Future<void> analyticsReading() async {
    analyticsSearch('keyword goes here');
  }
}
