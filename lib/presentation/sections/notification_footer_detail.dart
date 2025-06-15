import 'package:flutter/material.dart';

// count comment in notification in detail.
class NotificationFooterDetail extends StatefulWidget {
  final String lengthComment;
  NotificationFooterDetail({super.key, required this.lengthComment});
  State<NotificationFooterDetail> createState() => _FooterDetail();
}

class _FooterDetail extends State<NotificationFooterDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Icon(Icons.comment, size: 18, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Text(
                '${widget.lengthComment} bình luận',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
