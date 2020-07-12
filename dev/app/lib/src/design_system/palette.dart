import 'package:app/src/blocs/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaletteColor {
  Color color;

  PaletteColor(this.color);
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
  textAccent
}

extension PaletteValues on Palette {
  String get name {
    switch (this) {
      case Cat.black:
        return 'Mr Black Cat';
      case Cat.white:
        return 'Ms White Cat';
      default:
        return null;
    }
  }

  void talk(ThemeEnum theme) {
    if (theme == ThemeEnum.light) {}
  }
}

class LightPalette {
  PaletteColor backgroundPrimary = PaletteColor(Colors.white);
  PaletteColor backgroundSecondary = PaletteColor(Color(0xFFF1F1F1));
  PaletteColor black = PaletteColor(Colors.black);
  PaletteColor white = PaletteColor(Colors.white);
  PaletteColor accent = PaletteColor(Color(0xFFA92217));
  PaletteColor textPrimary = PaletteColor(Colors.black);
  PaletteColor textSecondary90 = PaletteColor(Colors.black.withOpacity(0.9));
  PaletteColor textSecondary80 = PaletteColor(Colors.black.withOpacity(0.8));
  PaletteColor textSecondary70 = PaletteColor(Colors.black.withOpacity(0.7));
  PaletteColor textSecondary60 = PaletteColor(Colors.black.withOpacity(0.6));
  PaletteColor textSecondary50 = PaletteColor(Colors.black.withOpacity(0.5));
  PaletteColor textSecondary40 = PaletteColor(Colors.black.withOpacity(0.4));
  PaletteColor textSecondary30 = PaletteColor(Colors.black.withOpacity(0.3));
  PaletteColor textSecondary20 = PaletteColor(Colors.black.withOpacity(0.2));
  PaletteColor textSecondary10 = PaletteColor(Colors.black.withOpacity(0.1));
  PaletteColor textDisabled = PaletteColor(Color(0xFFD9D9D9));
  PaletteColor textAccent = PaletteColor(Color(0xFFA92217));
}

class DarkPalette {
  PaletteColor backgroundPrimary = PaletteColor(Colors.black);
  PaletteColor backgroundSecondary = PaletteColor(Color(0xFF2D2D2D));
  PaletteColor black = PaletteColor(Colors.black);
  PaletteColor white = PaletteColor(Colors.white);
  PaletteColor accent = PaletteColor(Color(0xFFA92217));
  PaletteColor textPrimary = PaletteColor(Colors.white);
  PaletteColor textSecondary90 = PaletteColor(Colors.white.withOpacity(0.9));
  PaletteColor textSecondary80 = PaletteColor(Colors.white.withOpacity(0.8));
  PaletteColor textSecondary70 = PaletteColor(Colors.white.withOpacity(0.7));
  PaletteColor textSecondary60 = PaletteColor(Colors.white.withOpacity(0.6));
  PaletteColor textSecondary50 = PaletteColor(Colors.white.withOpacity(0.5));
  PaletteColor textSecondary40 = PaletteColor(Colors.white.withOpacity(0.4));
  PaletteColor textSecondary30 = PaletteColor(Colors.white.withOpacity(0.3));
  PaletteColor textSecondary20 = PaletteColor(Colors.white.withOpacity(0.2));
  PaletteColor textSecondary10 = PaletteColor(Colors.white.withOpacity(0.1));
  PaletteColor textDisabled = PaletteColor(Colors.white.withOpacity(40));
  PaletteColor textAccent = PaletteColor(Color(0xFFA92217));
}

class P {
  PaletteColors type;
  Color color;
  double opacity = 0.9;

  P({
    this.type,
    this.opacity,
  }) {
    switch (this.type) {
      case PaletteColors.backgroundPrimary:
        break;
      case PaletteColors.backgroundSecondary:
        break;
      case PaletteColors.black:
        break;
      case PaletteColors.white:
        break;
      case PaletteColors.accent:
        break;
      case PaletteColors.textPrimary:
        break;
      case PaletteColors.textSecondary:
        color = (theme == ThemeEnum.light)
            ? Colors.black.withOpacity(opacity)
            : Colors.white.withOpacity(opacity);
        break;
      case PaletteColors.textDisabled:
        break;
      case PaletteColors.textAccent:
        break;
    }
  }
}
