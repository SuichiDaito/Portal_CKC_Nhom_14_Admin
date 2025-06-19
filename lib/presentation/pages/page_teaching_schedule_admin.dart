import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_day_selector.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_print_schedule_dialog.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_view.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_week_selector.dart';

class Subject {
  final String name;
  final String className;
  final String type;
  final String room;
  final String period;

  Subject(this.name, this.className, this.type, this.room, this.period);
}

final Map<String, Map<String, List<Subject>>> scheduleData = {
  'Thứ 2': {
    'Sáng': [
      Subject('Chính trị', 'CĐTH22ĐĐE', 'Đại cương', 'F7.4', '1-3'),
      Subject('Toán cao cấp', 'CĐTH22ĐĐE', 'Cơ sở', 'F7.5', '4-6'),
    ],
    'Chiều': [
      Subject('Tiếng Anh', 'CĐTH22ĐĐE', 'Cơ sở', 'F7.3', '7-9'),
      Subject('Tin học văn phòng', 'CĐTH22ĐĐE', 'Đại cương', 'F7.6', '10-12'),
    ],
    'Tối': [
      Subject('Thể dục', 'CĐTH22ĐĐE', 'Đại cương', 'Sân thể thao', '13-15'),
    ],
  },
  'Thứ 3': {
    'Sáng': [
      Subject('Kỹ thuật lập trình', 'CĐTH22ĐĐE', 'Chuyên ngành', 'F6.2', '1-3'),
    ],
    'Chiều': [],
    'Tối': [],
  },
  'Thứ 4': {'Sáng': [], 'Chiều': [], 'Tối': []},
  'Thứ 5': {'Sáng': [], 'Chiều': [], 'Tối': []},
  'Thứ 6': {'Sáng': [], 'Chiều': [], 'Tối': []},
  'Thứ 7': {'Sáng': [], 'Chiều': [], 'Tối': []},
  'Chủ nhật': {'Sáng': [], 'Chiều': [], 'Tối': []},
};

class PageTeachingScheduleAdmin extends StatefulWidget {
  @override
  _PageTeachingScheduleAdminState createState() =>
      _PageTeachingScheduleAdminState();
}

class _PageTeachingScheduleAdminState extends State<PageTeachingScheduleAdmin> {
  int selectedWeek = 1;
  String? selectedDay;
  void _printSchedule(int fromWeek, int toWeek) {
    // Xử lý in ở đây
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('In TKB từ tuần $fromWeek đến tuần $toWeek')),
    );
  }

  void _showPrintDialog() {
    showDialog(
      context: context,
      builder: (_) => PrintScheduleDialog(
        fromWeek: selectedWeek,
        toWeek: selectedWeek,
        onPrint: _printSchedule,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quản lý Thời Khóa Biểu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (selectedDay != null)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  selectedDay = null;
                });
              },
              tooltip: 'Hiển thị tất cả',
            ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () => _showPrintDialog(),
            tooltip: 'In thời khóa biểu',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 30, 81, 123),
              const Color.fromARGB(255, 56, 76, 208),
            ],
          ),
        ),
        child: Column(
          children: [
            WeekSelector(
              selectedWeek: selectedWeek,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedWeek = value;
                  });
                }
              },
            ),
            DaySelector(
              selectedDay: selectedDay,
              onDayTap: (String day) {
                setState(() {
                  selectedDay = day;
                });
              },
            ),

            Expanded(
              child: ScheduleView(
                selectedWeek: selectedWeek,
                selectedDay: selectedDay,
                scheduleData: scheduleData,
                onDayTap: (String day) {
                  setState(() {
                    selectedDay = day;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
