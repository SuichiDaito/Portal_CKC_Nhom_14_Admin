import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/pages/page_teaching_schedule_admin.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;

  const SubjectCard({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  subject.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blue[800],
                  ),
                ),
              ),
              Text(
                'Tiết ${subject.period}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.class_, size: 14, color: Colors.grey[600]),
              SizedBox(width: 4),
              Text(
                subject.className,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.category, size: 14, color: Colors.grey[600]),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getSubjectTypeColor(subject.type).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  subject.type,
                  style: TextStyle(
                    fontSize: 10,
                    color: _getSubjectTypeColor(subject.type),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.room, size: 14, color: Colors.grey[600]),
              SizedBox(width: 4),
              Text(
                subject.room,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getSubjectTypeColor(String type) {
    switch (type) {
      case 'Đại cương':
        return Colors.orange;
      case 'Cơ sở':
        return Colors.blue;
      case 'Chuyên môn':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
