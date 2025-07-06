import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

class TeacherDetailBottomSheet extends StatefulWidget {
  final User teacher;
  final ValueChanged<User> onUpdatePosition;

  const TeacherDetailBottomSheet({
    Key? key,
    required this.teacher,
    required this.onUpdatePosition,
  }) : super(key: key);

  @override
  State<TeacherDetailBottomSheet> createState() =>
      _TeacherDetailBottomSheetState();
}

class _TeacherDetailBottomSheetState extends State<TeacherDetailBottomSheet> {
  late TeacherPosition _selectedPosition;
  bool _isEditingPosition = false;

  @override
  void initState() {
    super.initState();
    _selectedPosition = TeacherPosition.lecturer;
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
      case TeacherPosition.director:
        return 'Trưởng phòng';
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
      case TeacherPosition.director:
        return Colors.pink;
    }
  }

  List<DropdownItem> _getPositionOptions() {
    return TeacherPosition.values.map((position) {
      return DropdownItem(
        value: position.toString(),
        label: _getPositionText(position),
        icon: Icons.badge,
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
    final user = widget.teacher;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Thông tin chi tiết giáo viên',
                  style: TextStyle(
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
            // _buildInfoRow(
            //   Icons.school,
            //   'Khoa:',
            //   user.boMon!.nganhHoc!.khoa!.tenKhoa,
            // ),
            _buildInfoRow(Icons.account_tree, 'Bộ môn:', user.boMon!.tenBoMon),
            _buildInfoRow(Icons.badge, 'Mã GV:', "GV00${user.id}"),
            _buildInfoRow(Icons.person, 'Tên GV:', user.hoSo!.hoTen),
            _buildInfoRow(
              Icons.email,
              'Email:',
              user.hoSo!.email.isEmpty ? 'Chưa cập nhật' : user.hoSo!.email,
            ),
            _buildInfoRow(
              Icons.phone,
              'SĐT:',
              user.hoSo!.soDienThoai.isEmpty
                  ? 'Chưa cập nhật'
                  : user.hoSo!.soDienThoai,
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
                        _selectedPosition,
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _getPositionColor(_selectedPosition),
                      ),
                    ),
                    child: Text(
                      _getPositionText(_selectedPosition),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _getPositionColor(_selectedPosition),
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
                            _selectedPosition = TeacherPosition.values
                                .firstWhere((e) => e.toString() == item.value);
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
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blueAccent),
          const SizedBox(width: 8),
          SizedBox(
            width: 100,
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
