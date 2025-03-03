import 'package:flutter/material.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/add_medicine_page.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/medicine_card.dart';

class MedicineListScreen extends StatelessWidget {
  static const routeName = '/medicine-list';
  const MedicineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddMedicinePage.router);
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/pill.png",
                      width: 40,
                    ),
                    Text("Reminder",
                        style: Theme.of(context).textTheme.displayMedium),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10, // Replace with your actual item count
                  itemBuilder: (context, index) {
                    return const MedicineCard(
                      medicineName: "Cloxa",
                      mecineRemainingPercent: 80,
                      medicineRemaining: 12,
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
