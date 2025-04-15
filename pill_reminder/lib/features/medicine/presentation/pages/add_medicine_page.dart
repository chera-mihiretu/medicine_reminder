import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_event.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_state.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/custom_input.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/loading_popup.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/medicine_mode.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/medicine_time.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddMedicinePage extends StatelessWidget {
  static const String router = '/add-medicine';

  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController intervalController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController takenAmountController = TextEditingController();
  final TextEditingController specificTimeController = TextEditingController();
  final List<TextEditingController> specificTimeControllers = [];
  final List<TimeOfDay> selectedTime = [];
  MedicineMode medicineMode = MedicineMode.interval;

  AddMedicinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: colors.icon),
        ),
        title: Text(
          "Add Medicine",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colors.text,
          ),
        ),
        backgroundColor: colors.background,
      ),
      backgroundColor: colors.background,
      body: BlocListener<MedicineBloc, MedicineState>(
        listener: (context, state) {
          log(state.toString());
          if (state is MedicineErrorState) {
          } else if (state is MedicineAddedState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Medicine Added")));
          } else if (state is MedicineLoadingState) {
            log('The add is Loading ');
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: colors.card,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: colors.divider, width: .5),
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Theme.of(context).shadowColor,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomInput(
                        controller: medicineNameController,
                        hintText: "Medicine Name",
                      ),

                      // Display corresponding field based on selected mode
                      MedicineTime(
                        selectedTime: selectedTime,
                        medicineMode: medicineMode,
                        onModeChange: (newMode) {
                          medicineMode = newMode;
                        },
                        intervalController: intervalController,
                        specificTimeCotrollers: specificTimeControllers,
                      ),

                      // Other inputs (if needed)
                      CustomInput(
                        hintText: "Medicine Total Amount",
                        controller: totalAmountController,
                      ),

                      CustomInput(
                        controller: takenAmountController,
                        hintText: "Medicine Taken Amount",
                      ),

                      ElevatedButton(
                        onPressed: () {
                          int? interval;
                          List<TimeOfDay>? specificTime;

                          if (medicineMode == MedicineMode.interval) {
                            if (intervalController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Interval is required")),
                              );
                              return;
                            }
                            interval = int.parse(intervalController.text);
                          } else {
                            specificTime = selectedTime;
                          }

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return const LoadingPopup();
                            },
                          );

                          BlocProvider.of<MedicineBloc>(context).add(
                            AddMedicineEvent(
                              name: medicineNameController.text,
                              interval: interval,
                              time: specificTime,
                              startDate: DateTime.now(),
                              medicineAmount: int.parse(
                                totalAmountController.text,
                              ),
                              medicineTaken:
                                  takenAmountController.text.isEmpty
                                      ? 0
                                      : int.parse(takenAmountController.text),
                              lastTriggered: TimeOfDay.now(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          backgroundColor: colors.primaryButton,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Add Medicine",
                          style: TextStyle(color: colors.primaryButtonText),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
