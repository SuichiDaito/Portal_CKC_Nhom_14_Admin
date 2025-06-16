import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/class_detail_class_info_card.dart';
import 'package:portal_ckc/presentation/sections/card/class_detail_class_search_bar.dart';
import 'package:portal_ckc/presentation/sections/card/class_detail_student_list.dart';

class Student {
  final String id;
  final String name;
  String role;
  final String status;

  Student({
    required this.id,
    required this.name,
    required this.role,
    required this.status,
  });
}

class PageClassDetailAdmin extends StatefulWidget {
  const PageClassDetailAdmin({super.key});

  @override
  State<PageClassDetailAdmin> createState() => _PageClassDetailAdminState();
}

class _PageClassDetailAdminState extends State<PageClassDetailAdmin> {
  // Danh sách sinh viên mẫu
  final List<Student> studentList = [
    Student(
      id: '2012345',
      name: 'Nguyễn Văn A',
      role: 'Lớp trưởng',
      status: 'Đang học',
    ),
    Student(
      id: '2012346',
      name: 'Trần Thị B',
      role: 'Thư ký',
      status: 'Đang học',
    ),
    Student(id: '2012347', name: 'Lê Văn C', role: '', status: 'Bảo lưu'),
  ];

  String searchQuery = '';
  String selectedStatus = 'Tất cả';

  @override
  Widget build(BuildContext context) {
    final filteredStudents = (studentList ?? []).where((student) {
      final matchesQuery =
          student.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          student.id.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesStatus =
          selectedStatus == 'Tất cả' || student.status == selectedStatus;

      return matchesQuery && matchesStatus;
    }).toList();

    // Tìm thư ký hiện tại
    final currentSecretary = studentList.firstWhere(
      (s) => s.role == 'Thư ký',
      orElse: () => Student(id: '', name: 'Chưa có', role: '', status: ''),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Chi tiết lớp chủ nhiệm',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1976D2),
        elevation: 4,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phần thông tin lớp
            ClassInfoCard(
              className: 'CĐTH22E',
              studentCount: studentList.length, // ✅ truyền thêm dòng này
              teacherName: 'Ngô Thị T',
              secretaryName: currentSecretary.name,
              onSelectSecretary: (String newSecretaryId) {
                setState(() {
                  for (var student in studentList) {
                    student.role = student.id == newSecretaryId ? 'Thư ký' : '';
                  }
                });
              },
            ),

            const SizedBox(height: 20),

            // Phần thanh tìm kiếm và trạng thái
            ClassSearchBar(
              searchQuery: searchQuery,
              selectedStatus: selectedStatus,
              onSearchChanged: (value) => setState(() => searchQuery = value),
              onStatusChanged: (value) =>
                  setState(() => selectedStatus = value),
            ),
            const SizedBox(height: 16),

            // Phần danh sách sinh viên
            StudentList(
              studentList: filteredStudents,
              onTapStudent: (student) {
                // Xử lý khi bấm vào một sinh viên, ví dụ hiển thị thông tin
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Thông tin sinh viên'),
                    content: Text(
                      'Tên: ${student.name}\nMSSV: ${student.id}\nChức vụ: ${student.role}\nTrạng thái: ${student.status}',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Đóng'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
