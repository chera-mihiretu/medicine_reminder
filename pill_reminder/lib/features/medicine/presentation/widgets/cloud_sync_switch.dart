import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class CloudSyncSwitch extends StatefulWidget {
  final bool initialValue;
  final Function(bool) onChanged;

  const CloudSyncSwitch({
    super.key,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<CloudSyncSwitch> createState() => _CloudSyncSwitchState();
}

class _CloudSyncSwitchState extends State<CloudSyncSwitch> {
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;

    return Switch(
      value: _isEnabled,
      onChanged: (value) {
        setState(() {
          _isEnabled = value;
        });
        widget.onChanged(value);
      },
      activeColor: colors.primaryButton,
    );
  }
}
