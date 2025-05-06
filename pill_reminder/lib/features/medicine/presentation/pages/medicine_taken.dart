import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MedicineTaken extends StatefulWidget {
  static const routeName = '/medicine-taken';
  const MedicineTaken({super.key});

  @override
  State<MedicineTaken> createState() => _MedicineTakenState();
}

class _MedicineTakenState extends State<MedicineTaken>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medicine =
        ModalRoute.of(context)!.settings.arguments as MedicineModel;
    final isCompleted = medicine.medicineTaken >= medicine.medicineAmount;
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('Medicine Taken', style: TextStyle(color: colors.text)),
        centerTitle: true,
        backgroundColor: colors.background,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: (isCompleted ? Colors.green : Colors.blue).withAlpha(
                      25,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted ? Icons.celebration : Icons.check_circle,
                    color: isCompleted ? Colors.green : Colors.blue,
                    size: 100,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                isCompleted ? 'Congratulations!' : 'Well Done!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? Colors.green : Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You\'ve taken ${medicine.name}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                'Amount: ${medicine.medicineAmount}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                'Total taken: ${medicine.medicineTaken} times',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              if (isCompleted)
                Lottie.asset(
                  'assets/animations/celebration.json',
                  width: 200,
                  height: 200,
                  repeat: true,
                )
              else
                Lottie.asset(
                  'assets/animations/continue.json',
                  width: 200,
                  height: 200,
                  repeat: true,
                ),
              const SizedBox(height: 24),
              Text(
                isCompleted
                    ? 'You\'ve completed your medicine course!'
                    : 'Keep up the good work!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isCompleted ? Colors.green : Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
