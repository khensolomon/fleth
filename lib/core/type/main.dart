import 'package:flutter/widgets.dart';

// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

import "package:lidea/hive.dart";
import "package:lidea/extension.dart";
import "package:lidea/notify.dart";

part 'adapter/setting.dart';
part 'adapter/recent_search.dart';
part 'adapter/purchase.dart';

part "collection.dart";
part 'setting.dart';
part 'recent_search.dart';
part 'purchase.dart';
part "audio.dart";
// part 'notify.md';

// NOTE: only type
class EnvironmentType {
  String name;
  String description;
  String package;
  String version;
  String buildNumber;
  String url;

  String settingName;
  String settingKey;
  SettingType setting;

  TokenType token;

  List<APIType> apis;
  List<ProductsType> products;

  EnvironmentType({
    required this.name,
    required this.description,
    required this.package,
    required this.version,
    required this.buildNumber,
    required this.url,
    required this.settingName,
    required this.settingKey,
    required this.setting,
    required this.apis,
    required this.token,
    required this.products,
  });

  factory EnvironmentType.fromJSON(Map<String, dynamic> o) {
    return EnvironmentType(
      name: o["name"],
      description: o["description"],
      package: o["package"] ?? "",
      version: o["version"] ?? "1.0.0",
      buildNumber: o["buildNumber"] ?? "0",
      url: o["url"] ?? "",
      settingName: o["settingName"] ?? "0",
      settingKey: o["settingKey"] ?? "0",
      setting: SettingType.fromJSON(o["setting"]),
      apis: o['api'].map<APIType>((e) => APIType.fromJSON(e, o["url"])).toList(),
      token: TokenType.fromJSON(o["token"] ?? {"id": ""}),
      // token: (o["token"] ?? '').toString().bracketsHack(),
      // token: '[abc]'.bracketsHack(),
      products: o['products'].map<ProductsType>((e) => ProductsType.fromJSON(e)).toList(),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "description": description,
      "package": package,
      "version": version,
      "buildNumber": buildNumber,
      "url": url,
      "settingName": settingName,
      "settingKey": settingKey,
      "setting": setting.toString(),
      "apis": apis.map((e) => e.toJSON()).toList(),
      "products": products.map((e) => e.toJSON()).toList()
    };
  }

  APIType get bucketAPI => apis.firstWhere((e) => e.uid == 'album');
}

// NOTE: only type, EnvironmentType child
// abc -> cba
// a_b_c ->
class APIType {
  String uid;
  List<String> src;

  APIType({required this.uid, required this.src});

  factory APIType.fromJSON(Map<String, dynamic> o, String url) {
    return APIType(
      uid: o["uid"] as String,
      src: List.from(
        (o['src'] ?? []).map<String>((e) => e.toString().gitHack(url: url)),
      ),
    );
  }

  Map<String, dynamic> toJSON() {
    return {"uid": uid, "src": src.toList()};
  }

  // String get url => src.where((e) => Uri.parse(e).isAbsolute).first;
  // String get file => src.where((e) => Uri.parse(e).isAbsolute == false && e.endsWith('json')).first;
  String get archive => src
      .where((e) => Uri.parse(e).isAbsolute == false && e.endsWith('json'))
      .first
      .replaceFirst('?', uid);

  String trackCache(int id) => src
      .where((e) => Uri.parse(e).isAbsolute == false && e.endsWith('mp3'))
      .first
      .replaceFirst('?', id.toString());

  String trackLive(int id) => src
      .where((e) => Uri.parse(e).isAbsolute && e.contains('audio'))
      .first
      .replaceFirst('?', id.toString());
}

// NOTE: only type, EnvironmentType child
class TokenType {
  final String key;
  final String id;
  final String name;
  final String level;

  const TokenType({
    required this.key,
    required this.id,
    required this.name,
    required this.level,
  });

  factory TokenType.fromJSON(Map<String, dynamic> o) {
    String level = (o["level"] ?? '').toString();
    return TokenType(
      key: (o["key"] ?? '').toString().bracketsHack(key: level),
      name: (o["name"] ?? '').toString().bracketsHack(key: level),
      level: level,
      id: (o["id"] ?? '').toString().bracketsHack(key: level),
    );
  }

  bool get hasId => id.isNotEmpty;
}

// NOTE: only type, EnvironmentType child
class ProductsType {
  String cart;
  String name;
  String type;
  String title;
  String description;

  ProductsType({
    required this.cart,
    required this.name,
    required this.type,
    required this.title,
    required this.description,
  });

  factory ProductsType.fromJSON(Map<String, dynamic> o) {
    return ProductsType(
      cart: o["cart"] as String,
      name: o["name"] as String,
      type: o["type"] as String,
      title: o["title"] as String,
      description: o["description"] as String,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "cart": cart,
      "name": name,
      "type": type,
      "title": type,
      "description": type,
    };
  }
}

/// user data
class UserDataType {
  int version;
  int size;
  List<int> playlist;
  List<String> keywords;

  UserDataType({
    required this.version,
    required this.size,
    required this.playlist,
    required this.keywords,
  });

  factory UserDataType.fromJSON(Map<String, dynamic> o) {
    return UserDataType(
      version: int.parse((o["version"] ?? 0)),
      size: int.parse((o["size"] ?? 0)),
      playlist: List.from(o['playlist'] ?? []).map<int>((e) => int.parse(e)).toList(),
      keywords: List.from(o['keywords'] ?? []).map<String>((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "version": version,
      "size": size,
      "playlist": playlist,
      "keywords": keywords,
    };
  }
}

/// This use to format search suggestion type
class SuggestionType {
  final String query;
  final List<Map<String, Object?>> raw;
  const SuggestionType({this.query = '', this.raw = const []});
}

/// This use to format search result type
class ConclusionType {
  final String query;
  final List<Map<String, dynamic>> raw;
  const ConclusionType({this.query = '', this.raw = const []});
}
