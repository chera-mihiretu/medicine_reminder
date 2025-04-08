import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onTap;
  const CustomInput(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onTap});

  OutlineInputBorder myBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
        width: .2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: TextField(
        controller: controller,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
          enabledBorder: myBorder(context),
          focusedBorder: myBorder(context),
          hoverColor: Theme.of(context).hoverColor,
        ),
      ),
    );
  }
}
