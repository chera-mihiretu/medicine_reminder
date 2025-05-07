import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/color_hub.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  const CustomInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.onTap,
    this.keyboardType,
  });

  OutlineInputBorder myBorder(BuildContext context, ColorHub colors) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: colors.divider, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: TextField(
        controller: controller,
        onTap: onTap,
        cursorColor: colors.text,
        style: TextStyle(color: colors.text),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          fillColor: colors.inputBackground,
          hintStyle: TextStyle(color: colors.hint),
          label: Text(hintText, style: TextStyle(color: colors.hint)),
          filled: true,
          enabledBorder: myBorder(context, colors),
          focusedBorder: myBorder(context, colors),
          hoverColor: colors.inputHover,
        ),
      ),
    );
  }
}
