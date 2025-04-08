import 'package:flutter/material.dart';

class CustomProgress extends StatelessWidget {
  final int percent;
  const CustomProgress({super.key, required this.percent, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      LinearProgressIndicator(
        minHeight: 10,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        color: color,
        backgroundColor: Theme.of(context).hoverColor,
        value: percent / 100,
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(percent == 100 ? 'Completed' : 'In progress',
              style: Theme.of(context).textTheme.bodyLarge),
          Text(
            "$percent%",
            style: TextStyle(
              color: color,
              fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
    ]);
  }
}
