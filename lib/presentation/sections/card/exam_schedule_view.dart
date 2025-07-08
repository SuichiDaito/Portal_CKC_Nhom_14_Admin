import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_lich_thi.dart';
import 'package:portal_ckc/presentation/sections/card/exam_duty_card.dart';

class ExamScheduleView extends StatelessWidget {
  final String? selectedDay;
  final Map<String, List<ExamSchedule>> scheduleData;
  final void Function(String) onDayTap;

  const ExamScheduleView({
    required this.selectedDay,
    required this.scheduleData,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    final days = selectedDay != null
        ? [selectedDay!]
        : scheduleData.keys.toList();

    return SingleChildScrollView(
      child: Column(
        children: days.map((day) {
          final duties = scheduleData[day] ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...duties.map((duty) => ExamDutyCard(duty: duty)).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
