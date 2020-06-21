import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class ColorsLibrary {
  static Color backgroundColor = TinyColor.fromString('##FCFCFC').color;
  static Color shadowColors = TinyColor.fromString('#dddddd').color;
  static Color textColorBoldBlack = TinyColor.fromString('#333333').color;
  static Color textColorUltraLightGray = TinyColor.fromString('#DFDFDF').color;
  static Color textColorLightGray = TinyColor.fromString('##9A9A9A').color;
  static Color textColorBoldInversed = TinyColor.fromString('#FFFFFF').color;
  static Color accentColor0 = TinyColor.fromString('#5879FF').color;
  static Color accentColor1 = TinyColor.fromString('#FFBA67').color;
  static Color accentColor2 = TinyColor.fromString('#FF8D77').color;
  static Color accentColor3 = TinyColor.fromString('#00D376').color;
  static Color accentColor4 = TinyColor.fromString('#927ED6').color;
  static Color accentColor5 = TinyColor.fromString('#EA614F').color;
  static Color accentColor6 = TinyColor.fromString('#B858C9').color;
  static Color accentColor7 = TinyColor.fromString('#00B5C2').color;
  static Color accentColor0Disabled = TinyColor.fromString('#7993FF').color;

  static Color idToColorConverter(int id) {
    final accents = {
      0: accentColor0,
      1: accentColor1,
      2: accentColor2,
      3: accentColor3,
      4: accentColor4,
      5: accentColor5,
      6: accentColor6,
      7: accentColor7
    };

    final val = id % accents.length;
    return accents[val];
  }
}
