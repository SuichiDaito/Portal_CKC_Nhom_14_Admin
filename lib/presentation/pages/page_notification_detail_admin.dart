import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/comment.dart';
import 'package:portal_ckc/presentation/sections/card/notification_detail_card.dart';
import 'package:portal_ckc/presentation/sections/notification_comment_section.dart';

class NotificationDetailPage extends StatefulWidget {
  final String title;
  final String content;
  final String date;
  const NotificationDetailPage({
    Key? key,
    required this.title,
    required this.content,
    required this.date,
  }) : super(key: key);

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  final Comment _comments = Comment(
    userName: 'Minh Anh',
    content: 'Chào bạn, hôm nay bạn thế nào?',
    timestamp: '15/06/2025 09:30',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NotificationDetailCard(),
            const SizedBox(height: 16),
            NotificationCommentSection(
              lengthComment: '2',
              commentController: _commentController,
              comment: _comments,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.go('/notifications'),
      ),
      title: const Text(
        'Chi Tiết Thông Báo',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.bookmark_border, color: Colors.white),
          onPressed: () {
            // Lưu thông báo
          },
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {
            // Chia sẻ thông báo
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
