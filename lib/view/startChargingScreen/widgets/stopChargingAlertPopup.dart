import 'package:flutter/material.dart';

// class for building up an alert dialogue box for stopping the charging

class StopChargingAlertPopUp extends StatelessWidget {
  const StopChargingAlertPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ALERT...!!!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
      content:
          const Expanded(child: Text('Are you sure you want to stop charging')),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }, child: const Text('Yes')),
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text('No'))
      ],
    );
  }
}
