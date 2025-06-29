import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/admin_thong_bao.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thong_bao_bloc.dart';
import 'package:portal_ckc/bloc/event/thong_bao_event.dart';
import 'package:portal_ckc/bloc/state/thong_bao_state.dart';
import 'package:portal_ckc/presentation/pages/page_notification_detail_admin.dart';
import 'package:portal_ckc/presentation/sections/notifications_home_admin.dart';

// Main Notifications Page
class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String selectedFilter = 'Tất cả';
  List<ThongBao> _filterBySelected(List<ThongBao> list) {
    switch (selectedFilter) {
      case 'Khoa':
        return list.where((e) => e.tuAi.toLowerCase() == 'khoa').toList();
      case 'Lớp':
        return list.where((e) => e.tuAi.toLowerCase() == 'lop').toList();
      case 'Giảng viên':
        return list.where((e) => e.tuAi.toLowerCase() == 'giangvien').toList();
      default:
        return list;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  void initState() {
    super.initState();
    context.read<ThongBaoBloc>().add(FetchThongBaoList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThongBaoBloc, ThongBaoState>(
      builder: (context, state) {
        if (state is TBLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is TBFailure) {
          return Center(child: Text('Lỗi: ${state.error}'));
        }

        if (state is TBListLoaded) {
          final khoaNoti = state.list.where((e) => e.tuAi == 'khoa').toList();
          final lopNoti = state.list.where((e) => e.tuAi == 'lop').toList();
          final gvNoti = state.list
              .where((e) => e.tuAi == 'giangvien')
              .toList();

          return Column(
            children: [
              _buildFilterTabs(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (selectedFilter == 'Tất cả' ||
                          selectedFilter == 'Khoa')
                        NotificationsHomeAdmin(
                          typeNotification: 'Thông báo khoa',
                          notifications: khoaNoti,
                        ),
                      if (selectedFilter == 'Tất cả' || selectedFilter == 'Lớp')
                        NotificationsHomeAdmin(
                          typeNotification: 'Thông báo lớp',
                          notifications: lopNoti,
                        ),
                      if (selectedFilter == 'Tất cả' ||
                          selectedFilter == 'Giảng viên')
                        NotificationsHomeAdmin(
                          typeNotification: 'Thông báo giảng viên',
                          notifications: gvNoti,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        // Mặc định
        return Center(child: Text('Không có dữ liệu'));
      },
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['Tất cả', 'Khoa', 'Lớp', 'Giảng viên'];
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue[600] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.blue[600]! : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
