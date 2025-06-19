import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_absent_student_manager.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_build_content_input.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_fixed_info_card.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_readonly_summary_card.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_editable_section.dart';

class Student {
  final String id;
  final String name;
  bool isAbsent;

  Student({required this.id, required this.name, this.isAbsent = false});
}

class PageReportDetailAdmin extends StatefulWidget {
  final bool isApproved;

  const PageReportDetailAdmin({super.key, required this.isApproved});

  @override
  State<PageReportDetailAdmin> createState() => _PageReportDetailAdminState();
}

class _PageReportDetailAdminState extends State<PageReportDetailAdmin> {
  bool isEditing = false;
  String selectedWeek = '1';
  DateTime selectedDate = DateTime.now();
  String selectedRoom = 'P101';
  TimeOfDay selectedTime = TimeOfDay(hour: 7, minute: 0);
  String content =
      'Thông báo mới nhất từ khoa công nghệ thông tin về việc ....';
  final absentIds = ['22DTH001', '22DTH007'];
  String? selectedStudentId;
  List<String> absentStudentIds = ['22DTH001', '22DTH003', '22DTH005'];

  Map<String, String> absenceReasons = {
    '22DTH001': 'Bị bệnh',
    '22DTH003': 'Về quê',
    '22DTH005': 'Không rõ lý do',
  };

  Map<String, bool> isExcusedMap = {
    '22DTH001': true,
    '22DTH003': false,
    '22DTH005': false,
  };

  List<String> weeks = List.generate(16, (i) => (i + 1).toString());
  List<String> rooms = ['P101', 'P102', 'P201', 'Hội trường'];
  List<Map<String, String>> allStudents = [
    {'mssv': '22DTH001', 'name': 'Nguyễn Văn A'},
    {'mssv': '22DTH002', 'name': 'Lê Thị B'},
    {'mssv': '22DTH003', 'name': 'Trần Văn C'},
    {'mssv': '22DTH004', 'name': 'Trần Văn C'},
    {'mssv': '22DTH005', 'name': 'Trần Văn C'},
    {'mssv': '22DTH006', 'name': 'Trần Văn C'},
  ];
  final List<Map<String, String>> studentList = [
    {'mssv': '22DTH001', 'name': 'Nguyễn Văn A'},
    {'mssv': '22DTH002', 'name': 'Trần Thị B'},
    {'mssv': '22DTH003', 'name': 'Lê Văn C'},
    {'mssv': '22DTH004', 'name': 'Phạm Thị D'},
    {'mssv': '22DTH005', 'name': 'Đỗ Văn E'},
    {'mssv': '22DTH006', 'name': 'Ngô Thị F'},
    {'mssv': '22DTH007', 'name': 'Bùi Văn G'},
    {'mssv': '22DTH008', 'name': 'Võ Thị H'},
    {'mssv': '22DTH009', 'name': 'Mai Văn I'},
    {'mssv': '22DTH010', 'name': 'Phan Thị K'},
  ];

  String? selectedStudent;

  List<Student> students = List.generate(
    20,
    (i) => Student(id: 'SV${i + 1}', name: 'Sinh viên ${i + 1}'),
  );

  int get total => students.length;
  int get absent => absentStudentIds.length;
  int get present => total - absent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết biên bản'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white, // Làm trắng cả chữ và icon
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Mũi tên back trắng
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: widget.isApproved ? _buildApprovedView() : _buildPendingView(),
    );
  }

  Widget _buildApprovedView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReportDetailReadonlySummaryCard(
            selectedWeek: int.tryParse(selectedWeek) ?? 0,
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            selectedRoom: selectedRoom,
            total: total,
            present: present,
            absent: absent,
            content: content,
            absentStudentIds: absentStudentIds,
            studentList: studentList,
            absenceReasons: absenceReasons,
          ),
        ],
      ),
    );
  }

  Widget _buildPendingView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReportDetailFixedInfoCard(
            isEditing: isEditing,
            onToggleEdit: () => setState(() => isEditing = !isEditing),
            onApprove: _showApproveDialog,
          ),
          const SizedBox(height: 12),
          if (isEditing) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "BIÊN BẢNG SINH HOẠT CHỦ NHIỆM",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ReportDetailEditableSection(
                    selectedWeek: selectedWeek,
                    selectedDate: selectedDate,
                    selectedRoom: selectedRoom,
                    selectedTime: selectedTime,
                    weeks: weeks,
                    rooms: rooms,
                    onWeekChanged: (val) => setState(() => selectedWeek = val),
                    onDateChanged: (val) => setState(() => selectedDate = val),
                    onRoomChanged: (val) => setState(() => selectedRoom = val),
                    onTimeChanged: (val) => setState(() => selectedTime = val),
                  ),
                  const SizedBox(height: 12),
                  ReportDetailBuildContentInput(
                    content: content,
                    onChanged: (val) => setState(() => content = val),
                  ),
                  const SizedBox(height: 12),
                  AbsentStudentManager(
                    studentList: studentList,
                    absentStudentIds: absentStudentIds,
                    onAddAbsentStudent: (id) {
                      setState(() {
                        absentStudentIds.add(id);
                        absenceReasons[id] = '';
                        isExcusedMap[id] = false;
                      });
                    },
                    onRemoveAbsentStudent: (id) {
                      setState(() {
                        absentStudentIds.remove(id);
                        absenceReasons.remove(id);
                        isExcusedMap.remove(id);
                      });
                    },
                    absenceReasons: absenceReasons,
                    isExcusedMap: isExcusedMap,
                    onReasonChanged: (id, reason) {
                      setState(() {
                        absenceReasons[id] = reason;
                      });
                    },
                    onExcusedChanged: (id, isExcused) {
                      setState(() {
                        isExcusedMap[id] = isExcused;
                      });
                    },
                  ),
                ],
              ),
            ),
          ] else
            ReportDetailReadonlySummaryCard(
              selectedWeek: int.tryParse(selectedWeek) ?? 0,
              selectedDate: selectedDate,
              selectedTime: selectedTime,
              selectedRoom: selectedRoom,
              total: total,
              present: present,
              absent: absent,
              content: content,
              absentStudentIds: absentStudentIds,
              studentList: studentList,
              absenceReasons: absenceReasons,
            ),
        ],
      ),
    );
  }
}

void _showApproveDialog() {}
