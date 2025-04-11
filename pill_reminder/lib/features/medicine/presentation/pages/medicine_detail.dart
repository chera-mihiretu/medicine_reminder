import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MedicineDetail extends StatelessWidget {
  static const String routeName = '/medicine-detail';
  const MedicineDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final medicineName =
        ModalRoute.of(context)?.settings.arguments as String? ??
            'Unknown Medicine';
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: colors.text,
          ),
        ),
        title: Text(
          'Medicine Detail',
          style: TextStyle(color: colors.text),
        ),
        backgroundColor: colors.background,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: colors.card,
              shadowColor: colors.shadow,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: colors.divider,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  medicineName,
                  style: TextStyle(color: colors.text),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
