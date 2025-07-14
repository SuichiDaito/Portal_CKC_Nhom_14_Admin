// widgets/teacher_info_card.dart
import 'package:flutter/material.dart';

// models/class_model.dart
class ClassModel {
  final String id;
  final String className;
  final String subject;
  final String status;
  final String semester;
  final int studentCount;
  final String schedule;
  final String room;

  ClassModel({
    required this.id,
    required this.className,
    required this.subject,
    required this.status,
    required this.semester,
    required this.studentCount,
    required this.schedule,
    required this.room,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] ?? '',
      className: json['className'] ?? '',
      subject: json['subject'] ?? '',
      status: json['status'] ?? '',
      semester: json['semester'] ?? '',
      studentCount: json['studentCount'] ?? 0,
      schedule: json['schedule'] ?? '',
      room: json['room'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'className': className,
      'subject': subject,
      'status': status,
      'semester': semester,
      'studentCount': studentCount,
      'schedule': schedule,
      'room': room,
    };
  }
}

class TeacherModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String title;

  TeacherModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.title,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      department: json['department'] ?? '',
      title: json['title'] ?? '',
    );
  }
}

class TeacherInfoCard extends StatelessWidget {
  final TeacherModel teacher;

  const TeacherInfoCard({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[600]!, Colors.blue[800]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 16),

                // Teacher Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        teacher.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        teacher.title,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        teacher.department,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildContactItem(Icons.email_outlined, teacher.email),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildContactItem(Icons.phone_outlined, teacher.phone),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.9), size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
