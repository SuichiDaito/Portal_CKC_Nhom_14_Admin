import 'package:flutter/material.dart';

class NotificationContentDetail extends StatefulWidget {
  final String headerNotification;
  final String linkImage;
  final String contentNotification;

  const NotificationContentDetail({
    super.key,
    required this.headerNotification,
    required this.contentNotification,
    required this.linkImage,
  });

  @override
  State<NotificationContentDetail> createState() => ContentDetail();
}

class ContentDetail extends State<NotificationContentDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.headerNotification,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(widget.linkImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Kính gửi toàn thể cán bộ, công chức, viên chức và người lao động,',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF4A5568),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.contentNotification,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF4A5568),
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
