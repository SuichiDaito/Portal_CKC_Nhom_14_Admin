import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/pages/page_teaching_schedule_admin.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_subject_card.dart';

class SessionSchedule extends StatelessWidget {
  final String session;
  final List<Subject> subjects;

  const SessionSchedule({required this.session, required this.subjects});

  @override
  Widget build(BuildContext context) {
    if (subjects.isEmpty) return Container();

    Color sessionColor;
    switch (session) {
      case 'Sáng':
        sessionColor = Colors.orange[100]!;
        break;
      case 'Chiều':
        sessionColor = Colors.green[100]!;
        break;
      case 'Tối':
        sessionColor = Colors.purple[100]!;
        break;
      default:
        sessionColor = Colors.grey[100]!;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: sessionColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '$session (${_getSessionTime(session)})',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          ...subjects.map((subject) => SubjectCard(subject: subject)).toList(),
        ],
      ),
    );
  }

  String _getSessionTime(String session) {
    switch (session) {
      case 'Sáng':
        return 'Tiết 1-6';
      case 'Chiều':
        return 'Tiết 7-12';
      case 'Tối':
        return 'Tiết 13-15';
      default:
        return '';
    }
  }
}
