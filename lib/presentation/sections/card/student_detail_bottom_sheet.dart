import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/studen_model.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

class StudentDetailBottomSheet extends StatefulWidget {
  final Student student;
  final ValueChanged<Student>
  onUpdateStatus; // Callback khi cập nhật trạng thái

  const StudentDetailBottomSheet({
    Key? key,
    required this.student,
    required this.onUpdateStatus,
  }) : super(key: key);

  @override
  _StudentDetailBottomSheetState createState() =>
      _StudentDetailBottomSheetState();
}

class _StudentDetailBottomSheetState extends State<StudentDetailBottomSheet> {
  late StudentStatus _selectedStatus;
  bool _isEditingStatus = false;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.student.status;
  }

  String _getStatusText(StudentStatus status) {
    switch (status) {
      case StudentStatus.active:
        return 'Đang học';
      case StudentStatus.inactive:
        return 'Nghỉ học';
      case StudentStatus.graduated:
        return 'Đã tốt nghiệp';
      case StudentStatus.suspended:
        return 'Đình chỉ';
    }
  }

  Color _getStatusColor(StudentStatus status) {
    switch (status) {
      case StudentStatus.active:
        return Colors.green;
      case StudentStatus.inactive:
        return Colors.orange;
      case StudentStatus.graduated:
        return Colors.blueGrey;
      case StudentStatus.suspended:
        return Colors.red;
    }
  }

  List<DropdownItem> _getStatusOptions() {
    return StudentStatus.values.map((status) {
      return DropdownItem(
        value: status.toString(),
        label: _getStatusText(status),
        icon: Icons.keyboard_option_key,
      );
    }).toList();
  }

  void _saveStatus() {
    widget.onUpdateStatus(widget.student.copyWith(status: _selectedStatus));
    setState(() {
      _isEditingStatus = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã cập nhật trạng thái sinh viên.')),
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
                'Thông tin chi tiết sinh viên',
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
          _buildInfoRow('Lớp:', widget.student.className),
          _buildInfoRow('MSSV:', widget.student.studentCode),
          _buildInfoRow('Tên sinh viên:', widget.student.fullName),
          _buildInfoRow(
            'Email:',
            widget.student.email.isEmpty
                ? 'Chưa cập nhật'
                : widget.student.email,
          ),
          _buildInfoRow(
            'SĐT:',
            widget.student.phoneNumber.isEmpty
                ? 'Chưa cập nhật'
                : widget.student.phoneNumber,
          ),
          _buildInfoRow(
            'Ngày sinh:',
            DateFormat('dd/MM/yyyy').format(widget.student.dateOfBirth),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Trạng thái:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 10),
              if (!_isEditingStatus)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      widget.student.status,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _getStatusColor(widget.student.status),
                    ),
                  ),
                  child: Text(
                    _getStatusText(widget.student.status),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(widget.student.status),
                    ),
                  ),
                ),
              if (_isEditingStatus)
                Expanded(
                  child: DropdownSelector(
                    label: '',
                    selectedItem: _getStatusOptions().firstWhere(
                      (item) => item.value == _selectedStatus.toString(),
                    ),
                    items: _getStatusOptions(),
                    onChanged: (item) {
                      if (item != null) {
                        setState(() {
                          _selectedStatus = StudentStatus.values.firstWhere(
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
              text: _isEditingStatus ? 'Lưu trạng thái' : 'Sửa trạng thái',
              onPressed: () {
                setState(() {
                  if (_isEditingStatus) {
                    _saveStatus();
                  } else {
                    _isEditingStatus = true;
                  }
                });
              },
              backgroundColor: _isEditingStatus
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
            width: 130,
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
