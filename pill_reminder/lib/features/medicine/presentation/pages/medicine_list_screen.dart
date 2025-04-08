import 'package:flutter/material.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/add_medicine_page.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/medicine_card.dart';

class MedicineListScreen extends StatelessWidget {
  static const routeName = '/medicine-list';
  const MedicineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Medicine List",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddMedicinePage.router);
          },
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          child: Icon(
            Icons.add,
            color: Theme.of(context).primaryColor,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 10, // Replace with your actual item count
                  itemBuilder: (context, index) {
                    return MedicineCard(
                      medicineName: "Cloxa",
                      mecineRemainingPercent: (index * 46) % 100 + 1,
                      medicineRemaining: 12,
                      onDelete: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
