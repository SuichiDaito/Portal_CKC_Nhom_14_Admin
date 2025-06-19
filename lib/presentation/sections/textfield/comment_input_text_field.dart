import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/comment.dart';

class NotificationDetailInputTextField extends StatefulWidget {
  final TextEditingController commentController;
  final Function onPressed;
  NotificationDetailInputTextField({
    super.key,
    required this.commentController,
    required this.onPressed,
  });
  State<NotificationDetailInputTextField> createState() => InputTextField();
}

class InputTextField extends State<NotificationDetailInputTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue[100],
            child: Icon(Icons.person, color: Colors.blue[700]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: widget.commentController,
                      decoration: const InputDecoration(
                        hintText: 'Viết bình luận...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      maxLines: null,
                    ),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    onPressed: widget.onPressed(),
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
