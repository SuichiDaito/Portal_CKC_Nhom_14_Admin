import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/button/filter_buttons_row_teacher.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';
import 'package:portal_ckc/presentation/sections/card/teacher_detail_bottom_sheet.dart';
import 'package:portal_ckc/presentation/sections/card/teacher_list_item.dart';

enum TeacherPosition { dean, viceDean, lecturer, staff }

class Teacher {
  final String id; // ID duy nhất của giáo viên (có thể là mã GV)
  final String teacherCode; // Mã giáo viên
  final String fullName;
  final String department; // Bộ môn
  final String faculty; // Khoa
  TeacherPosition position;
  final String email;
  final String phoneNumber;

  Teacher({
    required this.id,
    required this.teacherCode,
    required this.fullName,
    required this.department,
    required this.faculty,
    required this.position,
    this.email = '',
    this.phoneNumber = '',
  });

  // Helper để tạo bản sao khi chỉnh sửa hoặc truyền dữ liệu
  Teacher copyWith({
    String? id,
    String? teacherCode,
    String? fullName,
    String? department,
    String? faculty,
    TeacherPosition? position,
    String? email,
    String? phoneNumber,
  }) {
    return Teacher(
      id: id ?? this.id,
      teacherCode: teacherCode ?? this.teacherCode,
      fullName: fullName ?? this.fullName,
      department: department ?? this.department,
      faculty: faculty ?? this.faculty,
      position: position ?? this.position,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class PageTeacherManagementAdmin extends StatefulWidget {
  const PageTeacherManagementAdmin({Key? key}) : super(key: key);

  @override
  _PageTeacherManagementAdminState createState() =>
      _PageTeacherManagementAdminState();
}

class _PageTeacherManagementAdminState
    extends State<PageTeacherManagementAdmin> {
  // Dữ liệu giả định
  final List<DropdownItem> _faculties = [
    DropdownItem(
      value: 'CNTT',
      label: 'Công nghệ thông tin',
      icon: Icons.computer, // Biểu tượng máy tính
    ),
    DropdownItem(
      value: 'KinhTe',
      label: 'Kinh tế',
      icon: Icons.attach_money, // Biểu tượng tiền tệ
    ),
    DropdownItem(
      value: 'NN',
      label: 'Ngoại ngữ',
      icon: Icons.language, // Biểu tượng ngôn ngữ
    ),
  ];
  final List<DropdownItem> _departments = [
    DropdownItem(
      value: 'CNPM',
      label: 'Công nghệ phần mềm',
      icon: Icons.code, // Biểu tượng mã nguồn
    ),
    DropdownItem(
      value: 'HTTT',
      label: 'Hệ thống thông tin',
      icon: Icons.storage, // Biểu tượng cơ sở dữ liệu
    ),
    DropdownItem(
      value: 'TMDT',
      label: 'Thương mại điện tử',
      icon: Icons.shopping_cart, // Biểu tượng thương mại
    ),
  ];

  DropdownItem? _selectedFaculty;
  DropdownItem? _selectedDepartment;
  TeacherPosition? _currentFilter = null; // null = Hiển thị tất cả

  List<Teacher> _allTeachers = [
    Teacher(
      id: 'GV001',
      teacherCode: 'GV001',
      fullName: 'Nguyễn Văn A',
      department: 'CNPM',
      faculty: 'CNTT',
      position: TeacherPosition.lecturer,
      email: 'anv@faculty.edu.vn',
      phoneNumber: '0901112233',
    ),
    Teacher(
      id: 'GV002',
      teacherCode: 'GV002',
      fullName: 'Trần Thị B',
      department: 'HTTT',
      faculty: 'CNTT',
      position: TeacherPosition.dean,
      email: 'btt@faculty.edu.vn',
      phoneNumber: '0901223344',
    ),
    Teacher(
      id: 'GV003',
      teacherCode: 'GV003',
      fullName: 'Lê Văn C',
      department: 'TMDT',
      faculty: 'KinhTe',
      position: TeacherPosition.viceDean,
      email: 'clv@faculty.edu.vn',
      phoneNumber: '0901334455',
    ),
    Teacher(
      id: 'GV004',
      teacherCode: 'GV004',
      fullName: 'Phạm Thị D',
      department: 'CNPM',
      faculty: 'CNTT',
      position: TeacherPosition.staff,
      email: 'dpt@faculty.edu.vn',
      phoneNumber: '0901445566',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedFaculty = _faculties.first;
    _selectedDepartment = _departments.first;
  }

  List<Teacher> get _filteredTeachers {
    List<Teacher> teachers = _allTeachers;

    // Lọc theo khoa
    if (_selectedFaculty != null && _selectedFaculty!.value != 'all') {
      teachers = teachers
          .where((t) => t.faculty == _selectedFaculty!.value)
          .toList();
    }

    // Lọc theo bộ môn
    if (_selectedDepartment != null && _selectedDepartment!.value != 'all') {
      teachers = teachers
          .where((t) => t.department == _selectedDepartment!.value)
          .toList();
    }

    // Lọc theo chức vụ
    if (_currentFilter != null) {
      teachers = teachers.where((t) => t.position == _currentFilter).toList();
    }

    return teachers;
  }

  void _updateTeacherPosition(Teacher updatedTeacher) {
    setState(() {
      final index = _allTeachers.indexWhere((t) => t.id == updatedTeacher.id);
      if (index != -1) {
        _allTeachers[index] = updatedTeacher;
      }
    });
  }

  void _resetTeacherPassword(Teacher teacher) {
    // Thực hiện logic đặt lại mật khẩu mặc định (gọi API)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã yêu cầu đặt lại mật khẩu cho GV: ${teacher.fullName} - ${teacher.teacherCode}',
        ),
      ),
    );
  }

  void _showTeacherDetailBottomSheet(Teacher teacher) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return TeacherDetailBottomSheet(
          teacher: teacher,
          onUpdatePosition: (updatedTeacher) {
            _updateTeacherPosition(updatedTeacher);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBarTitle(title: 'Quản lý giáo viên'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Phần tìm kiếm/lọc theo khoa, bộ môn
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
              child: Column(
                children: [
                  DropdownSelector(
                    label: 'Khoa',
                    selectedItem: _selectedFaculty,
                    items: [
                      DropdownItem(
                        value: 'all',
                        label: 'Tất cả các khoa',
                        icon: Icons.computer,
                      ),
                      ..._faculties,
                    ],
                    onChanged: (item) {
                      setState(() {
                        _selectedFaculty = item;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  DropdownSelector(
                    label: 'Bộ môn',
                    selectedItem: _selectedDepartment,
                    items: [
                      DropdownItem(
                        value: 'all',
                        label: 'Tất cả các bộ môn',
                        icon: Icons.access_alarm_outlined,
                      ),
                      ..._departments,
                    ],
                    onChanged: (item) {
                      setState(() {
                        _selectedDepartment = item;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          // Các nút lọc theo chức vụ
          FilterButtonsRowTeacher(
            currentFilter: _currentFilter,
            onFilterChanged: (position) {
              setState(() {
                _currentFilter = position;
              });
            },
          ),
          const SizedBox(height: 8),
          // Danh sách giáo viên
          Expanded(
            child: _filteredTeachers.isEmpty
                ? const Center(
                    child: Text(
                      'Không tìm thấy giáo viên nào phù hợp.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredTeachers.length,
                    itemBuilder: (context, index) {
                      final teacher = _filteredTeachers[index];
                      return TeacherListItem(
                        teacher: teacher,
                        onDetailPressed: () =>
                            _showTeacherDetailBottomSheet(teacher),
                        onResetPasswordPressed: () =>
                            _resetTeacherPassword(teacher),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
