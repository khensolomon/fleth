
part of 'main.dart';

@HiveType(typeId: 0)
class SettingType {
  @HiveField(0)
  int version;

  // 0 = system 1 = light 2 = dark
  @HiveField(1)
  int mode;

  @HiveField(2)
  double fontSize;

  @HiveField(3)
  String searchQuery;

  // '' = system, en, no, my...
  @HiveField(4)
  String locale;

  SettingType({
    this.version = 0,
    this.mode = 0,
    this.fontSize = 17.0,
    this.searchQuery = '',
    this.locale = ''
  });

  factory SettingType.fromJSON(Map<String, dynamic> o) {
    return SettingType(
      version: o["version"] as int,
      mode: o["mode"] as int,
      fontSize: o["fontSize"] as double,
      searchQuery: o["searchQuery"] as String,
      locale: o["locale"] as String
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "version":version,
      "mode":mode,
      "fontSize":fontSize,
      "searchQuery":searchQuery,
      "locale":locale
    };
  }

  SettingType merge(SettingType o) {
    return SettingType(
      version: o.version,
      mode: o.mode,
      fontSize: o.fontSize,
      searchQuery: o.searchQuery,
      locale: o.locale,
    );
  }

  SettingType copyWith({
    int? version,
    int? mode,
    double? fontSize,
    String? searchQuery,
    String? locale
  }) {
    return SettingType(
      version: version??this.version,
      mode: mode??this.mode,
      fontSize: fontSize??this.fontSize,
      searchQuery: searchQuery??this.searchQuery,
      locale: locale??this.locale
    );
  }
}
