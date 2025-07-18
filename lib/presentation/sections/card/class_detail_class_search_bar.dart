import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/admin_danh_sach_lop.dart';

class ClassSearchBar extends StatelessWidget {
  final String searchQuery;
  final String selectedStatus;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onStatusChanged;
  final List<StudentWithRole> studentList;
  final int idClass;
  final int idNienKhoa;

  const ClassSearchBar({
    super.key,
    required this.searchQuery,
    required this.selectedStatus,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.studentList,
    required this.idClass,
    required this.idNienKhoa,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Tìm theo tên hoặc MSSV',
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: onSearchChanged,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () => context.push(
                    '/admin/conduct_evaluation_admin/${idClass}/${idNienKhoa}',
                  ),

                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Nhập điểm'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
