# Fleth

Flutter UI template

```cmd
flutter create -t skeleton fleth

flutter channel stable
```

## Features

... primary textfield features

kBottomNavigationBarHeight -> kToolbarHeight

```note
on initState(searchQuery)
  get -> core.collection.searchQuery
onSearch
  set -> core.collection.searchQuery from core.searchQuery
onCancel
  restore -> core.searchQuery from core.collection.searchQuery
  update -> textController.text 
```

```dart
late final Core core = context.read<Core>();
late final Preference preference = core.preference;

late final Authentication authenticate = context.read<Authentication>();


Preference get preference => core.preference;
SettingsController get settings => context.read<SettingsController>();
AppLocalizations get translate => AppLocalizations.of(context)!;
Authentication get authenticate => context.read<Authentication>();
ViewScrollNotify get scrollNotify => Provider.of<ViewScrollNotify>(context, listen: false);
 // late final ViewScrollNotify scrollNotify = context.read<ViewScrollNotify>();
  late final ViewScrollNotify scrollNotify = Provider.of<ViewScrollNotify>(context, listen: false);

late final bool _hasNav = widget.arguments != null;
late final _nav = widget.arguments as ViewNavigationArguments;
late final _navArguments = _nav.arguments<ViewNavigationArguments>();

```

```dart
late final args = argumentsAs<ViewNavigationArguments>();
late final param = args?.param<ViewNavigationArguments>();

Positioned(
  left: 0,
  top: 0,
  child: WidgetButton(
    padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
    child: WidgetLabel(
      icon: Icons.arrow_back_ios_new_rounded,
      label: preference.text.back,
    ),
  duration: const Duration(milliseconds: 300),
  show: hasArguments,
    onPressed: args?.currentState!.maybePop,
  ),
),
WidgetAppbarTitle(
  alignment: Alignment.lerp(
    const Alignment(0, 0),
    const Alignment(0, .5),
    org.snapShrink,
  ),
  label: 'Reorderable',
  shrink: org.shrink,
),
Positioned(
  right: 0,
  top: 0,
  child: WidgetButton(
    padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
    child: AnimatedBuilder(
      animation: dragController,
      builder: (context, _) {
        return WidgetLabel(
          icon: Icons.sort,
          iconColor: colorAnimation.value,
        );
      },
    ),
    enable: false,
    onPressed: onSort,
  ),
),
Positioned(
  right: 0,
  top: 0,
  child: WidgetButton(
    padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
    child: const WidgetLabel(
      icon: Icons.sort,
    ),
    duration: const Duration(milliseconds: 300),
    onPressed: onSort,
  ),
),
Positioned(
  right: 0,
  top: 0,
  child: WidgetButton(
    padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
    child: const WidgetLabel(
      icon: Icons.clear_all_rounded,
    ),
    duration: const Duration(milliseconds: 300),
    enable: hasValue,
    onPressed: () {
      doConfirmWithDialog(
        context: context,
        // message: 'Do you really want to delete all?',
        message: preference.text.confirmToDelete('all'),
      ).then((bool? confirmation) {
        if (confirmation != null && confirmation) onClearAll();
      });
    },
  ),
),
```

## Token

... api

```json
[
  {
    "name":"name",
    "level":1,
    "id":"testing-tmp"
  },
  {
    "level":0,
    "id":"abc"
  },
  // -> abc
  {
    "level":0,
    "id":"a~b~c"
  },
  // -> a0b0c
  {
    "level":0,
    "id":"[a~b~c]"
  },
  // -> c1b1a
]

```

## keystore for Android

... create keystore on windows

```bash
# %USERPROFILE%
# %OneDrive%/
# -keyalg RSA -keysize 2048 -validity 10000
keytool -genkey -v -alias ? -storepass ? -keystore %OneDrive%/env/dev/app/keystore.jks -deststoretype pkcs12 -keyalg RSA -keysize 2048 -validity 10000

# migrate from proprietary format to [pkcs12]
# The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore ?/name.app.jks -destkeystore ?/name.app.jks -deststoretype pkcs12"
keytool -importkeystore -srckeystore "path/name.jks" -destkeystore "path/name.jks" -deststoretype pkcs12


# list ?
keytool -list -v -keystore debug.keystore -alias android -storepass android -keypass android
keytool -exportcert -alias lethil -keystore "%OneDrive%/env/dev/laisiangtho/keystore.jks" | "C:\OpenSSL\bin\openssl" sha1 -binary | "C:\OpenSSL\bin\openssl" base64
```

... 'keytool' is not recognized

```bash
evn (PATH) -> %ProgramFiles%\Android\Android Studio\jre\bin
set PATH=%ProgramFiles%\Android\Android Studio\jre\bin
set PATH=%ProgramFiles%\apple
SET PATH=%PATH%;%ProgramFiles%\apple;
```

... gradlew Android

```bash
cd app/android/
# check signing report
gradlew signingReport
# clean
gradlew clean
```

... gradlew Android

```bash
keytool -exportcert -alias androiddebugkey -keystore "C:\Users\USERNAME\.android\debug.keystore" | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" sha1 -binary | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" base64

keytool -exportcert -alias androiddebugkey -keystore "%USERPROFILE%/.android/debug.keystore" | "C:\Program Files\Git\usr\bin\openssl" sha1 -binary | "C:\Program Files\Git\usr\bin\openssl" base64

keytool -exportcert -alias androiddebugkey -keystore "%USERPROFILE%/.android/debug.keystore" | "openssl" sha1 -binary | "openssl" base64

      
keytool -exportcert -alias Lethil -keystore %OneDrive%/Setting/laisiangtho/bible.Android.jks | "C:\Program Files\Git\usr\bin\openssl" sha1 -binary | "C:\Program Files\Git\usr\bin\openssl" base64
keytool -exportcert -alias Lethil -keystore %OneDrive%/Setting/laisiangtho/bible.Android.jks | openssl sha1 -binary | openssl base64



```

## OpenSSL

On windows 10: `Environment Variable` > `Path` add `C:\Program Files\Git\usr\bin`

```bash
# openssl: C:\Program Files\Git\usr\bin
```

## Error

... Android

```bash
# sign_in_failed, com.google.android.gms.common.api.ApiException: 10
# sign_in_canceled, com.google.android.gms.common.api.ApiException: 12501
# sign_in_canceled, com.google.android.gms.common.api.ApiException: 12501
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Exception has occurred.
FlutterError (setState() or markNeedsBuild() called during build.
This _InheritedProviderScope<Core?> widget cannot be marked as needing to build because the framework is already in the process of building widgets.  A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
The widget on which setState() or markNeedsBuild() was called was:
  _InheritedProviderScope<Core?>
The widget which was currently being built when the offending call was made was:
  Builder)
