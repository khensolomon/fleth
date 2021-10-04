# Fleth

Flutter UI template

```cmd
flutter create -t skeleton fleth

flutter channel stable
```

## Features

... primary textfield features

```note
on initState(searchQuery)
  get -> core.collection.searchQuery
onSearch
  set -> core.collection.searchQuery from core.searchQuery
onCancel
  restore -> core.searchQuery from core.collection.searchQuery
  update -> textController.text 
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
keytool -genkey -v -alias ? -storepass ? -keystore %OneDrive%/Setting/keystore/com.name.app.jks -deststoretype pkcs12 -keyalg RSA -keysize 2048 -validity 10000

# migrate from proprietary format to [pkcs12]
# The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore ?/name.app.jks -destkeystore ?/name.app.jks -deststoretype pkcs12"
keytool -importkeystore -srckeystore "path/name.jks" -destkeystore "path/name.jks" -deststoretype pkcs12

# list ?
keytool -list -v -keystore debug.keystore -alias android -storepass android -keypass android
```

... gradlew Android

```bash
cd app/android/
# check signing report
gradlew signingReport
# clean
gradlew clean
```

## OpenSSL

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
