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
    return WillPopScope(
      onWillPop: () async {
        context.pop(true);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: _buildAppBar(),
        body: BlocListener<ThongBaoBloc, ThongBaoState>(
          listener: (context, state) {
            if (state is TBFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('❌ ${state.error}')));
            }
          },
          child: BlocBuilder<ThongBaoBloc, ThongBaoState>(
            builder: (context, state) {
              if (state is TBLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TBDetailLoaded) {
                final tb = state.detail;
                final comments = tb.binhLuans;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      NotificationDetailCard(
                        typeNotificationSender: tb.tuAi ?? 'Hệ thống',
                        date: _formatDate(tb.ngayGui),
                        headerNotification: tb.tieuDe,
                        contentNotification: tb.noiDung,
                        lengthComment: tb.chiTiet.length.toString(),
                        files: tb.files
                            .map((f) => {'ten_file': f.tenFile, 'url': f.url})
                            .toList(),
                      ),

                      const SizedBox(height: 16),
                      NotificationCommentSection(
                        lengthComment: '${comments.length}',
                        commentController: _commentController,
                        idThongBao: tb.id,
                        onPressed: () {
                          final content = _commentController.text.trim();
                          if (content.isNotEmpty) {
                            context.read<ThongBaoBloc>().add(
                              CreateCommentEvent(
                                thongBaoId: widget.id,
                                noiDung: content,
                              ),
                            );

                            _commentController.clear();
                          }
                        },

                        comments: comments,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              } else if (state is TBFailure) {
                return Center(
                  child: Text(
                    'Không thể truy cập, chức năng này vui lòng thử lại sau',
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    'Không thể truy cập chức năng này, vui lòng thử lại sau.',
                  ),
                );
              }
            },
          ),
        ),
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
        onPressed: () => context.pop(true),
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
