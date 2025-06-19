import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/pages/page_teaching_schedule_admin.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_day_schedule.dart';

class ScheduleView extends StatelessWidget {
  final String? selectedDay;
  final Map<String, Map<String, List<Subject>>> scheduleData;
  final void Function(String) onDayTap;

  const ScheduleView({
    required this.selectedDay,
    required this.scheduleData,
    required this.onDayTap,
    required int selectedWeek,
  });
  @override
  Widget build(BuildContext context) {
    if (selectedDay != null) {
      final dayData = scheduleData[selectedDay];
      if (dayData == null || dayData.values.every((list) => list.isEmpty)) {
        return Center(child: Text('Không có lịch học cho ngày này'));
      }

      return SingleChildScrollView(
        child: DaySchedule(
          day: selectedDay!,
          daySchedule: dayData,
          onDayTap: onDayTap,
          isSelected: true,
        ),
      );
    }

    // Nếu chưa chọn ngày nào thì hiển thị toàn bộ các ngày có trong scheduleData
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: scheduleData.entries.map((entry) {
              return DaySchedule(
                day: entry.key,
                daySchedule: entry.value,
                onDayTap: onDayTap,
                isSelected: false,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
