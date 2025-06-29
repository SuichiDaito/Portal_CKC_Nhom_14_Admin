import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class BulkActionSection extends StatelessWidget {
  final bool isEditing;
  final bool selectAll;
  final String selectedScore;
  final List<StudentWithScore> students;
  final ValueChanged<bool?> onSelectAll;
  final ValueChanged<String?> onChangeScore;

  const BulkActionSection({
    super.key,
    required this.isEditing,
    required this.selectAll,
    required this.selectedScore,
    required this.students,
    required this.onSelectAll,
    required this.onChangeScore,
  });

  @override
  Widget build(BuildContext context) {
    if (!isEditing) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Checkbox(value: selectAll, onChanged: onSelectAll),
          const Text('Chọn tất cả'),
          const SizedBox(width: 12),
          DropdownButton<String>(
            value: selectedScore,
            onChanged: onChangeScore,
            items: [
              'A',
              'B',
              'C',
              'D',
              'E',
              'F',
            ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          ),
        ],
      ),
    );
  }
}
