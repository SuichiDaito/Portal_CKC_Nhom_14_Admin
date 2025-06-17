import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/pages/page_teaching_schedule_admin.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_session.dart';

class DaySchedule extends StatelessWidget {
  final String day;
  final Map<String, List<Subject>> daySchedule;
  final void Function(String) onDayTap;
  final bool isSelected;

  const DaySchedule({
    required this.day,
    required this.daySchedule,
    required this.onDayTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Color(
                      0xFFB3E5FC,
                    ) // Màu xanh nhạt hơn khi được chọn (bạn có thể đổi)
                  : Color(
                      0xFFE1F5FE,
                    ), // Màu mặc định khác thay vì Colors.blue[50]
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue[800],
                  ),
                ),
                if (!isSelected)
                  GestureDetector(
                    onTap: () => onDayTap(day),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Xem chi tiết',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ...daySchedule.entries.map((entry) {
            return SessionSchedule(session: entry.key, subjects: entry.value);
          }).toList(),
        ],
      ),
    );
  }
}
