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

class EditMedicinePage extends StatelessWidget {
  static const String routeName = '/edit-medicine';
  final int medicineIndex;

  const EditMedicinePage({super.key, required this.medicineIndex});

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    return BlocBuilder<MedicineBloc, MedicineState>(
      builder: (context, state) {
        if (state is! MedicineLoadedState) {
          return const Center(child: CircularProgressIndicator());
        }

        final medicine = state.medicines[medicineIndex];
        final TextEditingController medicineNameController =
            TextEditingController(text: medicine.name);
        final TextEditingController intervalController = TextEditingController(
          text: medicine.interval?.toString() ?? '',
        );
        final TextEditingController lastTakenController =
            TextEditingController();

        final TextEditingController totalAmountController =
            TextEditingController(text: medicine.medicineAmount.toString());
        final TextEditingController takenAmountController =
            TextEditingController(text: medicine.medicineTaken.toString());
        final List<TimeOfDay> selectedTime = medicine.time ?? [];
        final List<TextEditingController> specificTimeControllers = [];
        final List<TimeOfDay> lastTakenTime = [TimeOfDay.now()];

        // Initialize specific time controllers if medicine uses specific times
        if (medicine.time != null && medicine.time!.isNotEmpty) {
          for (var time in medicine.time!) {
            int hour = time.hour;
            String period =
                time.period.toString().split('.').last.toUpperCase();

            // Convert to 12-hour format
            if (hour > 12) {
              hour -= 12;
            } else if (hour == 0) {
              hour = 12;
            }

            specificTimeControllers.add(
              TextEditingController(
                text: '$hour:${time.minute.toString().padLeft(2, '0')} $period',
              ),
            );
          }
        } else {
          // Add at least one controller if no times exist
          specificTimeControllers.add(TextEditingController());
        }

        MedicineMode medicineMode =
            medicine.interval != null
                ? MedicineMode.interval
                : MedicineMode.specificTime;

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
              'Edit Medicine',
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
              if (state is MedicineErrorState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is MedicineLoadedState) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
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
                            hintText: 'Medicine Name',
                          ),

                          MedicineTime(
                            selectedTime: selectedTime,
                            medicineMode: medicineMode,

                            onModeChange: (newMode) {
                              medicineMode = newMode;
                            },
                            intervalController: intervalController,
                            lastTakenController: lastTakenController,
                            specificTimeCotrollers: specificTimeControllers,
                            lastTakenTime: lastTakenTime,
                          ),

                          CustomInput(
                            hintText: 'Medicine Total Amount',
                            controller: totalAmountController,
                          ),

                          CustomInput(
                            controller: takenAmountController,
                            hintText: 'Medicine Taken Amount',
                          ),

                          ElevatedButton(
                            onPressed: () async {
                              double? interval;
                              List<TimeOfDay>? specificTime;

                              if (medicineMode == MedicineMode.interval) {
                                if (intervalController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Interval is required'),
                                    ),
                                  );
                                  return;
                                }
                                interval = double.parse(
                                  intervalController.text,
                                );
                              } else {
                                specificTime = selectedTime;
                              }

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const LoadingPopup(),
                              );

                              await Future.delayed(const Duration(seconds: 1));

                              // ignore: use_build_context_synchronously
                              BlocProvider.of<MedicineBloc>(context).add(
                                UpdataeMedicineEvent(
                                  medicineId: medicine.medicineId,
                                  name: medicineNameController.text,
                                  interval: interval,
                                  time: specificTime,
                                  startDate: medicine.startDate,
                                  medicineAmount: int.parse(
                                    totalAmountController.text,
                                  ),
                                  medicineTaken: int.parse(
                                    takenAmountController.text,
                                  ),
                                  lastTriggered: medicine.lastTriggered,
                                ),
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              backgroundColor: colors.primaryButton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Update Medicine',
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
      },
    );
  }
}
