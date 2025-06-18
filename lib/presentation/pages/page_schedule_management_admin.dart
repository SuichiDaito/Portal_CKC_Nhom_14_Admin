import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_class_info_display.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_copy_card.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_detail_editor.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_detail_model.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

class PageScheduleManagementAdmin extends StatefulWidget {
  const PageScheduleManagementAdmin({Key? key}) : super(key: key);

  @override
  _PageScheduleManagementAdminState createState() =>
      _PageScheduleManagementAdminState();
}

class _PageScheduleManagementAdminState
    extends State<PageScheduleManagementAdmin> {
  final List<DropdownItem> _schoolYears = [
    DropdownItem(value: '2023-2024', label: '2023-2024', icon: Icons.school),
    DropdownItem(value: '2024-2025', label: '2024-2025', icon: Icons.school),
  ];

  final List<DropdownItem> _weeks = List.generate(
    15,
    (index) => DropdownItem(
      value: (index + 1).toString(),
      label: 'Tuần ${index + 1}',
      icon: Icons.calendar_today,
    ),
  ).toList();

  final List<DropdownItem> _departments = [
    DropdownItem(
      value: 'CNTT',
      label: 'Công nghệ thông tin',
      icon: Icons.computer,
    ),
    DropdownItem(value: 'KT', label: 'Kế toán', icon: Icons.account_balance),
  ];

  final List<DropdownItem> _lecturers = [
    DropdownItem(value: 'GV001', label: 'Nguyễn Văn A', icon: Icons.person),
    DropdownItem(
      value: 'GV002',
      label: 'Trần Thị B',
      icon: Icons.person_outline,
    ),
  ];

  DropdownItem? _selectedSchoolYear;
  DropdownItem? _selectedWeek;
  DropdownItem? _selectedDepartment;
  DropdownItem? _selectedLecturer;

  List<ClassSchedule> _classSchedules = [
    ClassSchedule(
      id: 'PRM392_SE1812',
      className: 'SE1812',
      subjectName: 'Lập trình di động (PRM392)',
      type: ClassType.lyThuyet,
      studentCount: 45,
      details: ScheduleDetail(room: 'DE101'),
    ),
    ClassSchedule(
      id: 'PRN211_SE1812',
      className: 'SE1812',
      subjectName: 'Lập trình .NET (PRN211)',
      type: ClassType.thucHanh,
      studentCount: 40,
      details: ScheduleDetail(room: 'LAB305'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedSchoolYear = _schoolYears.first;
    _selectedWeek = _weeks.first;
    _selectedDepartment = _departments.first;
    _selectedLecturer = _lecturers.first;
  }

  void _handleScheduleUpdate(
    ClassSchedule originalClass,
    ScheduleDetail newDetails,
  ) {
    setState(() {
      final index = _classSchedules.indexWhere(
        (schedule) => schedule.id == originalClass.id,
      );
      if (index != -1) {
        _classSchedules[index].updateDetails(newDetails);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const CustomAppBarTitle(title: 'Quản lý lịch tuần'),
        backgroundColor: Colors.blueAccent,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // <-- thêm dòng này
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Filter Card
            Card(
              color: Colors.blue,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with icon
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
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Dropdown row 1 (SchoolYear + Week)
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
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownSelector(
                            label: 'Tuần',
                            selectedItem: _selectedWeek,
                            items: _weeks,
                            onChanged: (item) {
                              setState(() {
                                _selectedWeek = item;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Dropdown row 2 (Department)
                    DropdownSelector(
                      label: 'Bộ môn',
                      selectedItem: _selectedDepartment,
                      items: _departments,
                      onChanged: (item) {
                        setState(() {
                          _selectedDepartment = item;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Dropdown row 3 (Lecturer)
                    DropdownSelector(
                      label: 'Giảng viên',
                      selectedItem: _selectedLecturer,
                      items: _lecturers,
                      onChanged: (item) {
                        setState(() {
                          _selectedLecturer = item;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Schedule copy card
            ScheduleCopyCard(
              currentWeek: int.tryParse(_selectedWeek?.value ?? '1') ?? 1,
              onCopySchedule: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Chức năng sao chép lịch được kích hoạt!'),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                'Lịch học các lớp:',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Class schedules list
            ..._classSchedules.map((schedule) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: ScheduleDetailEditor(
                  classSchedule: schedule,
                  onSave: (newDetails) {
                    _handleScheduleUpdate(schedule, newDetails);
                  },
                ),
              );
            }).toList(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
