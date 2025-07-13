import 'package:flutter/material.dart';

class CustomTimePickerRow extends StatelessWidget {
  final String label;
  final TimeOfDay time;
  final void Function(TimeOfDay?) onPicked;

  const CustomTimePickerRow({
    super.key,
    required this.label,
    required this.time,
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
              final picked = await showTimePicker(
                context: context,
                initialTime: time,
              );
              onPicked(picked);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              backgroundColor: Colors.grey.shade100,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
