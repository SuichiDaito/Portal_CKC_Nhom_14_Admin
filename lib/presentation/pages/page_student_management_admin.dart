import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/studen_model.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/button/filter_button_status_student.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';
import 'package:portal_ckc/presentation/sections/card/student_detail_bottom_sheet.dart';
import 'package:portal_ckc/presentation/sections/card/student_list_item.dart';

class PageStudentManagementAdmin extends StatefulWidget {
  const PageStudentManagementAdmin({Key? key}) : super(key: key);

  @override
  _PageStudentManagementAdminState createState() =>
      _PageStudentManagementAdminState();
}

class _PageStudentManagementAdminState
    extends State<PageStudentManagementAdmin> {
  // Dữ liệu giả
  final List<DropdownItem> _classNames = [
    DropdownItem(value: 'SE1812', label: 'SE1812', icon: Icons.class_),
    DropdownItem(value: 'SE1701', label: 'SE1701', icon: Icons.class_),
    DropdownItem(value: 'AI1905', label: 'AI1905', icon: Icons.class_),
    DropdownItem(value: 'GD1602', label: 'GD1602', icon: Icons.class_),
  ];

  DropdownItem? _selectedClass;
  StudentStatus? _currentFilter = null; // null = Hiển thị tất cả

  List<Student> _allStudents = [
    Student(
      id: 'ST001',
      studentCode: 'SE181234',
      fullName: 'Nguyễn Văn A',
      className: 'SE1812',
      status: StudentStatus.active,
      email: 'anv@example.com',
      phoneNumber: '0912345678',
      dateOfBirth: DateTime(2000, 1, 15),
    ),
    Student(
      id: 'ST002',
      studentCode: 'SE170156',
      fullName: 'Trần Thị B',
      className: 'SE1701',
      status: StudentStatus.graduated,
      email: 'btt@example.com',
      phoneNumber: '',
      dateOfBirth: DateTime(1999, 5, 20),
    ),
    Student(
      id: 'ST003',
      studentCode: 'AI190578',
      fullName: 'Lê Văn C',
      className: 'AI1905',
      status: StudentStatus.inactive,
      email: 'clv@example.com',
      phoneNumber: '0987654321',
      dateOfBirth: DateTime(2001, 11, 10),
    ),
    Student(
      id: 'ST004',
      studentCode: 'SE181290',
      fullName: 'Phạm Thị D',
      className: 'SE1812',
      status: StudentStatus.suspended,
      email: '',
      phoneNumber: '0900112233',
      dateOfBirth: DateTime(2000, 7, 25),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedClass = _classNames.first;
  }

  List<Student> get _filteredStudents {
    List<Student> students = _allStudents;

    // Lọc theo lớp
    if (_selectedClass != null && _selectedClass!.value != 'all') {
      // Thêm tùy chọn "Tất cả" cho lớp
      students = students
          .where((s) => s.className == _selectedClass!.value)
          .toList();
    }

    // Lọc theo trạng thái
    if (_currentFilter != null) {
      students = students.where((s) => s.status == _currentFilter).toList();
    }

    return students;
  }

  void _updateStudentStatus(Student updatedStudent) {
    setState(() {
      final index = _allStudents.indexWhere((s) => s.id == updatedStudent.id);
      if (index != -1) {
        _allStudents[index] = updatedStudent;
      }
    });
  }

  void _resetStudentPassword(Student student) {
    // Thực hiện logic đặt lại mật khẩu mặc định (gọi API)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã yêu cầu đặt lại mật khẩu cho MSSV: ${student.studentCode}',
        ),
      ),
    );
    // Có thể thêm logic cập nhật trạng thái hoặc thông báo cho sinh viên
  }

  void _showStudentDetailBottomSheet(Student student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return StudentDetailBottomSheet(
          student: student,
          onUpdateStatus: (updatedStudent) {
            _updateStudentStatus(updatedStudent);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBarTitle(title: 'Quản lý sinh viên'),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, // màu của icon (ví dụ: nút quay lại)
        ),
      ),
      body: Column(
        children: [
          // Phần tìm kiếm/lọc theo lớp
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            elevation: 4.0,
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownSelector(
                label: 'Danh sách sinh viên theo lớp',
                selectedItem: _selectedClass,
                items: [
                  DropdownItem(
                    value: 'all',
                    label: 'Tất cả các lớp',
                    icon: Icons.class_,
                  ), // Thêm tùy chọn "Tất cả"
                  ..._classNames,
                ],
                onChanged: (item) {
                  setState(() {
                    _selectedClass = item;
                  });
                },
              ),
            ),
          ),
          // Các nút lọc theo trạng thái
          FilterButtonsRow(
            currentFilter: _currentFilter,
            onFilterChanged: (status) {
              setState(() {
                _currentFilter = status;
              });
            },
          ),
          const SizedBox(height: 8),
          // Danh sách sinh viên
          Expanded(
            child: _filteredStudents.isEmpty
                ? const Center(
                    child: Text(
                      'Không tìm thấy sinh viên nào phù hợp.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = _filteredStudents[index];
                      return StudentListItem(
                        student: student,
                        onDetailPressed: () =>
                            _showStudentDetailBottomSheet(student),
                        onResetPasswordPressed: () =>
                            _resetStudentPassword(student),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
