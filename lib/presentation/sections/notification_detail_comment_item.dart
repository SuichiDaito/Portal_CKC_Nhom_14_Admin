import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_thong_bao.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thong_bao_bloc.dart';
import 'package:portal_ckc/bloc/event/thong_bao_event.dart';

class NotificationCommentItem extends StatefulWidget {
  final List<BinhLuan> comments;
  final int? currentUserId;
  final String? currentUserType;
  final int? currentUserChucVu;
  final int idThongBao;
  const NotificationCommentItem({
    super.key,
    required this.comments,
    this.currentUserId,
    this.currentUserType,
    this.currentUserChucVu,
    required this.idThongBao,
  });

  @override
  State<NotificationCommentItem> createState() =>
      _NotificationCommentItemState();
}

class _NotificationCommentItemState extends State<NotificationCommentItem> {
  int? commentIdBeingReplied;
  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.comments
          .map((comment) => _buildComment(context, comment))
          .toList(),
    );
  }

  Widget _buildComment(
    BuildContext context,
    BinhLuan comment, {
    String? replyTo,
    bool isRootComment = true,
  }) {
    final name = comment.nguoiBinhLuan.hoSo.hoTen;
    final noiDung = replyTo != null
        ? '@$replyTo ${comment.noiDung}'
        : comment.noiDung;
    final time = _formatDate(comment.createdAt);

    final isOwner =
        widget.currentUserId != null &&
        widget.currentUserType != null &&
        comment.nguoiBinhLuan.id == widget.currentUserId &&
        comment.nguoiBinhLuan.type.contains(widget.currentUserType!);

    final isQuanLy = widget.currentUserChucVu == 1;

    return Container(
      margin: const EdgeInsets.fromLTRB(22, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.purple[100],
                child: Text(
                  _getInitials(name),
                  style: TextStyle(
                    color: Colors.purple[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
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
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        noiDung,
                        style: const TextStyle(
                          color: Color(0xFF4A5568),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Row(
                            children: [
                              if (isRootComment)
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      commentIdBeingReplied = comment.id;
                                    });
                                  },
                                  child: const Text(
                                    'Trả lời',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              if (isOwner || isQuanLy)
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text('Xác nhận'),
                                        content: const Text(
                                          'Bạn có chắc chắn muốn xóa bình luận này?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(
                                              ctx,
                                            ).pop(), // Đóng dialog
                                            child: const Text('Hủy'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(
                                                ctx,
                                              ).pop(); // Đóng dialog
                                              context.read<ThongBaoBloc>().add(
                                                DeleteCommentEvent(comment.id),
                                              );
                                              context.read<ThongBaoBloc>().add(
                                                FetchThongBaoDetail(
                                                  widget.idThongBao,
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              'Xóa',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          if (commentIdBeingReplied == comment.id)
            Padding(
              padding: const EdgeInsets.only(left: 50.0, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _replyController,
                    decoration: const InputDecoration(
                      hintText: ' Nhập nội dung trả lời...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final replyText = _replyController.text.trim();
                        if (replyText.isNotEmpty) {
                          print('📤 Gửi trả lời cho commentId: ${comment.id}');

                          context.read<ThongBaoBloc>().add(
                            CreateCommentEvent(
                              thongBaoId: widget.idThongBao,
                              noiDung: replyText,
                              idBinhLuanCha: comment.id,
                            ),
                          );

                          setState(() {
                            _replyController.clear();
                            commentIdBeingReplied = null;
                          });
                        }
                      },
                      child: const Text('Gửi'),
                    ),
                  ),
                ],
              ),
            ),

          if (comment.binhLuanCon.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 8),
              child: Column(
                children: comment.binhLuanCon
                    .map(
                      (reply) => _buildComment(
                        context,
                        reply,
                        replyTo: replyTo ?? name,
                        isRootComment: false,
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0];
    return parts.first[0] + parts.last[0];
  }
}
