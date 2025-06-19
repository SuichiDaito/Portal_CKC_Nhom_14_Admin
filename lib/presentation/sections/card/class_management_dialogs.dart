import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
<<<<<<< HEAD
import 'package:portal_ckc/api/model/admin_lop.dart';
=======
>>>>>>> origin/develop
import 'package:portal_ckc/presentation/sections/card/class_management_card.dart';

void showClassListDialog(
  BuildContext context,
<<<<<<< HEAD
  List<Lop> classList,
  Function(Lop) onTapClass,
=======
  List<ClassInfo> classList,
  Function(ClassInfo) onTapClass,
>>>>>>> origin/develop
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
<<<<<<< HEAD
              'Danh Sách Lớp Chi Tiết',
=======
              'Chi Tiết Danh Sách Lớp',
>>>>>>> origin/develop
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
<<<<<<< HEAD
                        classInfo.tenLop.substring(4, 6),
=======
                        classInfo.className.substring(4, 6),
>>>>>>> origin/develop
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
<<<<<<< HEAD
                      classInfo.tenLop,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${classInfo.siSo} sinh viên '),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.pop(context);
                      context.push(
                        '/admin/class_detail_admin',
                        extra: classInfo,
                      ); // lop là đối tượng Lop
=======
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
>>>>>>> origin/develop
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

<<<<<<< HEAD
void showClassDetailsDialog(BuildContext context, Lop classInfo) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Thông tin lớp ${classInfo.tenLop}',
        style: const TextStyle(color: Color(0xFF1976D2)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Tên lớp:', classInfo.tenLop),
          _buildDetailRow('Sĩ số:', '${classInfo.siSo} sinh viên'),
          _buildDetailRow('Khóa:', classInfo.nienKhoa.tenNienKhoa),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Xem Chi Tiết'),
          onPressed: () {
            Navigator.pop(context);
            context.push(
              '/admin/class_detail_admin',
              extra: classInfo,
            ); // lop là đối tượng Lop
          },
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Đóng'),
=======
void showClassDetailsDialog(BuildContext context, ClassInfo classInfo) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildInfSectionSClass(classInfo, context)],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // Handle "Xem Chi Tiết"
                  GoRouter.of(context).push('/admin/class_detail_admin');
                },
                icon: Icon(Icons.visibility, size: 18),
                label: Text('Xem Chi Tiết'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue[700],
                  side: BorderSide(color: Colors.blue[700]!),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  context.pop(true);
                },
                icon: Icon(Icons.close, size: 18),
                label: Text('Đóng'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
>>>>>>> origin/develop
        ),
      ],
    ),
  );
}

<<<<<<< HEAD
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
=======
Widget _buildInfSectionSClass(ClassInfo classInfo, BuildContext context) {
  return Column(
    children: [
      // Header Section
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[600]!, Colors.blue[700]!],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.class_, color: Colors.white, size: 24),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông tin lớp ${classInfo.className} ',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'CDTH22E',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // Information Content
      Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            _buildInfoItem(
              icon: Icons.label,
              iconColor: Colors.blue[600]!,
              label: 'Tên lớp',
              value: 'CDTH22E',
            ),
            SizedBox(height: 20),
            _buildInfoItem(
              icon: Icons.people,
              iconColor: Colors.green[600]!,
              label: 'Số số',
              value: '45 sinh viên',
            ),
            SizedBox(height: 20),
            _buildInfoItem(
              icon: Icons.school,
              iconColor: Colors.orange[600]!,
              label: 'Khóa',
              value: 'K22',
            ),
            SizedBox(height: 20),
            _buildInfoItem(
              icon: Icons.calendar_today,
              iconColor: Colors.purple[600]!,
              label: 'Học kỳ',
              value: 'HK2 2024-2025',
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ],
  );
}

Widget _buildInfoItem({
  required IconData icon,
  required Color iconColor,
  required String label,
  required String value,
}) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ],
>>>>>>> origin/develop
  );
}
