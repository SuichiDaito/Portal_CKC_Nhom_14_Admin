// sections/student_item_section.dart
import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien_lhp.dart';
// import 'package:portal_ckc/presentation/sections/card/class_list_studen_infor_class_section.dart';
import 'package:portal_ckc/presentation/sections/card/class_list_student_grade_input_section.dart';

class StudentItemSection extends StatefulWidget {
  final SinhVienLopHocPhan student;
  final bool showCheckbox;
  final bool isGradeInputMode;
  final Function(SinhVienLopHocPhan, bool) onCheckboxChanged;
  final Function(SinhVienLopHocPhan) onGradeSubmit;

  const StudentItemSection({
    Key? key,
    required this.student,
    required this.showCheckbox,
    required this.isGradeInputMode,
    required this.onCheckboxChanged,
    required this.onGradeSubmit,
  }) : super(key: key);

  @override
  State<StudentItemSection> createState() => _StudentItemSectionState();
}

class _StudentItemSectionState extends State<StudentItemSection> {
  bool _isGradeExpanded = false;
  String _getStatusText(int statusCode) {
    switch (statusCode) {
      case 0:
        return 'Đang học';
      case 1:
        return 'Nghỉ học';
      default:
        return 'Không rõ';
    }
  }

  Color _getStatusColor(int statusCode) {
    switch (statusCode) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(int statusCode) {
    switch (statusCode) {
      case 0:
        return Icons.check_circle;
      case 1:
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusCode = widget.student.sinhVien.trangThai ?? 0;
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
                        },
                        activeColor: Colors.blue.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
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
                                    widget.student.sinhVien.trangThai,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getStatusIcon(
                                        widget.student.sinhVien.trangThai,
                                      ),
                                      size: 12,
                                      color: _getStatusColor(
                                        widget.student.sinhVien.trangThai,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _getStatusText(statusCode),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: _getStatusColor(
                                          widget.student.sinhVien.trangThai,
                                        ),
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
                    if (!widget.showCheckbox)
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
                        tooltip: 'Xem điểm',
                      ),
                  ],
                ),
                if (widget.student.diemChuyenCan != null &&
                    !_isGradeExpanded &&
                    !widget.isGradeInputMode)
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
                              'Đã có điểm',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Tổng kết: ${widget.student.diemTongKet!.toStringAsFixed(1)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          GradeInputSection(
            student: widget.student,
            onGradeSubmit: (updatedStudent) {
              setState(() {
                widget.student.diemChuyenCan = updatedStudent.diemChuyenCan;
                widget.student.diemQuaTrinh = updatedStudent.diemQuaTrinh;
                widget.student.diemThi = updatedStudent.diemThi;
                widget.student.diemTongKet = updatedStudent.diemTongKet;
                widget.student.diemLyThuyet = updatedStudent.diemLyThuyet;
              });

              widget.onGradeSubmit(widget.student);
            },

            isExpanded:
                _isGradeExpanded ||
                (widget.isGradeInputMode && widget.student.isSelected),
          ),
        ],
      ),
    );
  }
}
