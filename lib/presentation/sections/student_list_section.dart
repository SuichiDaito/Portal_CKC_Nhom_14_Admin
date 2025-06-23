import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class StudentListSection extends StatelessWidget {
  final List<StudentWithScore> students;
  final bool isEditing;
  final Function(bool?, int) onSelectChanged;
  final Function(String?, int) onScoreChanged;
  final String Function(String) getScoreLabel;

  const StudentListSection({
    super.key,
    required this.students,
    required this.isEditing,
    required this.onSelectChanged,
    required this.onScoreChanged,
    required this.getScoreLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              leading: isEditing
                  ? Checkbox(
                      value: student.isSelected,
                      onChanged: (value) => onSelectChanged(value, index),
                    )
                  : null,
              title: Text(
                student.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Text('MSSV: ${student.id}'),
              trailing: isEditing
                  ? DropdownButton<String>(
                      value: student.conductScore == '-'
                          ? null
                          : student.conductScore,
                      hint: const Text('Chọn điểm'),
                      onChanged: (value) => onScoreChanged(value, index),
                      items: ['A', 'B', 'C', 'D', 'E', 'F']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Điểm: ${student.conductScore}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          getScoreLabel(student.conductScore),
                          style: TextStyle(
                            fontSize: 12,
                            color: student.conductScore == 'A'
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
