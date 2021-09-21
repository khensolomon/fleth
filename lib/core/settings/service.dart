import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fleth/core.dart';
/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {

  final _user = Core.instance.collection;

  /// Loads the User's preferred ThemeMode from local or remote storage.
  // Future<ThemeMode> themeMode() async => ThemeMode.system;
  Future<ThemeMode> themeMode() async {
    final theme = ThemeMode.values.elementAt(_user.setting.mode);
    return ThemeMode.values.firstWhere((e) => e==theme, orElse: ()=>ThemeMode.values.first);
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  // Use the shared_preferences package to persist settings locally or the
  // http package to persist settings over the network.
  Future<void> updateThemeMode(ThemeMode theme) async {
    final mode = ThemeMode.values.indexOf(theme);
    await _user.settingUpdate(_user.setting.copyWith(mode: mode));
  }

  // Future<Locale> locale() async => Intl.systemLocale;
  // Future<Locale> locale() async => Locale(Intl.getCurrentLocale(),'');
  Future<Locale> locale() async {
    final lang = _user.setting.locale;
    return Locale(lang.isEmpty?Intl.systemLocale:lang,'');
  }

  Future<void> updateLocale(Locale locale) async {
    await _user.settingUpdate(_user.setting.copyWith(locale: locale.languageCode));
  }
}
