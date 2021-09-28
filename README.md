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

... api token

```json
[
  {
    "name":"name",
    "level":1,
    "id":"testing-tmp"
  }
]

```

... env token

```json
token-sss:{
  "key":0,
  "id":"abc"
}
// -> abc
token:{
  "key":0,
  "id":"a_b_c"
}
// -> a0b0c
token:{
  "key":0,
  "id":"[a_b_c]"
}
// -> c0b0a
```

keytool -list -v -keystore debug.keystore -alias android -storepass android -keypass android

sign_in_failed, com.google.android.gms.common.api.ApiException: 10
sign_in_canceled, com.google.android.gms.common.api.ApiException: 12501
sign_in_canceled, com.google.android.gms.common.api.ApiException: 12501

Configure SHA-1 certificate and download google-services.json in project settings

keytool -list -v \ -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore

keytool -list -v \ -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore
keytool -list -v \ -alias androiddebugkey -keystore %USERPROFILE%\.android\zaideihdebug.keystore

cd android/
./gradlew signingReport

gradlew clean

Facebook

Key Hash

gtcccfccc496fc21a5798ff34251618c7c7e29eb3e

openssl: C:\Program Files\Git\usr\bin

```note
      
keytool -exportcert -alias androiddebugkey -keystore "c:\Users\imsol\OneDrive\Setting\keystore\lethil.Android.jks" | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" sha1 -binary | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" base64
keytool -exportcert -alias androiddebugkey -keystore "C:\Users\USERNAME\.android\debug.keystore" | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" sha1 -binary | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" base64

keytool -exportcert -alias -keystore Lethil "/Users/imsol/OneDrive/Setting/keystore/lethil.Android.jks" | openssl sha1 -binary | openssl base64
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
