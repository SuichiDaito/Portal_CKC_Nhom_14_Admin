import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thong_bao_bloc.dart';
import 'package:portal_ckc/bloc/event/thong_bao_event.dart';
import 'package:portal_ckc/bloc/state/thong_bao_state.dart';
import 'package:portal_ckc/presentation/sections/card/notification_detail_card.dart';
import 'package:portal_ckc/presentation/sections/notification_comment_section.dart';

class NotificationDetailPage extends StatefulWidget {
  final int id;

  const NotificationDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ThongBaoBloc>().add(FetchThongBaoDetail(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: BlocBuilder<ThongBaoBloc, ThongBaoState>(
        builder: (context, state) {
          if (state is TBLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TBDetailLoaded) {
            final tb = state.detail;
            final comments = tb.chiTiet;

            return SingleChildScrollView(
              child: Column(
                children: [
                  NotificationDetailCard(
                    typeNotificationSender: tb.tuAi ?? 'Hệ thống',
                    date: _formatDate(tb.ngayGui),
                    headerNotification: tb.tieuDe,
                    contentNotification: tb.noiDung,
                    lengthComment: tb.chiTiet.length.toString(),
                  ),

                  const SizedBox(height: 16),
                  NotificationCommentSection(
                    lengthComment: '${comments.length}',
                    commentController: _commentController,

                    onPressed: () {
                      // TODO: Gửi bình luận mới
                    },
                    comments: comments,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else if (state is TBFailure) {
            return Center(child: Text('❌ ${state.error}'));
          } else {
            return const Center(child: Text('Không có dữ liệu.'));
          }
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
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
        onPressed: () => context.pop(),
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
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {},
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
