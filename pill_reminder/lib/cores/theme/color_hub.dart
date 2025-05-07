import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/color_data.dart';

// ignore: must_be_immutable
class ColorHub extends Equatable {
  final ColorMode mode;
  final ColorType type;

  ColorHub({required this.mode, required this.type});

  Map<ColorType, Map<ColorMode, Map<ContentColor, Color>>> colors = {
    ColorType.PRIMARY: {
      ColorMode.DARK: {
        ContentColor.BACKGROUND_COLOR: const Color.fromARGB(255, 18, 18, 20),
        ContentColor.PRIMARY_BUTTON_COLOR: const Color(0xFF2563EB),
        ContentColor.PRIMARY_BUTTON_TEXT_COLOR: const Color(0xFFFAFAFA),
        ContentColor.ERROR_BUTTON_COLOR: const Color(0xFFDC2626),
        ContentColor.ERROR_BUTTON_TEXT_COLOR: const Color(0xFFFAFAFA),
        ContentColor.GREY_TEXT_COLOR: const Color(0xFF999999),
        ContentColor.TEXT_COLOR: const Color(0xFFFAFAFA),
        ContentColor.ICON_COLOR: const Color(0xFFFAFAFA),
        ContentColor.PRIMARY_ICON_COLOR: const Color(0xFFFAFAFA),
        ContentColor.CARD_COLOR: const Color.fromARGB(255, 28, 28, 32),
        ContentColor.INTERNAL_CARD: const Color.fromARGB(255, 35, 35, 40),
        ContentColor.DIVIDER_COLOR: const Color.fromARGB(255, 45, 45, 50),
        ContentColor.ERROR_COLOR: const Color(0xFFDC2626),
        ContentColor.SUCCESS_COLOR: const Color(0xFF059669),
        ContentColor.WARNING_COLOR: const Color(0xFFFFDE22),
        ContentColor.INFO_COLOR: const Color(0xFF2196F3),
        ContentColor.DISABLED_COLOR: const Color(0xFFBDBDBD),
        ContentColor.HINT_COLOR: const Color(0xFF999999),
        ContentColor.FOCUS_COLOR: const Color(0xFF90CAF9),
        ContentColor.SHADOW_COLOR: const Color.fromARGB(255, 15, 15, 20),
        ContentColor.INPUT_BACKGROUND: const Color(0xFF2A2A2E),
        ContentColor.INPUT_HOVER: const Color(0xFF35353A),
        ContentColor.PROGRESS_COLOR: const Color(0xFF3B82F6),
        ContentColor.PROGRESS_BACKGROUND_COLOR: const Color(0xFF2A2A2E),
        ContentColor.GLASS_BACKGROUND: const Color.fromARGB(30, 255, 255, 255),
        ContentColor.GLASS_BORDER: const Color.fromARGB(40, 255, 255, 255),
        ContentColor.GRADIENT_START: const Color(0xFF2563EB),
        ContentColor.GRADIENT_END: const Color(0xFF1D4ED8),
        ContentColor.ACCENT_COLOR: const Color(0xFF3B82F6),
        ContentColor.HIGHLIGHT_COLOR: const Color(0xFF60A5FA),
        ContentColor.CARD_SHADOW: const Color.fromARGB(40, 0, 0, 0),
        ContentColor.BUTTON_SHADOW: const Color.fromARGB(60, 37, 99, 235),
        ContentColor.GLOW_COLOR: const Color.fromARGB(40, 59, 130, 246),
      },
      ColorMode.LIGHT: {
        ContentColor.BACKGROUND_COLOR: const Color(0xFFF8FAFC),
        ContentColor.PRIMARY_BUTTON_COLOR: const Color(0xFF1E40AF),
        ContentColor.PRIMARY_BUTTON_TEXT_COLOR: const Color(0xFFFAFAFA),
        ContentColor.ERROR_BUTTON_COLOR: const Color(0xFFDC2626),
        ContentColor.ERROR_BUTTON_TEXT_COLOR: const Color(0xFFFAFAFA),
        ContentColor.GREY_TEXT_COLOR: const Color(0xFF64748B),
        ContentColor.TEXT_COLOR: const Color(0xFF1E293B),
        ContentColor.ICON_COLOR: const Color(0xFF1E293B),
        ContentColor.PRIMARY_ICON_COLOR: const Color(0xFFFAFAFA),
        ContentColor.CARD_COLOR: const Color(0xFFFFFFFF),
        ContentColor.INTERNAL_CARD: const Color(0xFFF1F5F9),
        ContentColor.DIVIDER_COLOR: const Color(0xFFE2E8F0),
        ContentColor.ERROR_COLOR: const Color(0xFFDC2626),
        ContentColor.SUCCESS_COLOR: const Color(0xFF059669),
        ContentColor.WARNING_COLOR: const Color(0xFFFFDE22),
        ContentColor.INFO_COLOR: const Color(0xFF2196F3),
        ContentColor.DISABLED_COLOR: const Color(0xFFBDBDBD),
        ContentColor.HINT_COLOR: const Color(0xFF94A3B8),
        ContentColor.FOCUS_COLOR: const Color(0xFF1E88E5),
        ContentColor.SHADOW_COLOR: const Color.fromARGB(20, 0, 0, 0),
        ContentColor.INPUT_BACKGROUND: const Color(0xFFFFFFFF),
        ContentColor.INPUT_HOVER: const Color(0xFFF8FAFC),
        ContentColor.PROGRESS_COLOR: const Color(0xFF3B82F6),
        ContentColor.PROGRESS_BACKGROUND_COLOR: const Color(0xFFE2E8F0),
        ContentColor.GLASS_BACKGROUND: const Color.fromARGB(20, 255, 255, 255),
        ContentColor.GLASS_BORDER: const Color.fromARGB(30, 255, 255, 255),
        ContentColor.GRADIENT_START: const Color(0xFF1E40AF),
        ContentColor.GRADIENT_END: const Color(0xFF1E3A8A),
        ContentColor.ACCENT_COLOR: const Color(0xFF3B82F6),
        ContentColor.HIGHLIGHT_COLOR: const Color(0xFF60A5FA),
        ContentColor.CARD_SHADOW: const Color.fromARGB(20, 0, 0, 0),
        ContentColor.BUTTON_SHADOW: const Color.fromARGB(40, 30, 64, 175),
        ContentColor.GLOW_COLOR: const Color.fromARGB(30, 59, 130, 246),
      },
    },
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
  Color get inputBackground =>
      colors[type]![mode]![ContentColor.INPUT_BACKGROUND]!;
  Color get inputHover => colors[type]![mode]![ContentColor.INPUT_HOVER]!;

  Color get progressColor => colors[type]![mode]![ContentColor.PROGRESS_COLOR]!;
  Color get progressBackground =>
      colors[type]![mode]![ContentColor.PROGRESS_BACKGROUND_COLOR]!;
  Color get internalCard => colors[type]![mode]![ContentColor.INTERNAL_CARD]!;

  Color get glassBackground =>
      colors[type]![mode]![ContentColor.GLASS_BACKGROUND]!;
  Color get glassBorder => colors[type]![mode]![ContentColor.GLASS_BORDER]!;
  Color get gradientStart => colors[type]![mode]![ContentColor.GRADIENT_START]!;
  Color get gradientEnd => colors[type]![mode]![ContentColor.GRADIENT_END]!;
  Color get accent => colors[type]![mode]![ContentColor.ACCENT_COLOR]!;
  Color get highlight => colors[type]![mode]![ContentColor.HIGHLIGHT_COLOR]!;
  Color get cardShadow => colors[type]![mode]![ContentColor.CARD_SHADOW]!;
  Color get buttonShadow => colors[type]![mode]![ContentColor.BUTTON_SHADOW]!;
  Color get glow => colors[type]![mode]![ContentColor.GLOW_COLOR]!;

  @override
  List<Object?> get props => [mode, type];
}
