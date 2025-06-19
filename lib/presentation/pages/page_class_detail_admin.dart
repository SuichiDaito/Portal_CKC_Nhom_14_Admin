import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_thongtin.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
=======
>>>>>>> origin/develop
import 'package:portal_ckc/presentation/sections/card/class_detail_class_info_card.dart';
import 'package:portal_ckc/presentation/sections/card/class_detail_class_search_bar.dart';
import 'package:portal_ckc/presentation/sections/card/class_detail_student_list.dart';

<<<<<<< HEAD
class PageClassDetailAdmin extends StatefulWidget {
  final Lop lop;

  const PageClassDetailAdmin({super.key, required this.lop});
=======
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
>>>>>>> origin/develop

  @override
  State<PageClassDetailAdmin> createState() => _PageClassDetailAdminState();
}

class _PageClassDetailAdminState extends State<PageClassDetailAdmin> {
<<<<<<< HEAD
  String searchQuery = '';
  String selectedStatus = 'Tất cả';
  late AdminBloc _adminBloc;
  User? _teacher;

  @override
  void initState() {
    super.initState();
    _adminBloc = context.read<AdminBloc>();
    _adminBloc.add(FetchStudentList(widget.lop.id));
    _fetchTeacherInfo(widget.lop.idGvcn);
  }

  Future<void> _fetchTeacherInfo(int idGvcn) async {
    final response = await _adminBloc.service.getUserDetail(idGvcn);
    if (response.isSuccessful && response.body != null) {
      final data = response.body as Map<String, dynamic>;
      setState(() {
        _teacher = User.fromJson(data['user']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
=======
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

>>>>>>> origin/develop
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
<<<<<<< HEAD
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is StudentListLoaded) {
            final studentList = state.sinhViens;
            // Tìm sinh viên là thư ký (chucVu == 0)
            final currentSecretary = studentList.firstWhere(
              (s) => s.chucVu == 0,
            );

            final filteredStudents = studentList.where((student) {
              final name = student.hoSo.hoTen.toLowerCase();
              final id = student.maSv.toLowerCase();
              final matchesQuery =
                  name.contains(searchQuery.toLowerCase()) ||
                  id.contains(searchQuery.toLowerCase());
              final matchesStatus =
                  selectedStatus == 'Tất cả' ||
                  student.trangThai.toString() == selectedStatus;
              return matchesQuery && matchesStatus;
            }).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClassInfoCard(
                    className: widget.lop.tenLop,
                    studentCount: studentList.length,
                    teacherName: _teacher?.hoSo?.hoTen ?? 'Đang tải...',
                    secretaryName: currentSecretary?.hoSo.hoTen ?? 'Chưa có',
                    studentList: studentList,
                    onSelectSecretary: (newSecretaryId) {
                      // Gửi API cập nhật thư ký mới ở đây nếu cần
                      print("Thư ký mới: $newSecretaryId");
                    },
                  ),
                  const SizedBox(height: 20),
                  ClassSearchBar(
                    searchQuery: searchQuery,
                    selectedStatus: selectedStatus,
                    onSearchChanged: (value) =>
                        setState(() => searchQuery = value),
                    onStatusChanged: (value) =>
                        setState(() => selectedStatus = value),
                    studentList: filteredStudents,
                  ),
                  const SizedBox(height: 16),
                  StudentList(
                    studentList: filteredStudents,
                    onTapStudent: (sv) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Thông tin sinh viên'),
                          content: Text(
                            'Tên: ${sv.hoSo.hoTen}\nMSSV: ${sv.maSv}\nChức vụ: ${sv.chucVu == 0 ? 'Thư ký' : 'Không có'}\nTrạng thái: ${{0: 'Đang học', 1: 'Bảo lưu', 2: 'Đã tốt nghiệp'}[sv.trangThai] ?? 'Không rõ'}',
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
            );
          }

          if (state is AdminError) {
            return Center(child: Text('❌ ${state.message}'));
          }

          return const Center(child: Text('Không có dữ liệu'));
        },
=======
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
>>>>>>> origin/develop
      ),
    );
  }
}
