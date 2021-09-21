import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:lidea/notify.dart';

import 'service.dart';

export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
// class SettingsController with ChangeNotifier {
class SettingsController extends Notify {
  // SettingsController(this._settingsService);
  // // Make SettingsService a private variable so it is not used directly.
  // final SettingsService _settingsService;

  static final SettingsController _instance = SettingsController.internal();
  SettingsController.internal();
  factory SettingsController() => _instance;
  // retrieve the instance through the app
  static SettingsController get instance => _instance;
  final _settingsService = SettingsService();

  // static SettingsController _instance;
  // factory SettingsController() => _instance ??= SettingsController._();
  // SettingsController._();

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> init() async {
    _themeMode = await _settingsService.themeMode();
    _locale = await _settingsService.locale();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Dot not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) {
      debugPrint('same');

    }

    // Otherwise, store the new theme mode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    await _settingsService.updateThemeMode(newThemeMode);
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;

  /// Returns the active [Brightness].
  Brightness get systemBrightness {
    Brightness brightness;
    switch (themeMode) {
      case ThemeMode.light:
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        brightness = Brightness.dark;
        break;
      default:
        brightness = WidgetsBinding.instance!.window.platformBrightness;
    }
    return brightness;
  }

  /// Returns opposite of active [Brightness].
  Brightness get resolvedSystemBrightness {
    return systemBrightness == Brightness.dark ? Brightness.light : Brightness.dark;
  }


  late Locale _locale;

  Future<void> updateLocale(Locale? newLocale) async {
    // _locale = abc!;
    if (newLocale == null) return;

    // Dot not perform any work if new and old ThemeMode are identical
    if (newLocale == _locale) return;

    // Otherwise, store the new theme mode in memory
    _locale = newLocale;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    await _settingsService.updateLocale(newLocale);
  }

  Locale get locale => _locale;

  // late AppLocalizations? _localizations;
  late BuildContext context ;

  // AppLocalizations get translate =>_localizations!;
  AppLocalizations get translate => AppLocalizations.of(context)!;

  // static SettingsController of(BuildContext context) {
  //   return context.;
  // }

  // static void update(BuildContext context, IdeaTheme newModel) {
  //   final scope = context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
  //   scope!.modelBindingState.updateModel(newModel);
  // }


}
