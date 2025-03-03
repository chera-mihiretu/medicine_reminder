import 'package:flutter/material.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/custom_progress.dart';

class MedicineCard extends StatelessWidget {
  final String medicineName;
  final int mecineRemainingPercent;
  final int medicineRemaining;

  const MedicineCard({
    super.key,
    required this.medicineName,
    required this.mecineRemainingPercent,
    required this.medicineRemaining,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).hoverColor,
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        medicineName,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Remaining",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            medicineRemaining.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Taken",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            medicineRemaining.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomProgress(percent: mecineRemainingPercent),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Image.asset("assets/images/drugs.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
