import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class StudentListSection extends StatefulWidget {
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
  State<StudentListSection> createState() => _StudentListSectionState();
}

class _StudentListSectionState extends State<StudentListSection> {
  final List<String> scoreOptions = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: widget.students.length,
      itemBuilder: (context, index) {
        final student = widget.students[index];
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
            leading: widget.isEditing
                ? Checkbox(
                    value: student.isSelected,
                    onChanged: (value) => widget.onSelectChanged(value, index),
                  )
                : null,
            title: Text(
              student.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: Text('MSSV: ${student.id}'),
            trailing: widget.isEditing
                ? DropdownButton<String>(
                    value: scoreOptions.contains(student.conductScore)
                        ? student.conductScore
                        : null,
                    onChanged: (value) {
                      setState(() {
                        student.conductScore = value ?? student.conductScore;
                      });
                      widget.onScoreChanged(value, index);
                    },
                    items: scoreOptions.map((score) {
                      return DropdownMenuItem(value: score, child: Text(score));
                    }).toList(),
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
                        widget.getScoreLabel(student.conductScore),
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
    );
  }
}
