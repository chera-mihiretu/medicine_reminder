import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/custom_progress.dart';
import 'package:provider/provider.dart';

class MedicineCard extends StatelessWidget {
  final String medicineName;
  final int medicineRemaining;
  final int totalMedicine;
  final TimeOfDay lastTaken;

  final Map<int, Color> colorMap = {
    0: Colors.red,
    25: Colors.orange,
    75: Colors.green,
    100: Colors.blue,
  };

  Color getColor(int percent) {
    if (percent <= 33) {
      return colorMap[0]!;
    } else if (percent <= 75) {
      return colorMap[25]!;
    } else if (percent <= 100) {
      return colorMap[75]!;
    }
    return colorMap[100]!;
  }

  final VoidCallback onDelete;
  final VoidCallback onDetail;
  MedicineCard({
    super.key,
    required this.onDetail,
    required this.medicineName,
    required this.medicineRemaining,
    required this.onDelete,
    required this.totalMedicine,
    required this.lastTaken,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onDetail,
        child: Container(
          decoration: BoxDecoration(
            color: colors.card,
            boxShadow: [
              BoxShadow(color: colors.shadow, spreadRadius: 2, blurRadius: 3),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: getColor(
                      (((totalMedicine - medicineRemaining) * 100) ~/
                          totalMedicine),
                    ).withValues(alpha: 0.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.medical_services_rounded,
                      size: 45,
                      color: getColor(
                        ((totalMedicine - medicineRemaining) * 100) ~/
                            totalMedicine,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  medicineName,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: colors.text,
                                  ),
                                ),
                                Text(
                                  '${(lastTaken.hour % 12) + 1}:${lastTaken.minute} ${['AM', 'PM'][lastTaken.hour ~/ 12]}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: colors.greyText),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: .4,
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(color: colors.divider),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.pending,
                                  size: 18,
                                  color: colors.icon,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Remaining $medicineRemaining',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: colors.greyText),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: colors.shadow,
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.done,
                                    size: 14,
                                    color: colors.icon,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Taken ${totalMedicine - medicineRemaining}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: colors.greyText),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: CustomProgress(
                          percent:
                              ((totalMedicine - medicineRemaining) * 100) ~/
                              totalMedicine,
                          color: getColor(
                            ((totalMedicine - medicineRemaining) * 100) ~/
                                totalMedicine,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
