// Schedule Card Widget
import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/pages/page_class_management_admin.dart';

class ScheduleCard extends StatelessWidget {
  final WeekSchedule schedule;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ScheduleCard({
    Key? key,
    required this.schedule,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayNames = [
      '',
      '',
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
    ];

    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(
            '${schedule.week}',
            style: TextStyle(color: Colors.blue[800]),
          ),
        ),
        title: Text(
          '${dayNames[schedule.dayOfWeek]} - Tiết ${schedule.startPeriod}-${schedule.endPeriod}',
        ),
        subtitle: Text('GV: ${schedule.instructor}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit, color: Colors.orange),
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
