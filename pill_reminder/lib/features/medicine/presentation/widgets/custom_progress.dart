import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomProgress extends StatelessWidget {
  final int percent;
  const CustomProgress({super.key, required this.percent, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LinearProgressIndicator(
          minHeight: 10,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          color: color,
          backgroundColor: colors.background,
          value: percent / 100,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              percent == 100 ? 'Completed' : 'In progress',
              style: TextStyle(
                color: colors.text,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$percent%',
              style: TextStyle(
                color: color,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
