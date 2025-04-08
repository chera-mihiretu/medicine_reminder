import 'package:flutter/material.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/custom_progress.dart';

class MedicineCard extends StatelessWidget {
  final String medicineName;
  final int mecineRemainingPercent;
  final int medicineRemaining;

  final Map<int, Color> colorMap = {
    0: Colors.red,
    25: Colors.orange,
    50: Colors.yellow,
    75: Colors.green,
    100: Colors.blue,
  };

  Color getColor(int percent) {
    if (percent <= 25) {
      return colorMap[0]!;
    } else if (percent <= 50) {
      return colorMap[25]!;
    } else if (percent <= 75) {
      return colorMap[50]!;
    } else if (percent <= 100) {
      return colorMap[75]!;
    }
    return colorMap[100]!;
  }

  final VoidCallback onDelete;

  MedicineCard(
      {super.key,
      required this.medicineName,
      required this.mecineRemainingPercent,
      required this.medicineRemaining,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).hoverColor,
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: getColor(mecineRemainingPercent)
                                  .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(Icons.medical_services_rounded,
                                size: 40,
                                color: getColor(mecineRemainingPercent)),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            children: [
                              Text(
                                medicineName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                "8:00 AM",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: onDelete,
                              icon: Icon(Icons.delete,
                                  size: 30,
                                  color: Theme.of(context).iconTheme.color),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.pending,
                              size: 20,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Remaining $medicineRemaining",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              child: Icon(Icons.done,
                                  size: 16,
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Taken ${medicineRemaining * (100 - mecineRemainingPercent) ~/ mecineRemainingPercent}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomProgress(
                        percent: mecineRemainingPercent,
                        color: getColor(mecineRemainingPercent)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
