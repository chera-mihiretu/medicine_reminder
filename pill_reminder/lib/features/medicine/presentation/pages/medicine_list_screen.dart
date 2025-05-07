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
import 'package:pill_reminder/permissions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MedicineListScreen extends StatelessWidget {
  static const routeName = '/medicine-list';
  const MedicineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyPermissions.requestNotificationPermissionFirstTime(context);
    BlocProvider.of<MedicineBloc>(context).add(GetMedicineListEvent());
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: colors.background,
        title: Text(
          'Medicine List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: colors.text,
            letterSpacing: 0.5,
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colors.buttonShadow,
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddMedicinePage.router);
          },
          backgroundColor: colors.primaryButton,
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: colors.primaryIcon, size: 28),
        ),
      ),
      body: SafeArea(
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
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: colors.glassBackground,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: colors.glassBorder,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colors.cardShadow,
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.medication_outlined,
                          size: 80,
                          color: colors.primaryButton.withAlpha(70),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'No Medicines Yet',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colors.text,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Add your first medicine by tapping the + button',
                          style: TextStyle(
                            fontSize: 16,
                            color: colors.greyText,
                            height: 1.5,
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
                  context.read<MedicineBloc>().add(GetMedicineListEvent());
                },
                color: colors.primaryButton,
                backgroundColor: colors.background,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.medicines.length,
                  itemBuilder: (context, index) {
                    final medicine = state.medicines[index];
                    int rem = medicine.medicineAmount - medicine.medicineTaken;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: MedicineCard(
                        onDetail: () {
                          Navigator.of(context).pushNamed(
                            MedicineDetail.routeName,
                            arguments: index,
                          );
                        },
                        lastTaken: medicine.lastTriggered,
                        medicineName: medicine.name,
                        totalMedicine: medicine.medicineAmount,
                        medicineRemaining: rem,
                        onDelete: () {},
                      ),
                    );
                  },
                ),
              );
            } else if (state is MedicineErrorState) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colors.glassBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colors.glassBorder),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: colors.error),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        style: TextStyle(color: colors.text, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is MedicineInitialState) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<MedicineBloc>().add(GetMedicineListEvent());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primaryButton,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                    shadowColor: colors.buttonShadow,
                  ),
                  child: Text(
                    'Refresh',
                    style: TextStyle(
                      color: colors.primaryButtonText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colors.glassBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colors.glassBorder),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 48,
                        color: colors.warning,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Something went wrong',
                        style: TextStyle(color: colors.text, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(ColorHub colors) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colors.cardShadow,
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Shimmer.fromColors(
                baseColor: colors.card,
                highlightColor: colors.card.withAlpha(150),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: colors.card,
                        highlightColor: colors.card.withAlpha(150),
                        child: Container(
                          width: 80,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: colors.card,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: colors.card,
                              highlightColor: colors.card.withAlpha(150),
                              child: Container(
                                width: 150,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: colors.card,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Shimmer.fromColors(
                              baseColor: colors.card,
                              highlightColor: colors.card.withAlpha(150),
                              child: Container(
                                width: double.infinity,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: colors.card,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Shimmer.fromColors(
                              baseColor: colors.card,
                              highlightColor: colors.card.withAlpha(150),
                              child: Container(
                                width: double.infinity,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: colors.card,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Shimmer.fromColors(
                              baseColor: colors.card,
                              highlightColor: colors.card.withAlpha(150),
                              child: Container(
                                width: double.infinity,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: colors.card,
                                  borderRadius: BorderRadius.circular(2),
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
          ),
        );
      },
    );
  }
}
