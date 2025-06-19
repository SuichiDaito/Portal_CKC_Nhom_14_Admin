import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/exam_schedule_card.dart';
import 'package:portal_ckc/presentation/sections/card/exam_scheldule_filter_buttons_row.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

class PageExamScheduleGroupedAdmin extends StatefulWidget {
  const PageExamScheduleGroupedAdmin({Key? key}) : super(key: key);

  @override
  _PageExamScheduleGroupedAdminState createState() =>
      _PageExamScheduleGroupedAdminState();
}

class _PageExamScheduleGroupedAdminState
    extends State<PageExamScheduleGroupedAdmin> {
  // Dữ liệu giả (thay thế bằng dữ liệu thực tế từ API sau này)
  final List<DropdownItem> _schoolYears = [
    DropdownItem(value: '2023-2024', label: '2023-2024', icon: Icons.school),
    DropdownItem(value: '2024-2025', label: '2024-2025', icon: Icons.school),
  ];

  final List<DropdownItem> _semesters = [
    DropdownItem(value: '1', label: 'Học kì 1', icon: Icons.looks_one),
    DropdownItem(value: '2', label: 'Học kì 2', icon: Icons.looks_two),
    DropdownItem(
      value: 'Hè',
      label: 'Học kì Hè',
      icon: Icons.wb_sunny, // Icon cho học kỳ hè
    ),
  ];

  final List<DropdownItem> _subjects = [
    DropdownItem(
      value: 'PRM392',
      label: 'Lập trình di động',
      icon: Icons.phone_android,
    ),
    DropdownItem(
      value: 'PRN211',
      label: 'Lập trình .NET',
      icon: Icons.laptop_mac,
    ),
    DropdownItem(
      value: 'SWP391',
      label: 'Phát triển phần mềm',
      icon: Icons.developer_mode,
    ),
  ];

  DropdownItem? _selectedSchoolYear;
  DropdownItem? _selectedSemester;
  DropdownItem? _selectedSubject;

  List<ExamSchedule> _allExamSchedules = [
    ExamSchedule(
      id: 'EX001',
      className: 'SE1812',
      proctor1: 'Nguyễn Văn A',
      proctor2: 'Trần Thị B',
      examDate: DateTime(2025, 7, 20),
      startTime: '07:30',
      durationMinutes: 90,
      room: 'DE101',
      examAttempt: 1,
      status: ExamStatus.scheduled,
    ),
    ExamSchedule(
      id: 'EX002',
      className: 'SE1701',
      proctor1: 'Lê Văn C',
      proctor2: 'Phạm Thị D',
      examDate: DateTime(2025, 7, 15),
      startTime: '13:00',
      durationMinutes: 60,
      room: 'A203',
      examAttempt: 1,
      status: ExamStatus.completed,
    ),
    ExamSchedule(
      id: 'EX003',
      className: 'AI1905',
      proctor1: 'Hoàng Thị E',
      proctor2: 'Vũ Văn F',
      examDate: DateTime(2025, 8, 1),
      startTime: '09:00',
      durationMinutes: 120,
      room: 'LAB401',
      examAttempt: 2,
      status: ExamStatus.scheduled,
    ),
    ExamSchedule(
      id: 'EX004',
      className: 'GD1602',
      proctor1: 'Mai Anh',
      proctor2: 'Đức Thắng',
      examDate: DateTime(2025, 7, 25),
      startTime: '10:00',
      durationMinutes: 90,
      room: 'B105',
      examAttempt: 1,
      status: ExamStatus.cancelled,
    ),
  ];

  ExamStatus? _currentFilter = null; // null = Hiển thị tất cả

  @override
  void initState() {
    super.initState();
    _selectedSchoolYear = _schoolYears.first;
    _selectedSemester = _semesters.first;
    _selectedSubject = _subjects.first;
  }

  // Lọc danh sách lịch thi dựa trên trạng thái
  List<ExamSchedule> get _filteredExamSchedules {
    if (_currentFilter == null) {
      return _allExamSchedules;
    }
    return _allExamSchedules
        .where((schedule) => schedule.status == _currentFilter)
        .toList();
  }

  void _handleExamScheduleUpdate(ExamSchedule updatedSchedule) {
    setState(() {
      final index = _allExamSchedules.indexWhere(
        (s) => s.id == updatedSchedule.id,
      );
      if (index != -1) {
        _allExamSchedules[index] = updatedSchedule;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBarTitle(title: 'Quản lý lịch thi'),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),

        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Các Dropdown chọn niên khóa, học kì, môn học
            Card(
              color: Colors.blue,
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1976D2).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.filter_alt,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Lọc thông tin',
                          style: (TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownSelector(
                            label: 'Niên khóa',
                            selectedItem: _selectedSchoolYear,
                            items: _schoolYears,
                            onChanged: (item) {
                              setState(() {
                                _selectedSchoolYear = item;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ), // Khoảng cách giữa hai dropdown
                        Expanded(
                          child: DropdownSelector(
                            label: 'Học kì',
                            selectedItem: _selectedSemester,
                            items: _semesters,
                            onChanged: (item) {
                              setState(() {
                                _selectedSemester = item;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    DropdownSelector(
                      label: 'Môn học',
                      selectedItem: _selectedSubject,
                      items: _subjects,
                      onChanged: (item) {
                        setState(() {
                          _selectedSubject = item;
                          // Thực hiện lọc hoặc tải lại dữ liệu lịch thi theo môn học
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                        text: 'Lưu cài đặt', // Nút lưu cho các tùy chọn trên
                        onPressed: () {
                          // Logic lưu các lựa chọn niên khóa, học kỳ, môn học
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Đã lưu!')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Nút lọc theo trạng thái
            FilterButtonsRow(
              currentFilter: _currentFilter,
              onFilterChanged: (status) {
                setState(() {
                  _currentFilter = status;
                });
              },
            ),
            const SizedBox(height: 8),
            // Danh sách các lịch thi
            _filteredExamSchedules.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Không có lịch thi nào phù hợp.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : Column(
                    children: _filteredExamSchedules
                        .map(
                          (schedule) => ExamScheduleCard(
                            schedule: schedule,
                            onSave: _handleExamScheduleUpdate,
                          ),
                        )
                        .toList(),
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
