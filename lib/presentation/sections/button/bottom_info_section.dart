import 'package:flutter/material.dart';

class BottomInfoSection extends StatelessWidget {
  final String month;
  final String year;

  const BottomInfoSection({super.key, required this.month, required this.year});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 12),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Tháng $month - Năm $year',
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
