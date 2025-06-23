// screens/student_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien_lhp.dart';
import 'package:portal_ckc/bloc/bloc_event_state/sinh_vien_lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/event/sinh_vien_lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/state/sinh_vien_lop_hoc_phan_state.dart';
import 'package:portal_ckc/presentation/sections/card/class_list_studen_infor_class_section.dart';
import 'package:portal_ckc/presentation/sections/card/class_list_student_score_item_section.dart';

class PageCourseSectionStudentList extends StatefulWidget {
  final int idLopHocPhan;
  const PageCourseSectionStudentList({Key? key, required this.idLopHocPhan})
    : super(key: key);

  @override
  State<PageCourseSectionStudentList> createState() =>
      _PageCourseSectionStudentListState();
}

class _PageCourseSectionStudentListState
    extends State<PageCourseSectionStudentList> {
  bool _isGradeInputMode = false;
  bool _selectAll = false;

  void _toggleGradeInputMode() {
    setState(() {
      _isGradeInputMode = !_isGradeInputMode;
      if (!_isGradeInputMode) _selectAll = false;
    });
  }

  void _toggleSelectAll(List<SinhVienLopHocPhan> students) {
    setState(() {
      _selectAll = !_selectAll;
      for (var student in students) {
        student.isSelected = _selectAll;
      }
    });
  }

  void _submitAllGrades(List<SinhVienLopHocPhan> students) {
    List<SinhVienLopHocPhan> selected = students
        .where((s) => s.isSelected)
        .toList();
    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn ít nhất một sinh viên')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận nộp điểm'),
        content: Text(
          'Bạn có chắc chắn muốn nộp điểm cho ${selected.length} sinh viên?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: call API to save selected students' grades
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Đã nộp điểm cho ${selected.length} sinh viên'),
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SinhVienLhpBloc()..add(FetchSinhVienLhp(widget.idLopHocPhan)),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text(
            'Danh sách sinh viên',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleGradeInputMode,
          tooltip: _isGradeInputMode ? 'Thoát nhập điểm' : 'Nhập điểm',
          backgroundColor: _isGradeInputMode ? Colors.red : Colors.blue,
          foregroundColor: Colors.white,
          child: Icon(_isGradeInputMode ? Icons.close : Icons.edit),
        ),
        body: BlocBuilder<SinhVienLhpBloc, SinhVienLhpState>(
          builder: (context, state) {
            if (state is SinhVienLhpLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SinhVienLhpError) {
              return Center(child: Text(state.message));
            } else if (state is SinhVienLhpLoaded) {
              final classInfo = state.lopHocPhan;
              final students = state.danhSach;
              final selectedCount = students.where((s) => s.isSelected).length;

              return ListView(
                padding: const EdgeInsets.only(bottom: 16),
                children: [
                  if (classInfo != null)
                    ClassListStudenInforClassSection(
                      classInfo: ClassInfo(
                        className: classInfo.lop.tenLop,
                        totalStudents: students.length,
                        subject: classInfo.tenHocPhan,
                        totalCredits:
                            classInfo.chuongTrinhDaoTao.tenChuongTrinhDaoTao,
                      ),
                    ),

                  if (_isGradeInputMode)
                    Container(
                      margin: const EdgeInsets.all(16),
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
                              Icon(
                                Icons.assignment,
                                color: Colors.blue.shade700,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Chế độ nhập điểm',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Đã chọn: $selectedCount',
                                style: TextStyle(color: Colors.blue.shade600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => _toggleSelectAll(students),
                                  icon: Icon(
                                    _selectAll
                                        ? Icons.deselect
                                        : Icons.select_all,
                                  ),
                                  label: Text(
                                    _selectAll
                                        ? 'Bỏ chọn tất cả'
                                        : 'Chọn tất cả',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: selectedCount > 0
                                      ? () => _submitAllGrades(students)
                                      : null,
                                  icon: const Icon(Icons.send),
                                  label: const Text('Nộp điểm'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ...students.map(
                    (student) => StudentItemSection(
                      student: student,
                      showCheckbox: _isGradeInputMode,
                      isGradeInputMode: _isGradeInputMode,
                      onCheckboxChanged: (s, selected) =>
                          setState(() => s.isSelected = selected),
                      onGradeSubmit: (updatedStudent) {
                        setState(() {
                          // Không cần gọi lại gì ở đây nếu bạn chỉ cập nhật student đã có
                          // Nếu bạn cần xử lý khác (như lưu vào backend), gọi API ở đây
                        });
                      },
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('Không có dữ liệu'));
          },
        ),
      ),
    );
  }
}
