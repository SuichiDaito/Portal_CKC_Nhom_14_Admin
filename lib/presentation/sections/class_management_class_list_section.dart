import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:portal_ckc/api/model/admin_lop.dart';

Widget buildClassListSection({
  required List<Lop> classList,
  required Function(Lop) onTapClass,
=======
import 'package:portal_ckc/presentation/sections/card/class_management_card.dart';

Widget buildClassListSection({
  required List<ClassInfo> classList,
  required Function(ClassInfo) onTapClass,
>>>>>>> origin/develop
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Danh Sách Lớp (${classList.length} lớp)',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1976D2),
        ),
      ),
      const SizedBox(height: 12),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: classList.length,
        itemBuilder: (context, index) {
          return _buildClassCard(classList[index], onTapClass);
        },
      ),
    ],
  );
}

<<<<<<< HEAD
Widget _buildClassCard(Lop classInfo, Function(Lop) onTap) {
=======
Widget _buildClassCard(ClassInfo classInfo, Function(ClassInfo) onTap) {
>>>>>>> origin/develop
  return Card(
    elevation: 3,
    margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: InkWell(
      onTap: () => onTap(classInfo),
<<<<<<< HEAD

=======
>>>>>>> origin/develop
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
<<<<<<< HEAD
                  classInfo.tenLop,
=======
                  classInfo.className,
>>>>>>> origin/develop
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1976D2).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
<<<<<<< HEAD
                    classInfo.nienKhoa.tenNienKhoa,
=======
                    classInfo.course,
>>>>>>> origin/develop
                    style: const TextStyle(
                      color: Color(0xFF1976D2),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
<<<<<<< HEAD
                _buildClassInfoItem(Icons.groups, 'Sĩ số: ${classInfo.siSo}'),
                const SizedBox(width: 20),
                // _buildClassInfoItem(Icons.schedule, classInfo.),
=======
                _buildClassInfoItem(
                  Icons.groups,
                  'Sĩ số: ${classInfo.studentCount}',
                ),
                const SizedBox(width: 20),
                _buildClassInfoItem(Icons.schedule, classInfo.semester),
>>>>>>> origin/develop
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildClassInfoItem(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, size: 16, color: Colors.grey[600]),
      const SizedBox(width: 4),
      Text(
        text,
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
