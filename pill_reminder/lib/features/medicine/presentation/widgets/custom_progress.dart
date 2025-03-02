import 'package:flutter/material.dart';

class CustomProgress extends StatelessWidget {
  final int percent;
  const CustomProgress({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 20,
          ),
          child: Text("In progress")),
      LinearProgressIndicator(
        minHeight: 40,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        value: percent / 100,
      ),
    ]);
  }
}
