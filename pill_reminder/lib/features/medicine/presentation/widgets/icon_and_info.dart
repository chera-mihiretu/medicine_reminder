import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class IconsAndInfo extends StatelessWidget {
  final IconData icons;
  final String title;
  final String info;
  const IconsAndInfo({
    super.key,
    required this.icons,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.progressBackground,
            boxShadow: [
              BoxShadow(color: colors.shadow, spreadRadius: 1, blurRadius: 1),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icons, color: colors.primaryButton, size: 30),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, color: colors.greyText)),
            Text(
              info,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16, color: colors.text),
            ),
          ],
        ),
      ],
    );
  }
}
