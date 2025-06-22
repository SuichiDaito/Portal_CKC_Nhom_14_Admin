import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_detail_model.dart';

enum ClassType { lyThuyet, thucHanh }

class ClassSchedule {
  final String id; // Unique ID for the schedule item
  final String className;
  final String subjectName;
  final ClassType type;
  final int studentCount;
  ScheduleDetail details; // Chi tiết lịch học có thể sửa đổi

  ClassSchedule({
    required this.id,
    required this.className,
    required this.subjectName,
    required this.type,
    required this.studentCount,
    required this.details,
  });

  // Helper method to update details (for simplicity in this example)
  void updateDetails(ScheduleDetail newDetails) {
    details = newDetails;
  }
}

class ClassInfoDisplay extends StatelessWidget {
  final ClassSchedule classSchedule;

  const ClassInfoDisplay({Key? key, required this.classSchedule})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${classSchedule.className} - ${classSchedule.subjectName}',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Loại: ${classSchedule.type == ClassType.lyThuyet ? 'Lý thuyết' : 'Thực hành'}',
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            'Sĩ số: ${classSchedule.studentCount}',
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
