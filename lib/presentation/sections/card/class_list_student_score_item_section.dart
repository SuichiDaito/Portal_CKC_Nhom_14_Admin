import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien_lhp.dart';
import 'package:portal_ckc/presentation/sections/card/class_list_student_grade_input_section.dart';

class StudentItemSection extends StatefulWidget {
  final SinhVienLopHocPhan student;
  final bool showCheckbox;
  final Function(SinhVienLopHocPhan, bool) onCheckboxChanged;
  final Function(SinhVienLopHocPhan) onGradeSubmit;
  final int trangThaiLop;

  const StudentItemSection({
    Key? key,
    required this.student,
    required this.trangThaiLop,
    required this.showCheckbox,
    required this.onCheckboxChanged,
    required this.onGradeSubmit,
  }) : super(key: key);

  @override
  State<StudentItemSection> createState() => _StudentItemSectionState();
}

class _StudentItemSectionState extends State<StudentItemSection> {
  bool _isGradeExpanded = true;

  String _getStatusText(int statusCode) {
    return switch (statusCode) {
      0 => 'Đang học',
      1 => 'Nghỉ học',
      _ => 'Không rõ',
    };
  }

  Color _getStatusColor(int statusCode) {
    return switch (statusCode) {
      0 => Colors.green,
      1 => Colors.red,
      _ => Colors.grey,
    };
  }

  IconData _getStatusIcon(int statusCode) {
    return switch (statusCode) {
      0 => Icons.check_circle,
      1 => Icons.cancel,
      _ => Icons.help_outline,
    };
  }

  @override
  Widget build(BuildContext context) {
    final statusCode = widget.student.sinhVien.trangThai ?? 0;
    final hasGrades = widget.student.diemTongKet != null;

    final bool isLocked = widget.trangThaiLop == 3;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    if (widget.showCheckbox)
                      Checkbox(
                        value: widget.student.isSelected,
                        onChanged: (value) {
                          widget.onCheckboxChanged(
                            widget.student,
                            value ?? false,
                          );
                          setState(() {
                            _isGradeExpanded = !_isGradeExpanded;
                          });
                        },
                        activeColor: Colors.blue.shade600,
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  widget.student.sinhVien.maSv,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(
                                    statusCode,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      _getStatusIcon(statusCode),
                                      size: 12,
                                      color: _getStatusColor(statusCode),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _getStatusText(statusCode),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getStatusColor(statusCode),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.student.sinhVien.hoSo.hoTen,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isGradeExpanded = !_isGradeExpanded;
                        });
                      },
                      icon: Icon(
                        _isGradeExpanded
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: Colors.blue.shade600,
                      ),
                      tooltip: 'Xem/Sửa điểm',
                    ),
                  ],
                ),
                if (hasGrades && !_isGradeExpanded)
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.grade,
                              size: 16,
                              color: Colors.green.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Tổng kết: ${widget.student.diemTongKet?.toStringAsFixed(1) ?? "0"}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (_isGradeExpanded)
            Column(
              children: [
                GradeInputSection(
                  student: widget.student,
                  isExpanded: _isGradeExpanded,
                  isSubmitEnabled: !isLocked,
                  isEditing: true,
                  canEditDiemChuyenCan: widget.trangThaiLop == 0,
                  canEditDiemQuaTrinh: widget.trangThaiLop == 0,
                  canEditDiemThi: widget.trangThaiLop == 1,
                  canEditDiemThiLan2: widget.trangThaiLop == 2,
                  onGradeSubmit: (updatedStudent) {
                    setState(() {
                      widget.student
                        ..diemChuyenCan = updatedStudent.diemChuyenCan
                        ..diemQuaTrinh = updatedStudent.diemQuaTrinh
                        ..diemThiLan1 = updatedStudent.diemThiLan1
                        ..diemThiLan2 = updatedStudent.diemThiLan2
                        ..diemTongKet = updatedStudent.diemTongKet;
                    });
                    widget.onGradeSubmit(updatedStudent);
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
