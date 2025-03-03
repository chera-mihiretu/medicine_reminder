import 'package:flutter/material.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/medicine_mode.dart';

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

  Widget _buildModeToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: const Text("Interval"),
          selected: _mode == MedicineMode.interval,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _mode = MedicineMode.interval;
              });
            }
          },
        ),
        const SizedBox(width: 16),
        ChoiceChip(
          label: const Text("Specific Time"),
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
      ],
    );
  }

  Widget _buildCustomInput() {
    if (_mode == MedicineMode.interval) {
      return TextField(
        controller: _intervalController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Enter interval in minutes",
          labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
      );
    } else {
      return Column(
        children: [
          // List of time selection fields
          ..._specificTimeControllers.asMap().entries.map((entry) {
            int index = entry.key;
            TextEditingController controller = entry.value;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controller,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Select time ${index + 1}",
                  labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                ),
                onTap: () => _pickSpecificTime(index),
              ),
            );
          }),
          // Button to add more time selection fields
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                side:
                    BorderSide(color: Theme.of(context).canvasColor, width: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _addSpecificTimeField,
              child: const Text("Add Time"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                side:
                    BorderSide(color: Theme.of(context).canvasColor, width: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _removeTime,
              child: const Text("Remove Time"),
            ),
          ]),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/pill.png",
                    width: 40,
                  ),
                  Text("Add", style: Theme.of(context).textTheme.displayMedium),
                ],
              ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: _medicineNameController,
                decoration: InputDecoration(
                  hintText: "Medicine Name",
                  labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                ),
              ),
            ),
            // Toggle for mode
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _buildModeToggle()),
            // Display corresponding field based on selected mode
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _buildCustomInput()),
            // Other inputs (if needed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Medicine Total Amount",
                  labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Medicine Taken Amount",
                  labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                side:
                    BorderSide(color: Theme.of(context).canvasColor, width: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Add Medicine"),
            )
          ],
        ),
      ),
    );
  }
}
