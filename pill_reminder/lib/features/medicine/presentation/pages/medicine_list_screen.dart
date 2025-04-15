import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_event.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_state.dart';
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
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: colors.text,
          ),
        ),
        backgroundColor: colors.background,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddMedicinePage.router);
        },
        backgroundColor: colors.primaryButton,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: colors.primaryIcon),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: colors.background),
                child: BlocBuilder<MedicineBloc, MedicineState>(
                  builder: (context, state) {
                    if (state is MedicineLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MedicineLoadedState) {
                      if (state.medicines.isEmpty) {
                        return const Center(
                          child: Text("No medicines available"),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.medicines.length,
                        itemBuilder: (context, index) {
                          final medicine = state.medicines[index];
                          int rem =
                              medicine.medicineAmount - medicine.medicineTaken;
                          log(medicine.toString());
                          return MedicineCard(
                            onDetail: () {
                              // Navigator.of(
                              //   context,
                              // ).pushNamed(MedicineDetail.routeName);
                            },
                            medicineName: medicine.name,
                            totalMedicine: medicine.medicineAmount,
                            medicineRemaining: rem,
                            onDelete: () {},
                          );
                        },
                      );
                    } else if (state is MedicineErrorState) {
                      log(state.toString());
                      return Center(child: Text((state.message)));
                    } else if (state is MedicineInitialState) {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<MedicineBloc>().add(
                              GetMedicineListEvent(),
                            );
                          },
                          child: const Text("Refresh"),
                        ),
                      );
                    } else {
                      return const Center(child: Text("Something went wrong"));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
