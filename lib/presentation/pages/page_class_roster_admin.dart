// screens/class_list_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/presentation/sections/card/class_roster_class_item_card.dart';
import 'package:portal_ckc/presentation/sections/card/class_roster_teacher_info_card.dart';
import 'package:portal_ckc/presentation/sections/class_roster_filter_section.dart';

class PageClassRosterAdmin extends StatefulWidget {
  const PageClassRosterAdmin({Key? key}) : super(key: key);

  @override
  State<PageClassRosterAdmin> createState() => _PageClassRosterAdminState();
}

class _PageClassRosterAdminState extends State<PageClassRosterAdmin> {
  // Sample data
  final TeacherModel teacher = TeacherModel(
    id: '1',
    name: 'TS. Nguyễn Văn A',
    email: 'nguyenvana@university.edu.vn',
    phone: '0123456789',
    department: 'Khoa Công nghệ Thông tin',
    title: 'Tiến sĩ - Giảng viên chính',
  );

  List<ClassModel> allClasses = [
    ClassModel(
      id: '1',
      className: 'CNTT01-K65',
      subject: 'Lập trình di động',
      status: 'Đang diễn ra',
      semester: 'HK1 2024-2025',
      studentCount: 45,
      schedule: 'T2, T4 (7:00-11:00)',
      room: 'P.301-A1',
    ),
    ClassModel(
      id: '2',
      className: 'CNTT02-K64',
      subject: 'Cơ sở dữ liệu',
      status: 'Đã kết thúc',
      semester: 'HK2 2023-2024',
      studentCount: 38,
      schedule: 'T3, T6 (13:00-17:00)',
      room: 'P.205-B2',
    ),
    ClassModel(
      id: '3',
      className: 'CNTT03-K65',
      subject: 'Phát triển ứng dụng web',
      status: 'Sắp diễn ra',
      semester: 'HK2 2024-2025',
      studentCount: 42,
      schedule: 'T2, T5 (7:00-11:00)',
      room: 'P.402-C1',
    ),
    ClassModel(
      id: '4',
      className: 'CNTT04-K64',
      subject: 'Lập trình di động',
      status: 'Đang diễn ra',
      semester: 'HK1 2024-2025',
      studentCount: 35,
      schedule: 'T4, T7 (13:00-17:00)',
      room: 'P.103-A2',
    ),
  ];

  List<ClassModel> filteredClasses = [];
  String? selectedSubject;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    filteredClasses = allClasses;
  }

  void _applyFilters() {
    setState(() {
      filteredClasses = allClasses.where((classModel) {
        bool matchesSubject =
            selectedSubject == null || classModel.subject == selectedSubject;
        bool matchesStatus =
            selectedStatus == null || classModel.status == selectedStatus;
        return matchesSubject && matchesStatus;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      selectedSubject = null;
      selectedStatus = null;
      filteredClasses = allClasses;
    });
  }

  void _onClassTap(ClassModel classModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Chi tiết lớp ${classModel.className}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Môn: ${classModel.subject}'),
            Text('Trạng thái: ${classModel.status}'),
            Text('Số sinh viên: ${classModel.studentCount}'),
            Text('Lịch học: ${classModel.schedule}'),
            Text('Phòng: ${classModel.room}'),
            Text('Học kỳ: ${classModel.semester}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
          TextButton(
            onPressed: () => context.push('/admin/course_student_list'),
            child: const Text('Xem chi tiết'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uniqueSubjects = allClasses.map((c) => c.subject).toSet().toList();
    final uniqueStatuses = allClasses.map((c) => c.status).toSet().toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        title: const Text(
          'Lớp học phần',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh data
          await Future.delayed(const Duration(milliseconds: 1000));
        },
        child: CustomScrollView(
          slivers: [
            // Teacher Info
            SliverToBoxAdapter(child: TeacherInfoCard(teacher: teacher)),

            // Filter Section
            SliverToBoxAdapter(
              child: FilterSection(
                subjects: uniqueSubjects,
                statuses: uniqueStatuses,
                selectedSubject: selectedSubject,
                selectedStatus: selectedStatus,
                onSubjectChanged: (value) {
                  selectedSubject = value;
                  _applyFilters();
                },
                onStatusChanged: (value) {
                  selectedStatus = value;
                  _applyFilters();
                },
                onClearFilters: _clearFilters,
              ),
            ),

            // Class Count
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Tìm thấy ${filteredClasses.length} lớp học phần',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // Class List
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final classModel = filteredClasses[index];
                return ClassItemCard(
                  classModel: classModel,
                  onTap: () => _onClassTap(classModel),
                );
              }, childCount: filteredClasses.length),
            ),

            // Bottom spacing
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}
