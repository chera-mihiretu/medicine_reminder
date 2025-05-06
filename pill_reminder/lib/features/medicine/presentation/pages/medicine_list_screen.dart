import 'dart:developer';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/cores/theme/color_hub.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_event.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_state.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/add_medicine_page.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/medicine_detail.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/medicine_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
                      return _buildShimmerLoading(colors);
                    } else if (state is MedicineLoadedState) {
                      if (state.medicines.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.medication_outlined,
                                size: 80,
                                color: colors.primaryButton.withAlpha(78),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "No Medicines Yet",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: colors.text,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                ),
                                child: Text(
                                  "Add your first medicine by tapping the + button",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: colors.text.withAlpha(100),
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<MedicineBloc>().add(
                            GetMedicineListEvent(),
                          );
                          // Add artificial delay
                          await Future.delayed(const Duration(seconds: 1));
                        },
                        child: ListView.builder(
                          itemCount: state.medicines.length,
                          itemBuilder: (context, index) {
                            final medicine = state.medicines[index];
                            int rem =
                                medicine.medicineAmount -
                                medicine.medicineTaken;
                            log(medicine.toString());
                            return MedicineCard(
                              onDetail: () {
                                Navigator.of(context).pushNamed(
                                  MedicineDetail.routeName,
                                  arguments: index,
                                );
                              },
                              medicineName: medicine.name,
                              totalMedicine: medicine.medicineAmount,
                              medicineRemaining: rem,
                              onDelete: () {},
                            );
                          },
                        ),
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

  Widget _buildShimmerLoading(ColorHub colors) {
    return Shimmer.fromColors(
      baseColor: colors.background,
      highlightColor: colors.primaryButton.withOpacity(0.1),
      child: ListView.builder(
        itemCount: 5, // Show 5 shimmer items while loading
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: colors.shadow.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 100,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
