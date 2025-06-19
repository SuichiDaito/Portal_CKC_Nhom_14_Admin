import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/studen_model.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

class StudentListItem extends StatelessWidget {
  final Student student;
  final VoidCallback onDetailPressed;
  final VoidCallback onResetPasswordPressed;

  const StudentListItem({
    Key? key,
    required this.student,
    required this.onDetailPressed,
    required this.onResetPasswordPressed,
  }) : super(key: key);

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
            Text(
              'Lớp: ${student.className}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: Colors.grey, thickness: 1, height: 20),
            Text(
              'MSSV: ${student.studentCode}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tên: ${student.fullName}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text(
                  'Trạng thái:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(student.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: _getStatusColor(student.status)),
                  ),
                  child: Text(
                    _getStatusText(student.status),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(student.status),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
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
                const SizedBox(width: 8),
                CustomButton(
                  text: 'Đặt lại MK',
                  onPressed: onResetPasswordPressed,
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
