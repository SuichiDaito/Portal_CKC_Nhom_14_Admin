import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoRowDateField extends StatelessWidget {
  final String label;
  final String dateStr;
  final bool isEditing;
  final VoidCallback? onSelectDate;

  const InfoRowDateField({
    super.key,
    required this.label,
    required this.dateStr,
    required this.isEditing,
    this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('yyyy-MM-dd').parse(dateStr);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text(label)),
          Expanded(
            child: GestureDetector(
              onTap: isEditing ? onSelectDate : null,
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
                child: Text(DateFormat('dd/MM/yyyy').format(date)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
