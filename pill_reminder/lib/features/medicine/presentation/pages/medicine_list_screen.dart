import 'package:flutter/material.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/medicine_card.dart';

class MedicineListScreen extends StatelessWidget {
  static const routeName = '/medicine-list';
  const MedicineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 10, right: 0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      backgroundColor: Colors.blue[900],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                    ),
                    child: const Text("Add Medicine"),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 0, right: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      backgroundColor: Colors.red[900],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                    ),
                    child: const Text("Remove Medicine"),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with your dynamic item count
              itemBuilder: (context, index) {
                return const MedicineCard();
              },
            ),
          ),
        ],
      ),
    ));
  }
}
