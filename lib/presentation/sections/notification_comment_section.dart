import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_thong_bao.dart';
import 'package:portal_ckc/api/model/comment.dart';
import 'package:portal_ckc/presentation/sections/notification_detail_comment_item.dart';
import 'package:portal_ckc/presentation/sections/textfield/comment_input_text_field.dart';

class NotificationCommentSection extends StatefulWidget {
  final String lengthComment;
  final TextEditingController commentController;
  final List<ChiTietThongBao> comments;
  final Function onPressed;
  NotificationCommentSection({
    super.key,
    required this.lengthComment,
    required this.commentController,
    required this.comments,
    required this.onPressed,
  });
  @override
  State<NotificationCommentSection> createState() => CommentSection();
}

class CommentSection extends State<NotificationCommentSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Bình luận (${widget.lengthComment})',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
          ),
          NotificationDetailInputTextField(
            commentController: widget.commentController,
            onPressed: () {},
          ),
          NotificationCommentItem(comment: widget.comments),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
