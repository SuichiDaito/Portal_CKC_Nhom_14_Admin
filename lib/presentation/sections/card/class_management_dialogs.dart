import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/presentation/sections/card/class_management_card.dart';

void showClassListDialog(
  BuildContext context,
  List<ClassInfo> classList,
  Function(ClassInfo) onTapClass,
) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.maxFinite,
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Danh Sách Lớp Chi Tiết',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: classList.length,
                itemBuilder: (context, index) {
                  final classInfo = classList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF1976D2),
                      child: Text(
                        classInfo.className.substring(4, 6),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      classInfo.className,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${classInfo.studentCount} sinh viên - ${classInfo.course}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/admin/class_detail_admin');
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Đóng'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void showClassDetailsDialog(BuildContext context, ClassInfo classInfo) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Thông tin lớp ${classInfo.className}',
        style: const TextStyle(color: Color(0xFF1976D2)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Tên lớp:', classInfo.className),
          _buildDetailRow('Sĩ số:', '${classInfo.studentCount} sinh viên'),
          _buildDetailRow('Khóa:', classInfo.course),
          _buildDetailRow('Học kỳ:', classInfo.semester),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Xem Chi Tiết'),
          onPressed: () {
            GoRouter.of(context).push('/admin/class_detail_admin');
          },
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Đóng'),
        ),
      ],
    ),
  );
}

Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(value)),
      ],
    ),
  );
}
