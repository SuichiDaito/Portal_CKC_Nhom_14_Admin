import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/pages/page_exam_schedule_admin.dart';

class ExamDutyCard extends StatelessWidget {
  final ExamDuty duty;

  const ExamDutyCard({required this.duty});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.supervisor_account, color: Colors.blue[700], size: 18),
              SizedBox(width: 6),
              Text(
                '${duty.invigilator1} & ${duty.invigilator2}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Ngày thi: ${duty.examDate}'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Bắt đầu: ${duty.startTime} | ${duty.duration} phút'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.meeting_room, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Phòng: ${duty.room}'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.check_circle, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Trạng thái: ${duty.status}'),
            ],
          ),
        ],
      ),
    );
  }
}
