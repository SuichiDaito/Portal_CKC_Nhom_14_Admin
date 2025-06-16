import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/buttons_class_action_class_management.dart';
import 'package:portal_ckc/presentation/sections/card/class_management_teacher_info_card.dart';

class ClassInfo {
  final String className;
  final int studentCount;
  final String course;
  final String semester;

  ClassInfo({
    required this.className,
    required this.studentCount,
    required this.course,
    required this.semester,
  });
}

class ClassManagementCard extends StatefulWidget {
  final String teacherName;
  final String teacherId;
  final String department;
  final List<ClassInfo> classList;

  const ClassManagementCard({
    super.key,
    required this.teacherName,
    required this.teacherId,
    required this.department,
    required this.classList,
  });

  @override
  State<ClassManagementCard> createState() => _ClassManagementCardState();
}

class _ClassManagementCardState extends State<ClassManagementCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TeacherInfoCard(
              teacherName: widget.teacherName,
              teacherId: widget.teacherId,
              department: widget.department,
            ),
            const SizedBox(height: 20),
            ClassActionButtons(onOpenClassList: _showClassListDialog),
            const SizedBox(height: 20),
            _buildClassListSection(),
          ],
        ),
      ),
    );
  }

  void _showClassListDialog() {
    // Bạn có thể truyền thêm logic ở đây nếu cần mở dialog hoặc navigate
  }

  Widget _buildClassListSection() {
    return const Placeholder(); // Tạm thời
  }
}
