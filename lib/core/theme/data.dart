import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IdeaData {
  static const IdeaColor _lightColor = IdeaColor(
    brightness: Brightness.light,
    focus: Colors.black,
    primaryScheme: Colors.black87,

    primary: Color(0xFFffffff),
    // primary: Color(0xFFffffff),
    scaffold: Color(0xFFf7f7f7),
    highlight: Colors.orange,
    background: Color(0xFFbdbdbd),
    // background: Color(0xFFffffff),
    // shadow: Colors.grey[400]!,
    // shadow: Colors.grey.shade400,
    shadow: Color(0xFFbdbdbd),
    button: Color(0xFFdedcdc)

    // primary: Color(0xFFf7f7f7),
    // // primary: Color(0xFFffffff),
    // scaffold: Color(0xFFffffff),
    // highlight: Colors.orange,
    // // background: Color(0xFFbdbdbd),
    // background: Color(0xFFe8e8e8),
    // // shadow: Colors.grey[400]!,
    // // shadow: Colors.grey.shade400,
    // shadow: Color(0xFFbdbdbd),
    // button: Color(0xFFdedcdc)
  );

  static const IdeaColor _darkColor = IdeaColor(
    brightness: Brightness.dark,
    focus: Colors.white,
    primaryScheme: Colors.white,

    primary: Color(0xFF9c9c9c),
    // primary: Color(0xFF737373),
    scaffold: Color(0xFFa6a6a6),
    highlight: Colors.orange,
    background: Color(0xFFbdbdbd),
    // shadow: Colors.grey[600]!,
    shadow: Color(0xFF8f8f8f),
    button: Color(0xFFd9d9d9)
  );

  static ThemeData light(BuildContext context) => theme(context, _lightColor);
  static ThemeData dark(BuildContext context) => theme(context, _darkColor);

  static ThemeData theme(BuildContext context,IdeaColor color) {
    final TextTheme textTheme = Theme.of(context).textTheme.merge(_textTheme);
    // final TextTheme textTheme = _textTheme.merge(Theme.of(context).textTheme);

    return ThemeData(
      colorScheme: color.scheme,
      brightness: color.brightness,

      // fontFamily: "Lato, sans-serif",
      fontFamily: "Lato, 'Mm3Web', sans-serif",

      primaryColor: color.primary,
      shadowColor: color.shadow,
      canvasColor: color.canvas,
      scaffoldBackgroundColor: color.scaffold,
      backgroundColor: color.background,
      highlightColor: color.highlight,
      // buttonColor:color.button,

      textTheme: textTheme.apply(
        bodyColor: color.focus,
        displayColor:color.highlight,
        decorationColor: Colors.red,
      ),

      primaryTextTheme:textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: color.primary,
        foregroundColor: color.focus
      ),

      iconTheme: IconThemeData(
        color: color.focus,
        size: 23
      ),

      cardTheme: CardTheme(
        color: color.primary,
        elevation:0,
        shadowColor: color.shadow,
        margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.2, color: color.shadow),
          // BorderRadius.circular(5)
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
      ),

      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          primaryColor: Colors.red,
          actionTextStyle:TextStyle(color: Colors.orange)
        )
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: color.shadow.withOpacity(0.7),
        // hoverColor: Colors.green,
        // focusColor: Colors.red,
        // hintStyle: const TextStyle(height: 1.3),
        // labelStyle: const TextStyle(height: 1.3),
        // alignLabelWithHint: true,
        suffixStyle: const TextStyle(color: Colors.red),


        contentPadding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.background, width: 0.3),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.shadow, width: 0.2),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.shadow.withOpacity(0.8), width: 0.2),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),

        border: OutlineInputBorder(
          borderSide: BorderSide(color: color.shadow, width: 0.2),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        )
      ),

      bottomSheetTheme: BottomSheetThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(3.5)),
        ),
        clipBehavior: Clip.hardEdge,
        // clipBehavior: Clip.antiAlias,
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        // modalBackgroundColor: color.background,
        modalBackgroundColor: color.primary,
        modalElevation:2.0,
        // backgroundColor: color.primary,
        backgroundColor: color.background,
        // backgroundColor: Colors.red,
        elevation:0.0,
      ),

      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.cyan
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.red
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          textStyle: const TextStyle(
            fontSize: 19
          )
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(color.focus),
          backgroundColor: MaterialStateProperty.all<Color>(color.primary)
        )
      )
    );
  }

  static ColorScheme lightScheme = _lightColor.scheme;
  static ColorScheme darkScheme = _darkColor.scheme;

  static const _fontWeightSemiThin = FontWeight.w100;
  static const _fontWeightThin = FontWeight.w100;
  static const _fontWeighRegular = FontWeight.w300;
  static const _fontWeighMedium = FontWeight.w400;
  static const _fontWeighSemiBold = FontWeight.w500;
  // static const _fontWeighBold = FontWeight.w700;

  static const TextTheme _textTheme = TextTheme(
    headline1: TextStyle(fontWeight: _fontWeightSemiThin, fontFamilyFallback:["Mm3Web","sans-serif"], height: 1.0),
    headline2: TextStyle(fontWeight: _fontWeightThin, fontFamilyFallback:["Mm3Web","sans-serif"], height: 1.0),
    headline3: TextStyle(fontWeight: _fontWeighRegular, fontFamilyFallback:["Mm3Web","sans-serif"], height: 1.0),
    headline4: TextStyle(fontWeight: _fontWeighRegular, fontFamilyFallback:["Mm3Web","sans-serif"], height: 1.0),
    headline5: TextStyle(fontWeight: _fontWeighRegular, fontFamilyFallback:["Mm3Web","sans-serif"], height: 1.0),
    headline6: TextStyle(fontWeight: _fontWeighRegular, fontFamilyFallback:["Mm3Web","sans-serif"], height: 1.2),

    subtitle1: TextStyle(fontWeight: _fontWeighRegular, fontFamilyFallback:["Mm3Web","sans-serif"], height: 1.4),
    subtitle2: TextStyle(fontWeight: _fontWeighMedium, fontFamilyFallback:["Mm3Web","sans-serif"], height: 1.0),

    bodyText1: TextStyle(fontWeight: _fontWeighRegular, fontFamilyFallback:["Mm3Web","sans-serif"], fontSize: 18,height: 1.2),
    bodyText2: TextStyle(fontWeight: _fontWeighRegular, fontFamilyFallback:["Mm3Web","Lato","sans-serif"], fontSize: 20, height: 1.25),

    caption: TextStyle(fontWeight: _fontWeighSemiBold, fontFamilyFallback:["Mm3Web","sans-serif"], height: 1.0),
    button: TextStyle(fontWeight: _fontWeightThin, fontFamilyFallback:["Mm3Web","sans-serif"], height: 1.0),
    overline: TextStyle(fontWeight: _fontWeighMedium, fontFamilyFallback:["Mm3Web","sans-serif"], height: 1.0)
  );

}

