import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async => ThemeMode.system;
  // Future<Locale> locale() async => Intl.systemLocale;
  Future<Locale> locale() async => Locale(Intl.systemLocale,'');
  // Future<Locale> locale() async => Locale(Intl.getCurrentLocale(),'');

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }

  Future<void> updateLocale(Locale locale) async {
    debugPrint('updateLocale ${locale.languageCode}');
  }
}
