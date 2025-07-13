import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportDetailEditableSection extends StatelessWidget {
  final String selectedWeek;
  final DateTime selectedDate;
  final String selectedRoom;
  final TimeOfDay selectedTime;
  final List<String> weeks;
  final List<String> rooms;
  final ValueChanged<String> onWeekChanged;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<String> onRoomChanged;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const ReportDetailEditableSection({
    super.key,
    required this.selectedWeek,
    required this.selectedDate,
    required this.selectedRoom,
    required this.selectedTime,
    required this.weeks,
    required this.rooms,
    required this.onWeekChanged,
    required this.onDateChanged,
    required this.onRoomChanged,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            const SizedBox(
              width: 90,
              child: Text(
                'Tuần:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: DropdownButton<String>(
                value: selectedWeek,
                isExpanded: true,
                items: weeks
                    .map((w) => DropdownMenuItem(value: w, child: Text(w)))
                    .toList(),
                onChanged: (val) => onWeekChanged(val!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const SizedBox(
              width: 90,
              child: Text(
                'Ngày:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) onDateChanged(picked);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  backgroundColor: Colors.grey.shade100,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
                ),
              ),
            ),
          ],
        ),
<<<<<<< HEAD
=======
        // Phòng và giờ sẽ được thêm tiếp nếu bạn gửi thêm phần code sau
>>>>>>> main
      ],
    );
  }
}
