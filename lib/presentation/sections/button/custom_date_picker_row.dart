import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerRow extends StatelessWidget {
  final String label;
  final DateTime date;
  final void Function(DateTime?) onPicked;

  const CustomDatePickerRow({
    super.key,
    required this.label,
    required this.date,
    required this.onPicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text("$label:")),
        Expanded(
          child: TextButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2020),
                lastDate: DateTime(2035),
              );
              onPicked(picked);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              backgroundColor: Colors.grey.shade100,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(DateFormat('dd/MM/yyyy').format(date)),
            ),
          ),
        ),
      ],
    );
  }
}
