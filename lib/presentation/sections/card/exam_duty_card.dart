import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_lich_thi.dart';

class ExamDutyCard extends StatelessWidget {
  final ExamSchedule duty;

  const ExamDutyCard({required this.duty});
  String _getRealStatus(String ngayThi, String gioBatDau) {
    try {
      final now = DateTime.now();
      final ngayGioThi = DateTime.parse('$ngayThi $gioBatDau');
      final thiStart = DateTime(
        ngayGioThi.year,
        ngayGioThi.month,
        ngayGioThi.day,
      );
      final today = DateTime(now.year, now.month, now.day);

      if (thiStart.isBefore(today)) return 'Đã hoàn thành';
      if (thiStart.isAfter(today)) return 'Chưa diễn ra';
      return 'Đang diễn ra';
    } catch (e) {
      return 'Không xác định';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.supervisor_account, color: Colors.blue[700], size: 18),
              SizedBox(width: 6),
              Text(
                '${duty.giamThi1.hoSo?.hoTen} & ${duty.giamThi2.hoSo?.hoTen}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Ngày thi: ${duty.ngayThi}'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Bắt đầu: ${duty.gioBatDau} | ${duty.thoiGianThi} phút'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.meeting_room, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Phòng: ${duty.phong?.ten}'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.check_circle, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text(
                'Trạng thái: ${_getRealStatus(duty.ngayThi, duty.gioBatDau)}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
