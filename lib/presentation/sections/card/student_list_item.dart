import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

class StudentListItem extends StatelessWidget {
  final SinhVien student;
  final VoidCallback onDetailPressed;
  final VoidCallback onResetPasswordPressed;

  const StudentListItem({
    Key? key,
    required this.student,
    required this.onDetailPressed,
    required this.onResetPasswordPressed,
  }) : super(key: key);

  Color _getStatusColor(int? statusIndex) {
    switch (statusIndex) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.blueGrey;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(int? statusIndex) {
    switch (statusIndex) {
      case 0:
        return 'Đang học';
      case 1:
        return 'Đã tốt nghiệp';
      case 2:
        return 'Nghỉ học';
      case 3:
        return 'Đình chỉ';
      default:
        return 'Không rõ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        student.hoSo?.hoTen ?? 'Chưa có tên',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24, thickness: 1),

                  _buildInfoRow(Icons.badge, 'MSSV', student.maSv),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.email, 'Email', student.hoSo?.email),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.phone, 'SĐT', student.hoSo?.soDienThoai),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.orange),
                      const SizedBox(width: 8),
                      const Text(
                        'Trạng thái:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(
                            student.trangThai,
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: _getStatusColor(student.trangThai),
                          ),
                        ),
                        child: Text(
                          _getStatusText(student.trangThai),
                          style: TextStyle(
                            color: _getStatusColor(student.trangThai),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        text: 'Xem chi tiết',
                        onPressed: onDetailPressed,
                        backgroundColor: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      CustomButton(
                        text: 'Đặt lại mật khẩu',
                        onPressed: onResetPasswordPressed,
                        backgroundColor: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54, size: 20),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value ?? '—',
            style: const TextStyle(fontSize: 15),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
