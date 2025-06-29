import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
import 'package:portal_ckc/api/model/studen_model.dart' hide StudentStatus;
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
import 'package:portal_ckc/api/model/studen_model.dart' hide StudentStatus;
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

enum StudentStatus { active, graduated, inactive, suspended }

extension StudentStatusExtension on StudentStatus {
  String get displayName {
    switch (this) {
      case StudentStatus.active:
        return 'Đang học';
      case StudentStatus.graduated:
        return 'Đã tốt nghiệp';
      case StudentStatus.inactive:
        return 'Nghỉ học';
      case StudentStatus.suspended:
        return 'Đình chỉ';
    }
  }

  Color get color {
    switch (this) {
      case StudentStatus.active:
        return Colors.green;
      case StudentStatus.graduated:
        return Colors.blueGrey;
      case StudentStatus.inactive:
        return Colors.orange;
      case StudentStatus.suspended:
        return Colors.red;
    }
  }
}

class StudentDetailBottomSheet extends StatefulWidget {
  final SinhVien student;
  final ValueChanged<SinhVien> onUpdateStatus;

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
    _selectedStatus = StudentStatus.values[widget.student.trangThai];
  }

  List<DropdownItem> _getStatusOptions() {
    return StudentStatus.values.map((status) {
      return DropdownItem(
        value: status.index.toString(),
        label: status.displayName,
        icon: Icons.keyboard_option_key,
      );
    }).toList();
  }

  void _saveStatus() {
    final updatedStudent = SinhVien(
      id: widget.student.id,
      maSv: widget.student.maSv,
      idLop: widget.student.idLop,
      idHoSo: widget.student.idHoSo,
      chucVu: widget.student.chucVu,
      trangThai: _selectedStatus.index,
      hoSo: widget.student.hoSo,
      lop: widget.student.lop,
      diemRenLuyens: [],
    );

    widget.onUpdateStatus(updatedStudent);

    setState(() {
      _isEditingStatus = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã cập nhật trạng thái sinh viên.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentStatus = StudentStatus.values[widget.student.trangThai];
    return Padding(
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
                  'Thông tin chi tiết sinh viên',
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

            const SizedBox(height: 10),

            _buildInfoTile(Icons.badge, 'MSSV', widget.student.maSv),
            _buildInfoTile(
              Icons.person,
              'Tên sinh viên',
              widget.student.hoSo.hoTen,
            ),
            _buildInfoTile(
              Icons.email,
              'Email',
              widget.student.hoSo.email.isEmpty
                  ? 'Chưa cập nhật'
                  : widget.student.hoSo.email,
            ),
            _buildInfoTile(
              Icons.phone,
              'SĐT',
              widget.student.hoSo.soDienThoai.isEmpty
                  ? 'Chưa cập nhật'
                  : widget.student.hoSo.soDienThoai,
            ),
            _buildInfoTile(
              Icons.cake,
              'Ngày sinh',
              DateFormat('dd/MM/yyyy').format(
                DateTime.tryParse(widget.student.hoSo.ngaySinh) ??
                    DateTime(2000),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.info_outline, color: Colors.orange),
                const SizedBox(width: 10),
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
                      color: currentStatus.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: currentStatus.color),
                    ),
                    child: Text(
                      currentStatus.displayName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: currentStatus.color,
                      ),
                    ),
                  ),
                if (_isEditingStatus)
                  Expanded(
                    child: DropdownSelector(
                      label: '',
                      selectedItem: _getStatusOptions().firstWhere(
                        (item) =>
                            item.value == _selectedStatus.index.toString(),
                      ),
                      items: _getStatusOptions(),
                      onChanged: (item) {
                        if (item != null) {
                          setState(() {
                            _selectedStatus =
                                StudentStatus.values[int.parse(item.value)];
                          });
                        }
                      },
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            // Align(
            //   alignment: Alignment.centerRight,
            //   child: CustomButton(
            //     text: _isEditingStatus ? 'Lưu trạng thái' : 'Sửa trạng thái',
            //     onPressed: () {
            //       setState(() {
            //         if (_isEditingStatus) {
            //           _saveStatus();
            //         } else {
            //           _isEditingStatus = true;
            //         }
            //       });
            //     },
            //     backgroundColor: _isEditingStatus
            //         ? Colors.green
            //         : Colors.blueAccent,
            //   ),
            // ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 20),
          const SizedBox(width: 12),
          Icon(icon, color: Colors.blueAccent, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 15, color: Colors.black),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
