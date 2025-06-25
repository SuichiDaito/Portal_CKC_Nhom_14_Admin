import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_thong_bao.dart';
import 'package:portal_ckc/api/model/comment.dart';

class NotificationCommentItem extends StatefulWidget {
  final List<ChiTietThongBao> comment;
  NotificationCommentItem({super.key, required this.comment});
  State<NotificationCommentItem> createState() => CommentItem();
}

class CommentItem extends State<NotificationCommentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(22, 0, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.purple[100],
            child: Text(
              widget.comment[0].sinhVien.hoSo.hoTen,
              style: TextStyle(
                color: Colors.purple[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.comment[0].sinhVien.hoSo.hoTen,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "NoiDung",
                    style: const TextStyle(
                      color: Color(0xFF4A5568),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "ThoiGian",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
