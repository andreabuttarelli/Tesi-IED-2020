import 'package:app/src/blocs/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaletteColor {
  BuildContext context;
  ThemeEnum theme;
  Palette type;
  Color color = Colors.transparent;

  PaletteColor({this.theme, this.context, this.type}) {
    theme = (MediaQuery.of(context).platformBrightness == Brightness.dark)
        ? ThemeEnum.dark
        : ThemeEnum.light;
    /*switch (type) {
      case Palette.backgroundPrimary:
        color = (theme == ThemeEnum.light)
            ? LightPalette().backgroundPrimary
            : DarkPalette().backgroundPrimary;
        break;
      case Palette.backgroundSecondary:
        color = (theme == ThemeEnum.light)
            ? LightPalette().backgroundSecondary
            : DarkPalette().backgroundSecondary;
        break;
      case Palette.black:
        color = (theme == ThemeEnum.light)
            ? LightPalette().black
            : DarkPalette().black;
        break;
      case Palette.white:
        color = (theme == ThemeEnum.light)
            ? LightPalette().white
            : DarkPalette().white;
        break;
      case Palette.accent:
        color = (theme == ThemeEnum.light)
            ? LightPalette().accent
            : DarkPalette().accent;
        break;
      case Palette.textPrimary:
        color = (theme == ThemeEnum.light)
            ? LightPalette().textPrimary
            : DarkPalette().textPrimary;
        break;
      case Palette.textSecondary10:
        color = (theme == ThemeEnum.light)
            ? LightPalette().textSecondary10
            : DarkPalette().textSecondary10;
        break;
      case Palette.textSecondary20:
        color = (theme == ThemeEnum.light)
            ? LightPalette().textSecondary20
            : DarkPalette().textSecondary20;
        break;
      case Palette.textSecondary30:
        color = (theme == ThemeEnum.light)
            ? LightPalette().textSecondary30
            : DarkPalette().textSecondary30;
        break;
      case Palette.textSecondary40:
        color = (theme == ThemeEnum.light)
            ? LightPalette().textSecondary40
            : DarkPalette().textSecondary40;
        break;
      case Palette.textSecondary50:
        color = (theme == ThemeEnum.light)
            ? LightPalette().textSecondary50
            : DarkPalette().textSecondary50;
        break;
      case Palette.textSecondary60:
        color = (theme == ThemeEnum.light)
            ? LightPalette().textSecondary60
            : DarkPalette().textSecondary60;
        break;
      case Palette.textSecondary70:
        color = (theme == ThemeEnum.light)
            ? LightPalette().textSecondary70
            : DarkPalette().textSecondary70;
        break;
      case Palette.textSecondary80:
        color = (theme == ThemeEnum.light)
            ? LightPalette().textSecondary80
            : DarkPalette().textSecondary80;
        break;
      case Palette.textSecondary90:
        color = (theme == ThemeEnum.light)
            ? LightPalette().textSecondary90
            : DarkPalette().textSecondary90;
        break;
      case Palette.textDisabled:
        color = (theme == ThemeEnum.light)
            ? LightPalette().textDisabled
            : DarkPalette().textDisabled;
        break;
      case Palette.textAccent:
        color = (theme == ThemeEnum.light)
            ? LightPalette().textAccent
            : DarkPalette().textAccent;
        break;
      case Palette.textPrimaryInverse:
        color = (theme == ThemeEnum.light)
            ? LightPalette().color[]
            : DarkPalette().textPrimaryInverse;
        break;
      default:
        color = Colors.black;
    }*/
  }
}

enum Palette {
  backgroundPrimary,
  backgroundSecondary,
  black,
  white,
  accent,
  textPrimary,
  textSecondary90,
  textSecondary80,
  textSecondary70,
  textSecondary60,
  textSecondary50,
  textSecondary40,
  textSecondary30,
  textSecondary20,
  textSecondary10,
  textDisabled,
  textAccent,
  textPrimaryInverse,
}

