import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/color_data.dart';

// ignore: must_be_immutable
class ColorHub extends Equatable {
  final ColorMode mode;
  final ColorType type;

  ColorHub({
    required this.mode,
    required this.type,
  });

  Map<ColorType, Map<ColorMode, Map<ContentColor, Color>>> colors = {
    ColorType.PRIMARY: {
      ColorMode.DARK: {
        ContentColor.BACKGROUND_COLOR: const Color.fromARGB(255, 33, 33, 34),
        ContentColor.PRIMARY_BUTTON_COLOR: const Color(0xFF2563EB),
        ContentColor.PRIMARY_BUTTON_TEXT_COLOR: const Color(0xFFFAFAFA),
        ContentColor.ERROR_BUTTON_COLOR: const Color(0xFFDC2626),
        ContentColor.ERROR_BUTTON_TEXT_COLOR: const Color(0xFFFAFAFA),
        ContentColor.GREY_TEXT_COLOR: const Color(0xFF999999),
        ContentColor.TEXT_COLOR: const Color(0xFFFAFAFA),
        ContentColor.ICON_COLOR: const Color(0xFFFAFAFA),
        ContentColor.PRIMARY_ICON_COLOR: const Color(0xFFFAFAFA),
        ContentColor.CARD_COLOR: const Color.fromARGB(255, 31, 33, 39),
        ContentColor.DIVIDER_COLOR: const Color.fromARGB(255, 65, 60, 60),
        ContentColor.ERROR_COLOR: const Color(0xFFDC2626),
        ContentColor.SUCCESS_COLOR: const Color(0xFF059669),
        ContentColor.WARNING_COLOR: const Color(0xFFFFDE22),
        ContentColor.INFO_COLOR: const Color(0xFF2196F3), // Custom color
        ContentColor.DISABLED_COLOR: const Color(0xFFBDBDBD),
        ContentColor.HINT_COLOR: const Color(0xFF999999),
        ContentColor.FOCUS_COLOR: const Color(0xFF90CAF9),
        ContentColor.SHADOW_COLOR: const Color.fromARGB(255, 21, 26, 34),
        ContentColor.INPUT_BACKROUND: const Color(0xFF424242),
        ContentColor.INPUT_HOVER: const Color(0xFF616161),
      },
      ColorMode.LIGHT: {
        ContentColor.BACKGROUND_COLOR: const Color(0xFFFAFAFA),
        ContentColor.PRIMARY_BUTTON_COLOR: const Color(0xFF1E40AF),
        ContentColor.PRIMARY_BUTTON_TEXT_COLOR: const Color(0xFFFAFAFA),
        ContentColor.ERROR_BUTTON_COLOR: const Color(0xFFDC2626),
        ContentColor.ERROR_BUTTON_TEXT_COLOR: const Color(0xFFFAFAFA),
        ContentColor.GREY_TEXT_COLOR: const Color(0xFF999999),
        ContentColor.TEXT_COLOR: const Color(0xFF2A2A2B),
        ContentColor.ICON_COLOR: const Color(0xFF2A2A2B),
        ContentColor.PRIMARY_ICON_COLOR: const Color(0xFFFAFAFA),
        ContentColor.CARD_COLOR: const Color(0xFFFAFAFA),
        ContentColor.DIVIDER_COLOR: const Color.fromARGB(255, 172, 172, 172),
        ContentColor.ERROR_COLOR: const Color(0xFFDC2626),
        ContentColor.SUCCESS_COLOR: const Color(0xFF059669),
        ContentColor.WARNING_COLOR: const Color(0xFFFFDE22),
        ContentColor.INFO_COLOR: const Color(0xFF2196F3), // Custom color
        ContentColor.DISABLED_COLOR: const Color(0xFFBDBDBD),
        ContentColor.HINT_COLOR: const Color(0xFF999999),
        ContentColor.FOCUS_COLOR: const Color(0xFF1E88E5),
        ContentColor.SHADOW_COLOR: const Color.fromARGB(255, 223, 223, 223),
        ContentColor.INPUT_BACKROUND: const Color(0xFFFFFFFF),
        ContentColor.INPUT_HOVER: const Color(0xFFEEEEEE),
      }
    }
  };

  Color get background => colors[type]![mode]![ContentColor.BACKGROUND_COLOR]!;
  Color get primaryButton =>
      colors[type]![mode]![ContentColor.PRIMARY_BUTTON_COLOR]!;
  Color get primaryButtonText =>
      colors[type]![mode]![ContentColor.PRIMARY_BUTTON_TEXT_COLOR]!;
  Color get errorButton =>
      colors[type]![mode]![ContentColor.ERROR_BUTTON_COLOR]!;
  Color get errorButtonText =>
      colors[type]![mode]![ContentColor.ERROR_BUTTON_TEXT_COLOR]!;
  Color get greyText => colors[type]![mode]![ContentColor.GREY_TEXT_COLOR]!;
  Color get text => colors[type]![mode]![ContentColor.TEXT_COLOR]!;
  Color get icon => colors[type]![mode]![ContentColor.ICON_COLOR]!;
  Color get card => colors[type]![mode]![ContentColor.CARD_COLOR]!;
  Color get divider => colors[type]![mode]![ContentColor.DIVIDER_COLOR]!;
  Color get error => colors[type]![mode]![ContentColor.ERROR_COLOR]!;
  Color get success => colors[type]![mode]![ContentColor.SUCCESS_COLOR]!;
  Color get warning => colors[type]![mode]![ContentColor.WARNING_COLOR]!;
  Color get info => colors[type]![mode]![ContentColor.INFO_COLOR]!;
  Color get disabled => colors[type]![mode]![ContentColor.DISABLED_COLOR]!;
  Color get hint => colors[type]![mode]![ContentColor.HINT_COLOR]!;
  Color get focus => colors[type]![mode]![ContentColor.FOCUS_COLOR]!;
  Color get shadow => colors[type]![mode]![ContentColor.SHADOW_COLOR]!;
  Color get primaryIcon =>
      colors[type]![mode]![ContentColor.PRIMARY_ICON_COLOR]!;
  Color get inputBackround =>
      colors[type]![mode]![ContentColor.INPUT_BACKROUND]!;
  Color get inputHover => colors[type]![mode]![ContentColor.INPUT_HOVER]!;

  @override
  List<Object?> get props => [mode, type];
}
