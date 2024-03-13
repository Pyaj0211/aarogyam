import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewAppointmentScreen extends StatelessWidget {
  final String selectedOption;
  final String selectedPrice;
  final int selectedNumber;
  final List<TimeOfDay> selectedTimes;

  ViewAppointmentScreen({
    required this.selectedOption,
    required this.selectedPrice,
    required this.selectedNumber,
    required this.selectedTimes,
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        child: ListView(
          children: [
            ListTile(
            )
          ],
        ),
      ),
    );
  }
}
