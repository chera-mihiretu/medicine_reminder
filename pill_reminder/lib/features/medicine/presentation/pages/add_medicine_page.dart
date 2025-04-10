import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/color_hub.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/medicine_mode.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/custom_input.dart';
import 'package:provider/provider.dart';

class AddMedicinePage extends StatefulWidget {
  static const String router = '/add-medicine';
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  MedicineMode _mode = MedicineMode.interval;
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _intervalController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _takenAmountController = TextEditingController();

  // For specific time mode:
  final List<TextEditingController> _specificTimeControllers = [];

  Future<void> _pickSpecificTime(int index) async {
    final timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timePicked != null) {
      setState(() {
        _specificTimeControllers[index].text = timePicked.format(context);
      });
    }
  }

  void _addSpecificTimeField() {
    setState(() {
      _specificTimeControllers.add(TextEditingController());
    });
  }

  void _removeTime() {
    setState(() {
      if (_specificTimeControllers.length > 1) {
        _specificTimeControllers.removeLast();
      }
    });
  }

  @override
  void dispose() {
    _medicineNameController.dispose();
    _intervalController.dispose();
    for (final controller in _specificTimeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildModeToggle(ColorHub colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ChoiceChip(
            checkmarkColor: colors.primaryButtonText,
            backgroundColor: colors.disabled,
            selectedColor: colors.primaryButton,
            padding: const EdgeInsets.all(10),
            label: Text(
              "Interval",
              style: TextStyle(
                  color: _mode == MedicineMode.interval
                      ? colors.primaryButtonText
                      : colors.text),
            ),
            selected: _mode == MedicineMode.interval,
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  _mode = MedicineMode.interval;
                });
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ChoiceChip(
            checkmarkColor: colors.primaryButtonText,
            backgroundColor: colors.disabled,
            selectedColor: colors.primaryButton,
            label: Text(
              "Specific Time",
              style: TextStyle(
                  color: _mode == MedicineMode.specificTime
                      ? colors.primaryButtonText
                      : colors.text),
            ),
            selected: _mode == MedicineMode.specificTime,
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  _mode = MedicineMode.specificTime;
                  if (_specificTimeControllers.isEmpty) {
                    _addSpecificTimeField();
                  }
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCustomInput(ColorHub colors) {
    if (_mode == MedicineMode.interval) {
      return CustomInput(
        controller: _intervalController,
        hintText: "Interval (in hours)",
      );
    } else {
      return Column(
        children: [
          // List of time selection fields
          ..._specificTimeControllers.asMap().entries.map((entry) {
            int index = entry.key;
            TextEditingController controller = entry.value;
            return CustomInput(
              controller: controller,
              hintText: "Select time ${index + 1}",
              onTap: () => _pickSpecificTime(index),
            );
          }),
          // Button to add more time selection fields
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          side: BorderSide(
                            color: colors.primaryButton,
                            width: .4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _removeTime,
                        child: Text(
                          "Remove Time",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: colors.primaryButton),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          backgroundColor: colors.primaryButton,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _addSpecificTimeField,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.add,
                              color: colors.primaryIcon,
                            ),
                            Text(
                              "Add Time",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: colors.primaryButtonText),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      );
    }
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
          icon: const Icon(Icons.arrow_back_ios_new),
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              color: colors.card,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: colors.divider,
                  width: .5,
                ),
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
                      controller: _medicineNameController,
                      hintText: "Medicine Name",
                    ),
                    // Toggle for mode
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: _buildModeToggle(colors)),

                    // Display corresponding field based on selected mode
                    _buildCustomInput(colors),
                    // Other inputs (if needed)

                    CustomInput(
                      hintText: "Medicine Total Amount",
                      controller: _totalAmountController,
                    ),

                    CustomInput(
                        controller: _takenAmountController,
                        hintText: "Medicine Taken Amount"),

                    ElevatedButton(
                      onPressed: () {},
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
