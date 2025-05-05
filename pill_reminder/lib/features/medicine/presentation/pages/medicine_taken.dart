import 'package:flutter/material.dart';
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';

class MedicineTaken extends StatelessWidget {
  static const routeName = '/medicine-taken';
  const MedicineTaken({super.key});

  @override
  Widget build(BuildContext context) {
    final medicine =
        ModalRoute.of(context)!.settings.arguments as MedicineModel;

    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Taken'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Well Done!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You\'ve taken ${medicine.name}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Amount: ${medicine.medicineAmount}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Total taken: ${medicine.medicineTaken} times',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
