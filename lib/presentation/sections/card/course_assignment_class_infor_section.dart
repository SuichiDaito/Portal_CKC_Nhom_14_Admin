import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/pages/page_course_assignment_admin.dart';

class ClassListSection extends StatefulWidget {
  final List<ClassInfoAssignment> classes;
  final Function(String, String, String) onClassInfoChanged;

  const ClassListSection({
    Key? key,
    required this.classes,
    required this.onClassInfoChanged,
  }) : super(key: key);

  @override
  State<ClassListSection> createState() => _ClassListSectionState();
}

class _ClassListSectionState extends State<ClassListSection> {
  final Map<String, bool> _editingStates = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.classes.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final classInfo = widget.classes[index];
              return _buildClassCard(context, classInfo);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1976D2).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.class_, color: Color(0xFF1976D2)),
        ),
        const SizedBox(width: 12),
        const Text(
          'Danh sách lớp học phần',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1976D2),
          ),
        ),
      ],
    );
  }

  Widget _buildClassCard(BuildContext context, ClassInfoAssignment classInfo) {
    final isEditing = _editingStates[classInfo.id] ?? false;

    List<String> instructors = [
      'Nguyễn Văn A',
      'Trần Thị B',
      'Phạm Văn C',
      'Lê Thị D',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tên lớp
          Text(
            classInfo.className,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // Môn học + Loại lớp
          Row(
            children: [
              Expanded(
                child: _buildInfoRow(
                  Icons.menu_book_outlined,
                  classInfo.subject,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoRow(Icons.category_outlined, classInfo.type),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Khoa + Niên khóa
          Row(
            children: [
              Expanded(
                child: _buildInfoRow(
                  Icons.account_tree_outlined,
                  classInfo.department,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoRow(
                  Icons.calendar_today_outlined,
                  'Niên khóa: ${classInfo.academicYear}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Học kỳ
          _buildInfoRow(
            Icons.date_range_outlined,
            'Học kỳ: ${classInfo.semester}',
          ),
          const SizedBox(height: 6),

          // Giảng viên + chỉnh sửa
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.person_outline, size: 16, color: Colors.blue),
              const SizedBox(width: 6),
              Expanded(
                child: AbsorbPointer(
                  absorbing: !isEditing,
                  child: DropdownButtonFormField<String>(
                    value: instructors.contains(classInfo.instructor.trim())
                        ? classInfo.instructor.trim()
                        : null,
                    items: instructors.map((String instructor) {
                      return DropdownMenuItem<String>(
                        value: instructor,
                        child: Text(instructor),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        widget.onClassInfoChanged(
                          classInfo.id,
                          'instructor',
                          value,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: !isEditing,
                      fillColor: !isEditing ? Colors.grey.shade100 : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  isEditing ? Icons.check : Icons.edit,
                  color: isEditing ? Colors.green : Colors.grey,
                ),
                tooltip: isEditing ? 'Xác nhận' : 'Chỉnh sửa',
                onPressed: () {
                  setState(() {
                    _editingStates[classInfo.id] = !isEditing;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }
}