class LightPalette {
  Map<String, Color> colors = {
    "Palette.backgroundPrimary": Colors.white,
    "Palette.backgroundSecondary": Color(0xFFF1F1F1),
    "Palette.black": Colors.black,
    "Palette.white": Colors.white,
    "Palette.accent": Color(0xFFA92217),
    "Palette.textPrimary": Colors.black,
    "Palette.textSecondary90": Colors.black.withOpacity(0.9),
    "Palette.textSecondary80": Colors.black.withOpacity(0.8),
    "Palette.textSecondary70": Colors.black.withOpacity(0.7),
    "Palette.textSecondary60": Colors.black.withOpacity(0.6),
    "Palette.textSecondary50": Colors.black.withOpacity(0.5),
    "Palette.textSecondary40": Colors.black.withOpacity(0.4),
    "Palette.textSecondary30": Colors.black.withOpacity(0.3),
    "Palette.textSecondary20": Colors.black.withOpacity(0.2),
    "Palette.textSecondary10": Colors.black.withOpacity(0.1),
    "Palette.textDisabled": Color(0xFFD9D9D9),
    "Palette.textAccent": Color(0xFFA92217),
    "Palette.textPrimaryInverse": Colors.white
  };
  /*Color backgroundPrimary = Colors.white;
  Color backgroundSecondary = Color(0xFFF1F1F1);
  Color black = Colors.black;
  Color white = Colors.white;
  Color accent = Color(0xFFA92217);
  Color textPrimary = Colors.black;
  Color textSecondary90 = Colors.black.withOpacity(0.9);
  Color textSecondary80 = Colors.black.withOpacity(0.8);
  Color textSecondary70 = Colors.black.withOpacity(0.7);
  Color textSecondary60 = Colors.black.withOpacity(0.6);
  Color textSecondary50 = Colors.black.withOpacity(0.5);
  Color textSecondary40 = Colors.black.withOpacity(0.4);
  Color textSecondary30 = Colors.black.withOpacity(0.3);
  Color textSecondary20 = Colors.black.withOpacity(0.2);
  Color textSecondary10 = Colors.black.withOpacity(0.1);
  Color textDisabled = Color(0xFFD9D9D9);
  Color textAccent = Color(0xFFA92217);
  Color textPrimaryInverse = Colors.white;*/
}

class DarkPalette {
  Map<String, Color> colors = {
    "Palette.backgroundPrimary": Colors.black,
    "Palette.backgroundSecondary": Color(0xFF2D2D2D),
    "Palette.black": Colors.black,
    "Palette.white": Colors.white,
    "Palette.accent": Color(0xFFA92217),
    "Palette.textPrimary": Colors.white,
    "Palette.textSecondary90": Colors.white.withOpacity(0.9),
    "Palette.textSecondary80": Colors.white.withOpacity(0.8),
    "Palette.textSecondary70": Colors.white.withOpacity(0.7),
    "Palette.textSecondary60": Colors.white.withOpacity(0.6),
    "Palette.textSecondary50": Colors.white.withOpacity(0.5),
    "Palette.textSecondary40": Colors.white.withOpacity(0.4),
    "Palette.textSecondary30": Colors.white.withOpacity(0.3),
    "Palette.textSecondary20": Colors.white.withOpacity(0.2),
    "Palette.textSecondary10": Colors.white.withOpacity(0.1),
    "Palette.textDisabled": Colors.white.withOpacity(0.4),
    "Palette.textAccent": Color(0xFFA92217),
    "Palette.textPrimaryInverse": Colors.black
  };
  /*Color backgroundPrimary = Colors.black;
  Color backgroundSecondary = Color(0xFF2D2D2D);
  Color black = Colors.black;
  Color white = Colors.white;
  Color accent = Color(0xFFA92217);
  Color textPrimary = Colors.white;
  Color textSecondary90 = Colors.white.withOpacity(0.9);
  Color textSecondary80 = Colors.white.withOpacity(0.8);
  Color textSecondary70 = Colors.white.withOpacity(0.7);
  Color textSecondary60 = Colors.white.withOpacity(0.6);
  Color textSecondary50 = Colors.white.withOpacity(0.5);
  Color textSecondary40 = Colors.white.withOpacity(0.4);
  Color textSecondary30 = Colors.white.withOpacity(0.3);
  Color textSecondary20 = Colors.white.withOpacity(0.2);
  Color textSecondary10 = Colors.white.withOpacity(0.1);
  Color textDisabled = Colors.white.withOpacity(40);
  Color textAccent = Color(0xFFA92217);
  Color textPrimaryInverse = Colors.black;*/
}
