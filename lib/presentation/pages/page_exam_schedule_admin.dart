import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/class_management_teacher_info_card.dart';
import 'package:portal_ckc/presentation/sections/card/exam_schedule_view.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_print_schedule_dialog.dart';

class ExamDuty {
  final String invigilator1;
  final String invigilator2;
  final String examDate;
  final String startTime;
  final String duration;
  final String room;
  final String status;

  ExamDuty({
    required this.invigilator1,
    required this.invigilator2,
    required this.examDate,
    required this.startTime,
    required this.duration,
    required this.room,
    required this.status,
  });
}

final Map<String, List<ExamDuty>> examSchedule = {
  '17/06/2025': [
    ExamDuty(
      invigilator1: 'Nguyễn Văn A',
      invigilator2: 'Trần Thị B',
      examDate: '17/06/2025',
      startTime: '07:00',
      duration: '90 phút',
      room: 'P.201',
      status: 'Chưa diễn ra',
    ),
    ExamDuty(
      invigilator1: 'Nguyễn Văn C',
      invigilator2: 'Lê Thị D',
      examDate: '17/06/2025',
      startTime: '09:00',
      duration: '90 phút',
      room: 'P.202',
      status: 'Đã hoàn thành',
    ),
  ],
  '18/06/2025': [
    ExamDuty(
      invigilator1: 'Nguyễn Văn E',
      invigilator2: 'Trần Thị F',
      examDate: '18/06/2025',
      startTime: '07:00',
      duration: '60 phút',
      room: 'P.301',
      status: 'Chưa diễn ra',
    ),
  ],
};

class PageExamScheduleAdmin extends StatefulWidget {
  @override
  _PageExamScheduleAdminState createState() => _PageExamScheduleAdminState();
}

class _PageExamScheduleAdminState extends State<PageExamScheduleAdmin> {
  String? selectedStatus;
  final String teacherName = "TS. Nguyễn Văn An";
  final String teacherId = "GV001";
  final String department = "Khoa Công Nghệ Thông Tin";
<<<<<<< HEAD
  void _showPrintDialog() {
    showDialog(
      context: context,
      builder: (_) => PrintScheduleDialog(
        fromWeek: 1,
        toWeek: 1,
        onPrint: (from, to) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('In lịch từ $from đến $to')));
        },
      ),
    );
  }
=======
>>>>>>> origin/develop

  @override
  Widget build(BuildContext context) {
    final filteredSchedule = examSchedule.map((date, duties) {
      final filteredDuties =
          selectedStatus == null || selectedStatus == 'Tất cả'
          ? duties
          : duties.where((d) => d.status == selectedStatus).toList();
      return MapEntry(date, filteredDuties);
    })..removeWhere((_, duties) => duties.isEmpty);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quản lý Lịch Gác Thi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
<<<<<<< HEAD
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: _showPrintDialog,
            tooltip: 'In lịch gác thi',
          ),
        ],
=======
>>>>>>> origin/develop
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E517B), Color(0xFF384CD0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            TeacherInfoCard(
              teacherName: teacherName,
              teacherId: teacherId,
              department: department,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Wrap(
                spacing: 8,
                children: ['Tất cả', 'Chưa diễn ra', 'Đã hoàn thành']
                    .map(
                      (status) => ChoiceChip(
                        label: Text(status),
                        selected: (selectedStatus ?? 'Tất cả') == status,
                        selectedColor: Colors.blue,
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(
                          color: (selectedStatus ?? 'Tất cả') == status
                              ? Colors.white
                              : Colors.black,
                        ),
                        onSelected: (_) {
                          setState(() {
                            selectedStatus = status == 'Tất cả' ? null : status;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: filteredSchedule.isEmpty
                    ? Center(child: Text('Không có lịch gác thi phù hợp'))
                    : ExamScheduleView(
                        selectedDay: null,
                        scheduleData: filteredSchedule,
                        onDayTap: (_) {},
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
