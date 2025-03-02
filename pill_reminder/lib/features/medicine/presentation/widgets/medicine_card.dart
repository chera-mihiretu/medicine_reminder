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
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).hoverColor,
              spreadRadius: 1,
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            medicineName,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Remaining"),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(medicineRemaining.toString(),
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
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
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Theme.of(context).primaryColorDark,
                  ),
                  child: Center(
                    child: Image.asset("assets/images/drugs.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
