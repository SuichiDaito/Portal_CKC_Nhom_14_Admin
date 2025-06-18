import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/pages/page_teacher_management_admin.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

class TeacherDetailBottomSheet extends StatefulWidget {
  final Teacher teacher;
  final ValueChanged<Teacher> onUpdatePosition; // Callback khi cập nhật chức vụ

  const TeacherDetailBottomSheet({
    Key? key,
    required this.teacher,
    required this.onUpdatePosition,
  }) : super(key: key);

  @override
  _TeacherDetailBottomSheetState createState() =>
      _TeacherDetailBottomSheetState();
}

class _TeacherDetailBottomSheetState extends State<TeacherDetailBottomSheet> {
  late TeacherPosition _selectedPosition;
  bool _isEditingPosition = false;

  @override
  void initState() {
    super.initState();
    _selectedPosition = widget.teacher.position;
  }

  String _getPositionText(TeacherPosition position) {
    switch (position) {
      case TeacherPosition.dean:
        return 'Trưởng khoa';
      case TeacherPosition.viceDean:
        return 'Phó khoa';
      case TeacherPosition.lecturer:
        return 'Giảng viên';
      case TeacherPosition.staff:
        return 'Nhân viên';
    }
  }

  Color _getPositionColor(TeacherPosition position) {
    switch (position) {
      case TeacherPosition.dean:
        return Colors.red.shade700;
      case TeacherPosition.viceDean:
        return Colors.orange.shade700;
      case TeacherPosition.lecturer:
        return Colors.blue.shade700;
      case TeacherPosition.staff:
        return Colors.green.shade700;
    }
  }

  List<DropdownItem> _getPositionOptions() {
    return TeacherPosition.values.map((position) {
      return DropdownItem(
        value: position.toString(),
        label: _getPositionText(position),
        icon: Icons.keyboard_option_key,
      );
    }).toList();
  }

  void _savePosition() {
    widget.onUpdatePosition(
      widget.teacher.copyWith(position: _selectedPosition),
    );
    setState(() {
      _isEditingPosition = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã cập nhật chức vụ giáo viên.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông tin chi tiết giáo viên',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          _buildInfoRow('Khoa:', widget.teacher.faculty),
          _buildInfoRow('Bộ môn:', widget.teacher.department),
          _buildInfoRow('Mã GV:', widget.teacher.teacherCode),
          _buildInfoRow('Tên GV:', widget.teacher.fullName),
          _buildInfoRow(
            'Email:',
            widget.teacher.email.isEmpty
                ? 'Chưa cập nhật'
                : widget.teacher.email,
          ),
          _buildInfoRow(
            'SĐT:',
            widget.teacher.phoneNumber.isEmpty
                ? 'Chưa cập nhật'
                : widget.teacher.phoneNumber,
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Chức vụ:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 10),
              if (!_isEditingPosition)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _getPositionColor(
                      widget.teacher.position,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _getPositionColor(widget.teacher.position),
                    ),
                  ),
                  child: Text(
                    _getPositionText(widget.teacher.position),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _getPositionColor(widget.teacher.position),
                    ),
                  ),
                ),
              if (_isEditingPosition)
                Expanded(
                  child: DropdownSelector(
                    label: '',
                    selectedItem: _getPositionOptions().firstWhere(
                      (item) => item.value == _selectedPosition.toString(),
                    ),
                    items: _getPositionOptions(),
                    onChanged: (item) {
                      if (item != null) {
                        setState(() {
                          _selectedPosition = TeacherPosition.values.firstWhere(
                            (e) => e.toString() == item.value,
                          );
                        });
                      }
                    },
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButton(
              text: _isEditingPosition ? 'Lưu chức vụ' : 'Sửa chức vụ',
              onPressed: () {
                setState(() {
                  if (_isEditingPosition) {
                    _savePosition();
                  } else {
                    _isEditingPosition = true;
                  }
                });
              },
              backgroundColor: _isEditingPosition
                  ? Colors.green
                  : Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
