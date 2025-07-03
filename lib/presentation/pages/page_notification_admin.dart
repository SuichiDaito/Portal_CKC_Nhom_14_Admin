import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thong_bao_bloc.dart';
import 'package:portal_ckc/bloc/event/thong_bao_event.dart';
import 'package:portal_ckc/bloc/state/thong_bao_state.dart';
import 'package:portal_ckc/presentation/sections/notifications_home_admin.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String selectedFilter = 'Tất cả';

  @override
  void initState() {
    super.initState();
    context.read<ThongBaoBloc>().add(FetchThongBaoList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ThongBaoBloc, ThongBaoState>(
        builder: (context, state) {
          if (state is TBLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is TBFailure) {
            return Center(child: Text('Lỗi: ${state.error}'));
          }

          if (state is TBListLoaded) {
            final khoaNoti = state.list
                .where((e) => e.tuAi == 'khoa' && e.trangThai == 1)
                .toList();
            final ctctNoti = state.list
                .where((e) => e.tuAi == 'phong_ctct' && e.trangThai == 1)
                .toList();
            // final gvNoti = state.list
            //     .where((e) => e.tuAi == 'giangvien' && e.trangThai == 1)
            //     .toList();

            return Column(
              children: [
                _buildFilterTabs(),
                Expanded(
                  child: SingleChildScrollView(
                    key: ValueKey(state.list.length),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (selectedFilter == 'Tất cả' ||
                            selectedFilter == 'Khoa')
                          NotificationsHomeAdmin(
                            typeNotification: 'Thông báo khoa',
                            key: ValueKey('khoa-${state.list.length}'),
                            notifications: khoaNoti,
                            onReload: () {
                              setState(() {}); // 👈 ép cập nhật lại UI
                              context.read<ThongBaoBloc>().add(
                                FetchThongBaoList(),
                              );
                            },
                          ),

                        if (selectedFilter == 'Tất cả' ||
                            selectedFilter == 'Phòng Công Tác Chính Trị')
                          NotificationsHomeAdmin(
                            typeNotification: 'phong_ctct',
                            notifications: ctctNoti,
                            onReload: () {
                              setState(() {});
                              context.read<ThongBaoBloc>().add(
                                FetchThongBaoList(),
                              );
                            },
                          ),
                        // if (selectedFilter == 'Tất cả' ||
                        //     selectedFilter == 'gvcn')
                        //   NotificationsHomeAdmin(
                        //     typeNotification: 'Thông báo giảng viên',
                        //     notifications: gvNoti,
                        //     onReload: () {
                        //       setState(() {});
                        //       context.read<ThongBaoBloc>().add(
                        //         FetchThongBaoList(),
                        //       );
                        //     },
                        //   ),
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
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'archiveBtn',
            icon: const Icon(Icons.archive),
            label: const Text('Kho'),
            backgroundColor: Colors.grey,
            onPressed: () {
              // TODO: điều hướng tới screen "Kho thông báo"
              context.push('/notifications/user');
            },
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'createBtn',
            icon: const Icon(Icons.add),
            label: const Text('Tạo'),
            onPressed: () async {
              final result = await context.push('/notifications/create');

              if (result == true) {
                context.read<ThongBaoBloc>().add(FetchThongBaoList());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['Tất cả', 'Khoa', 'Phòng Công Tác Chính Trị'];
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
