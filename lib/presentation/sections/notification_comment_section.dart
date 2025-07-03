import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_thong_bao.dart';
import 'package:portal_ckc/api/model/comment.dart';
import 'package:portal_ckc/presentation/sections/notification_detail_comment_item.dart';
import 'package:portal_ckc/presentation/sections/textfield/comment_input_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationCommentSection extends StatefulWidget {
  final String lengthComment;
  final TextEditingController commentController;
  final List<BinhLuan> comments;
  final VoidCallback onPressed;
  final idThongBao;
  NotificationCommentSection({
    super.key,
    required this.lengthComment,
    required this.commentController,
    required this.comments,
    required this.onPressed,
    required this.idThongBao,
  });
  @override
  State<NotificationCommentSection> createState() => CommentSection();
}

class CommentSection extends State<NotificationCommentSection> {
  int? currentUserId;
  int? currentUserChucVu;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserChucVu = prefs.getInt('user_role');
      currentUserId = prefs.getInt('user_id');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserId == null) {
      return const Center(child: CircularProgressIndicator());
    }
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
            onPressed: widget.onPressed,
          ),

          NotificationCommentItem(
            idThongBao: widget.idThongBao,
            comments: widget.comments,
            currentUserId: currentUserId!,
            currentUserChucVu: currentUserChucVu ?? 0,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
