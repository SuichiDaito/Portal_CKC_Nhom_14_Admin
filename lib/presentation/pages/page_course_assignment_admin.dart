import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/course_assignment_class_infor_section.dart';
import 'package:portal_ckc/presentation/sections/card/course_assignment_info_section.dart';

class ClassInfoAssignment {
  final String id;
  final String className;
  String subject;
  String type;
  String department;
  String instructor;
  bool isSelected;

  String semester;
  String academicYear;

  ClassInfoAssignment({
    required this.id,
    required this.className,
    required this.subject,
    required this.type,
    required this.department,
    required this.instructor,
    required this.isSelected,
    required this.semester,
    required this.academicYear,
  });
}

class PageCourseAssignmentAdmin extends StatefulWidget {
  @override
  _PageCourseAssignmentAdminState createState() =>
      _PageCourseAssignmentAdminState();
}

class _PageCourseAssignmentAdminState extends State<PageCourseAssignmentAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for course info
  String _selectedSemester = '1';
  String _selectedSubject = 'Toán cao cấp';

  // Sample data for classes
  List<ClassInfoAssignment> _classes = [
    ClassInfoAssignment(
      id: '1',
      className: 'CNTT01',
      subject: 'Lập trình Java',
      type: 'LT',
      department: 'Khoa CNTT',
      instructor: 'TS. Nguyễn Văn A',
      isSelected: false,
      semester: '1',
      academicYear: '2023-2024',
    ),
    ClassInfoAssignment(
      id: '2',
      className: 'CNTT02',
      subject: 'Cơ sở dữ liệu',
      type: 'TH',
      department: 'Khoa CNTT',
      instructor: 'ThS. Trần Thị B',
      isSelected: false,
      semester: '1',
      academicYear: '2023-2024',
    ),
    ClassInfoAssignment(
      id: '3',
      className: 'CNTT03',
      subject: 'Mạng máy tính',
      type: 'LT',
      department: 'Khoa CNTT',
      instructor: 'PGS. Lê Văn C',
      isSelected: false,
      semester: '1',
      academicYear: '2023-2024',
    ),
  ];

  bool _hasUnsavedChanges = false;

  void _updateClassInfo(String id, String field, String value) {
    setState(() {
      final classIndex = _classes.indexWhere((c) => c.id == id);
      if (classIndex != -1) {
        switch (field) {
          case 'subject':
            _classes[classIndex].subject = value;
            break;
          case 'type':
            _classes[classIndex].type = value;
            break;
          case 'department':
            _classes[classIndex].department = value;
            break;
          case 'instructor':
            _classes[classIndex].instructor = value;
            break;
        }
        _hasUnsavedChanges = true;
      }
    });
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Simulate saving changes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã lưu thay đổi thành công!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      setState(() {
        _hasUnsavedChanges = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phân công lớp học phần',
          style: TextStyle(color: Colors.white), // Chữ đen
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Course Info Section
              CourseInfoSection(
                selectedSemester: _selectedSemester,
                selectedSubject: _selectedSubject,
                onSemesterChanged: (value) {
                  setState(() {
                    _selectedSemester = value;
                    _hasUnsavedChanges = true;
                  });
                },
                onSubjectChanged: (value) {
                  setState(() {
                    _selectedSubject = value;
                    _hasUnsavedChanges = true;
                  });
                },
                selectedAcademicYear: '',
                onAcademicYearChanged: (String) {},
                onSave: () {},
              ),

              const SizedBox(height: 20),

              // Class List Section
              ClassListSection(
                classes: _classes,
                onClassInfoChanged: _updateClassInfo,
              ),

              const SizedBox(height: 20),

              // // Schedule Section
              // ScheduleSection(
              //   selectedClasses: _classes.where((c) => c.isSelected).toList(),
              // ),
              const SizedBox(height: 30),

              // Save Button
            ],
          ),
        ),
      ),
    );
  }
}
