// screens/student_list_screen.dart
import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:go_router/go_router.dart';
>>>>>>> origin/develop
import 'package:portal_ckc/presentation/sections/card/class_list_studen_infor_class_section.dart';
import 'package:portal_ckc/presentation/sections/card/class_list_student_score_item_section.dart';

class PageCourseSectionStudentList extends StatefulWidget {
  const PageCourseSectionStudentList({Key? key}) : super(key: key);

  @override
  State<PageCourseSectionStudentList> createState() =>
      _PageCourseSectionStudentListState();
}

class _PageCourseSectionStudentListState
    extends State<PageCourseSectionStudentList> {
  bool _isGradeInputMode = false;
  bool _selectAll = false;

  // Sample data
  final ClassInfo _classInfo = ClassInfo(
    className: 'Lập trình di động - Lớp 01',
    totalStudents: 25,
    subject: 'Công nghệ phần mềm',
    totalCredits: 3,
  );

  final List<Student> _students = [
    Student(
      studentId: 'SV001',
      fullName: 'Nguyễn Văn An',
      status: 'Hoạt động',
      grade: StudentGrade(
        attendanceScore: 8.5,
        processScore: 7.8,
        examScore: 8.2,
        finalScore: 8.0,
      ),
    ),
    Student(studentId: 'SV002', fullName: 'Trần Thị Bình', status: 'Hoạt động'),
    Student(studentId: 'SV003', fullName: 'Lê Minh Cường', status: 'Tạm nghỉ'),
    Student(studentId: 'SV004', fullName: 'Phạm Thị Dung', status: 'Hoạt động'),
    Student(studentId: 'SV005', fullName: 'Hoàng Văn Em', status: 'Đã nghỉ'),
  ];

  void _toggleGradeInputMode() {
    setState(() {
      _isGradeInputMode = !_isGradeInputMode;
      if (!_isGradeInputMode) {
        // Reset selections when exiting grade input mode
        for (var student in _students) {
          student.isSelected = false;
        }
        _selectAll = false;
      }
    });
  }

  void _toggleSelectAll() {
    setState(() {
      _selectAll = !_selectAll;
      for (var student in _students) {
        student.isSelected = _selectAll;
      }
    });
  }

  void _onStudentCheckboxChanged(Student student, bool isSelected) {
    setState(() {
      student.isSelected = isSelected;
      _selectAll = _students.every((s) => s.isSelected);
    });
  }

  void _onGradeSubmit(Student student, StudentGrade grade) {
    setState(() {
      student.grade = grade;
    });
  }

  void _submitAllGrades() {
    List<Student> selectedStudents = _students
        .where((s) => s.isSelected)
        .toList();

    if (selectedStudents.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn ít nhất một sinh viên'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận nộp điểm'),
        content: Text(
          'Bạn có chắc chắn muốn nộp điểm cho ${selectedStudents.length} sinh viên?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
<<<<<<< HEAD
              Navigator.pop(context);
=======
              context.pop(true);
>>>>>>> origin/develop
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Đã nộp điểm cho ${selectedStudents.length} sinh viên',
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              _toggleGradeInputMode();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              'Xác nhận',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  int get _selectedCount => _students.where((s) => s.isSelected).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Danh sách sinh viên',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleGradeInputMode,
        tooltip: _isGradeInputMode ? 'Thoát nhập điểm' : 'Nhập điểm',
        backgroundColor: _isGradeInputMode ? Colors.red : Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(_isGradeInputMode ? Icons.close : Icons.edit),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          ClassListStudenInforClassSection(classInfo: _classInfo),

          if (_isGradeInputMode)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.assignment, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'Chế độ nhập điểm',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Đã chọn: $_selectedCount',
                        style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _toggleSelectAll,
                          icon: Icon(
                            _selectAll ? Icons.deselect : Icons.select_all,
                            size: 18,
                          ),
                          label: Text(
                            _selectAll ? 'Bỏ chọn tất cả' : 'Chọn tất cả',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _selectedCount > 0
                              ? _submitAllGrades
                              : null,
                          icon: const Icon(Icons.send, size: 18),
                          label: const Text('Nộp điểm'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Danh sách sinh viên
          ..._students.map((student) {
            return StudentItemSection(
              student: student,
              showCheckbox: _isGradeInputMode,
              isGradeInputMode: _isGradeInputMode,
              onCheckboxChanged: _onStudentCheckboxChanged,
              onGradeSubmit: _onGradeSubmit,
            );
          }).toList(),
        ],
      ),
    );
  }
}
