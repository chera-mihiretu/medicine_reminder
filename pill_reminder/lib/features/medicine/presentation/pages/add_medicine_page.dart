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
import 'package:pill_reminder/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_event.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddMedicinePage extends StatelessWidget {
  static const String router = '/add-medicine';

  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController intervalController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController takenAmountController = TextEditingController();
  final TextEditingController specificTimeController = TextEditingController();
  final TextEditingController lastTakenController = TextEditingController();
  final List<TextEditingController> specificTimeControllers = [];
  final List<TimeOfDay> selectedTime = [];
  final List<TimeOfDay> lastTakenTime = [TimeOfDay.now()];
  MedicineMode medicineMode = MedicineMode.interval;

  AddMedicinePage({super.key});

  String? validateInputs(BuildContext context) {
    // Validate medicine name
    if (medicineNameController.text.trim().isEmpty) {
      return 'Medicine name is required';
    }

    // Validate medicine amount
    if (totalAmountController.text.trim().isEmpty) {
      return 'Total medicine amount is required';
    }

    final totalAmount = int.tryParse(totalAmountController.text);
    if (totalAmount == null || totalAmount <= 0) {
      return 'Total medicine amount must be greater than 0';
    }

    // Validate taken amount if provided
    if (takenAmountController.text.trim().isNotEmpty) {
      final takenAmount = int.tryParse(takenAmountController.text);
      if (takenAmount == null) {
        return 'Invalid taken amount';
      }
      if (takenAmount > totalAmount) {
        return 'Taken amount cannot be greater than total amount';
      }
    }

    // Validate interval or specific time based on mode
    if (medicineMode == MedicineMode.interval) {
      if (intervalController.text.trim().isEmpty) {
        return 'Interval is required';
      }
      final interval = double.tryParse(intervalController.text);
      if (interval == null || interval < 0.02) {
        return 'Interval must be atleast 0.02';
      }
    } else {
      if (selectedTime.isEmpty) {
        return 'Please add at least one specific time for the medicine';
      } else {
        if (specificTimeControllers[0].text.trim().isEmpty) {
          return 'You are not allowed to add empty time';
        }
      }
      if (selectedTime.length > 5) {
        return 'Maximum 5 specific times can be added';
      }
    }

    return null;
  }

  Future<void> handleAddMedicine(BuildContext context) async {
    final validationError = validateInputs(context);
    if (validationError != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(validationError)));
      return;
    }

    double? interval;
    List<TimeOfDay>? specificTime;

    if (medicineMode == MedicineMode.interval) {
      interval = double.parse(intervalController.text);
    } else {
      specificTime = selectedTime;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingPopup(),
    );

    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;

    BlocProvider.of<MedicineBloc>(context).add(
      AddMedicineEvent(
        name: medicineNameController.text.trim(),
        interval: interval,
        time: specificTime,
        startDate: DateTime.now(),
        medicineAmount: int.parse(totalAmountController.text),
        medicineTaken:
            takenAmountController.text.isEmpty
                ? 0
                : int.parse(takenAmountController.text),
        lastTriggered: lastTakenTime[0],
      ),
    );

    BlocProvider.of<NotificationBloc>(context).add(ScheduleNotificationEvent());
  }

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
          'Add Medicine',
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
          } else if (state is MedicineAddedState) {
            BlocProvider.of<MedicineBloc>(context).add(GetMedicineListEvent());
            Navigator.pop(context);
            Navigator.pop(context);
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

                      // Display corresponding field based on selected mode
                      MedicineTime(
                        selectedTime: selectedTime,
                        medicineMode: medicineMode,
                        lastTakenController: lastTakenController,
                        lastTakenTime: lastTakenTime,
                        onModeChange: (newMode) {
                          medicineMode = newMode;
                        },
                        intervalController: intervalController,
                        specificTimeCotrollers: specificTimeControllers,
                      ),

                      // Other inputs (if needed)
                      CustomInput(
                        hintText: 'Medicine Total Amount',
                        controller: totalAmountController,
                        keyboardType: TextInputType.number,
                      ),

                      CustomInput(
                        controller: takenAmountController,
                        hintText: 'Medicine Taken Amount',
                        keyboardType: TextInputType.number,
                      ),

                      ElevatedButton(
                        onPressed: () => handleAddMedicine(context),
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
                          'Add Medicine',
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
