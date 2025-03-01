import 'package:flutter/widgets.dart';
import 'package:pill_reminder/cores/theme/my_theme.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            decoration: BoxDecoration(
              color: MyTheme.lightTheme.primaryColorLight,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(
                  10,
                ),
                topLeft: Radius.circular(
                  10,
                ),
              ),
            ),
            child: Column(children: [
              Text(name),
            ]),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            margin: const EdgeInsets.only(right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: MyTheme.lightTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(
                  10,
                ),
                topRight: Radius.circular(
                  10,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
