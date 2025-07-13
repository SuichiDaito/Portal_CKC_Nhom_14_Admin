import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoRowTimeField extends StatelessWidget {
  final String label;
  final String timeStr;
  final bool isEditing;
  final VoidCallback? onSelectTime;

  const InfoRowTimeField({
    super.key,
    required this.label,
    required this.timeStr,
    required this.isEditing,
    this.onSelectTime,
  });

  String get formattedTime {
    if (timeStr.split(':').length == 3) {
      return DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(timeStr));
    } else {
      return DateFormat('HH:mm').format(DateFormat('HH:mm').parse(timeStr));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text(label)),
          Expanded(
            child: GestureDetector(
              onTap: isEditing ? onSelectTime : null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.shade100,
                ),
                child: Text(formattedTime),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
