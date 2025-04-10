import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/add_medicine_page.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/medicine_card.dart';
import 'package:provider/provider.dart';

class MedicineListScreen extends StatelessWidget {
  static const routeName = '/medicine-list';
  const MedicineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Medicine List",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: colors.text),
          ),
          backgroundColor: colors.background,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddMedicinePage.router);
          },
          backgroundColor: colors.primaryButton,
          shape: const CircleBorder(),
          child: Icon(
            Icons.add,
            color: colors.primaryIcon,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: colors.background),
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
              ),
            ],
          ),
        ));
  }
}
