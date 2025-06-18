import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/pages/page_teacher_management_admin.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

class TeacherListItem extends StatelessWidget {
  final Teacher teacher;
  final VoidCallback onDetailPressed;
  final VoidCallback onResetPasswordPressed;

  const TeacherListItem({
    Key? key,
    required this.teacher,
    required this.onDetailPressed,
    required this.onResetPasswordPressed,
  }) : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${teacher.faculty}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: Colors.grey, thickness: 1, height: 20),
            const SizedBox(height: 4),
            Text(
              'Bộ môn: ${teacher.department}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Mã giảng viên: ${teacher.teacherCode}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Họ và tên: ${teacher.fullName}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Chức vụ:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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
                    color: _getPositionColor(teacher.position).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: _getPositionColor(teacher.position),
                    ),
                  ),
                  child: Text(
                    _getPositionText(teacher.position),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _getPositionColor(teacher.position),
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
