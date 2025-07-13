// sections/class_info_section.dart
import 'package:flutter/material.dart';

// models/class_info.dart
class ClassInfo {
  final String className;
  final int totalStudents;
  final String subject;
  final String totalCredits;

  ClassInfo({
    required this.className,
    required this.totalStudents,
    required this.subject,
    required this.totalCredits,
  });
}

// models/student.dart
class Student {
  final String studentId;
  final String fullName;
  final String status;
  bool isSelected;
  StudentGrade? grade;

  Student({
    required this.studentId,
    required this.fullName,
    required this.status,
    this.isSelected = false,
    this.grade,
  });
}

// models/student_grade.dart
class StudentGrade {
  double attendanceScore;
  double processScore;
  double examScore;
  double finalScore;

  StudentGrade({
    this.attendanceScore = 0.0,
    this.processScore = 0.0,
    this.examScore = 0.0,
    this.finalScore = 0.0,
  });

  void calculateFinalScore() {
    finalScore =
        (attendanceScore * 0.1) + (processScore * 0.3) + (examScore * 0.6);
  }
}

class ClassListStudenInforClassSection extends StatelessWidget {
  final ClassInfo classInfo;

  const ClassListStudenInforClassSection({Key? key, required this.classInfo})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.class_, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  classInfo.className,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  icon: Icons.people,
                  title: 'Sĩ số',
                  value: '${classInfo.totalStudents}',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoCard(
                  icon: Icons.book,
                  title: 'Môn học',
                  value: classInfo.subject,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            icon: Icons.credit_card,
<<<<<<< HEAD
            title: 'Chương trình đào tạo',
=======
            title: 'Tổng số tín chỉ',
>>>>>>> main
            value: '${classInfo.totalCredits}',
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    bool fullWidth = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
