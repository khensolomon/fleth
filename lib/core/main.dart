library data.core;

import 'dart:async';
import 'package:flutter/material.dart';

// NOTE: Preference
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// NOTE: Authentication
// import 'package:lidea/firebase_auth.dart';
import 'package:lidea/unit/authentication.dart';

// NOTE: Navigation
import 'package:lidea/unit/navigation.dart';

// NOTE: Analytics
import 'package:lidea/unit/analytics.dart';

// NOTE: Store
import 'package:lidea/unit/store.dart';
// NOTE: SQLite
// import 'package:lidea/unit/sqlite.dart';
// NOTE: Audio
// import 'package:audio_session/audio_session.dart';
// import 'package:just_audio/just_audio.dart';

// NOTE: Core notify and Initializing properties
import 'package:lidea/unit/engine.dart';
// Mock:
import 'package:lidea/unit/mock.dart';

import '/type/main.dart';

part 'store.dart';
part 'sqlite.dart';
part 'audio.dart';

part 'preference.dart';
part 'authentication.dart';
part 'navigation.dart';
part 'analytics.dart';

part 'abstract.dart';
part 'utility.dart';
part 'mock.dart';

class Core extends _Abstract with _Mock {
  static Future<void> ensureFirebase() async {
    await Firebase.initializeApp();
    // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }

  Future<void> init(BuildContext context) async {
    debugPrint('??? init last');
    Stopwatch initWatch = Stopwatch()..start();
    // collection.locale = Localizations.localeOf(context).languageCode;
    // preference.context = context;
    preference.setContext(context);

    // await Future.microtask(() => null);

    await dataInitialized();

    await store.init();

    await _sql.init();

    // await mockTest();

    debugPrint('Initiated in ${initWatch.elapsedMilliseconds} ms');
  }
}
