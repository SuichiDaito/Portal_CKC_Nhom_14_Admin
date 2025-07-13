import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

class TeacherListItem extends StatelessWidget {
  final User teacher;
  final VoidCallback onDetailPressed;
  final VoidCallback onResetPasswordPressed;

  const TeacherListItem({
    Key? key,
    required this.teacher,
    required this.onDetailPressed,
    required this.onResetPasswordPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  teacher.hoSo!.hoTen,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(),
            _buildInfoRow(
              Icons.school,
              'Khoa',
              teacher.boMon?.chuyenNganh?.khoa?.tenKhoa,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.group, 'Bộ môn', teacher.boMon?.tenBoMon),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.badge, 'Mã giảng viên', 'GV00${teacher.id}'),
            const SizedBox(height: 8),
            _buildRoleRow(
              Icons.work,
              'Chức vụ',
                  ? teacher.roles![0].name
                  : 'Không rõ',
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  text: 'Xem chi tiết',
                  onPressed: onDetailPressed,
                  backgroundColor: Colors.blue.shade600,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),);
  }
}
