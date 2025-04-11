import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/color_data.dart';
import 'package:pill_reminder/cores/theme/color_hub.dart';

class ThemeProvider extends ChangeNotifier {
  ColorMode mode = ColorMode.LIGHT;
  ColorType type = ColorType.PRIMARY;

  ThemeProvider({required this.mode, required this.type});

  late ColorHub _colorHub;

  ThemeProvider.withDefaults() {
    _colorHub = ColorHub(mode: mode, type: type);
  }

  ColorMode get colorMode => mode;
  ColorType get colorType => type;
  ColorHub get colors => _colorHub;

  void setColorMode(ColorMode newMode) {
    mode = newMode;
    _colorHub = ColorHub(mode: mode, type: type);
    notifyListeners();
  }
}