// Default color configuration is light, and translated into how human mind can interpreted the material color
class IdeaColor{
  final Brightness brightness;
  final Color focus;

  final Color primary;
  final Color scaffold;
  final Color highlight;
  final Color background;
  final Color shadow;
  final Color button;

  // schemePrimary primaryScheme
  final Color primaryScheme;

  const IdeaColor({
    this.brightness =Brightness.light,
    this.focus =Colors.black,

    this.primary =Colors.white,
    this.scaffold =Colors.white,
    this.highlight =Colors.blue,
    this.background =Colors.grey,
    this.shadow =Colors.grey,

    this.button =Colors.blue,


    this.primaryScheme =Colors.white,
  });

  // Color get shadow => scaffold.darken(amount: 0.2);
  Color get canvas => Colors.transparent;

  Color get focusOpacity => focus.withOpacity(0.12);
  Color get text => focus;

  ColorScheme get scheme => ColorScheme(
    brightness: brightness,
    primary: primaryScheme,
    primaryVariant: primary.darken(),
    secondary: primaryScheme,
    secondaryVariant: primary.darken(),
    background: scaffold,
    surface: scaffold.darken(),
    error: focusOpacity,

    onError: focusOpacity,
    onPrimary: focusOpacity,
    onSecondary: focusOpacity,
    onSurface: focusOpacity,
    onBackground: scaffold
  );

}

extension ColorDimExtension on Color {
  Color darken({double amount = .1}) {
    assert(amount >= 0 && amount <= 1);
    HSLColor color = HSLColor.fromColor(this);
    return color.withLightness((color.lightness - amount).clamp(0.0, 1.0)).toColor();
  }

  Color lighten({double amount = .1}) {
    assert(amount >= 0 && amount <= 1);
    HSLColor color = HSLColor.fromColor(this);
    return color.withLightness((color.lightness + amount).clamp(0.0, 1.0)).toColor();
  }

  // Color darken(Color color, [double amount = .1]) {
  //   assert(amount >= 0 && amount <= 1);
  //   final hsl = HSLColor.fromColor(color);
  //   final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  //   return hslDark.toColor();
  // }

  // Color lighten(Color color, [double amount = .1]) {
  //   assert(amount >= 0 && amount <= 1);
  //   final hsl = HSLColor.fromColor(color);
  //   final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
  //   return hslLight.toColor();
  // }
}
