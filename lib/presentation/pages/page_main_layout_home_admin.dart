import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/admin_thong_bao.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thong_bao_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/event/thong_bao_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:portal_ckc/bloc/state/thong_bao_state.dart';
import 'package:portal_ckc/presentation/sections/grid_app_home_admin.dart';
import 'package:portal_ckc/presentation/sections/header_home_admin_section.dart';
import 'package:portal_ckc/presentation/sections/notifications_home_admin.dart';
import 'package:portal_ckc/presentation/sections/user_profile_card_home_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLayoutHomeAdminPage extends StatefulWidget {
  const MainLayoutHomeAdminPage({super.key});
  @override
  State<MainLayoutHomeAdminPage> createState() =>
      _MainLayoutHomeAdminPageState();
}

class _MainLayoutHomeAdminPageState extends State<MainLayoutHomeAdminPage> {
  String selectedFilter = 'Tất cả';

  List<ThongBao> khoaNoti = [];
  List<ThongBao> lopNoti = [];
  List<ThongBao> gvNoti = [];

  @override
  void initState() {
    super.initState();
    _loadAdminInfo();
    context.read<ThongBaoBloc>().add(FetchThongBaoList());
  }

  Future<void> _loadAdminInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId != null) {
      context.read<AdminBloc>().add(FetchAdminDetail(userId));
    } else {
      debugPrint('❌ Không tìm thấy user_id trong SharedPreferences');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderHomeAdminSection(nameLogin: "Admin"),
            const SizedBox(height: 20),

            BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state is AdminLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AdminSuccess) {
                  final user = state.user;
                  final hoSo = user.hoSo;
                  return UserProfileCardHomeAdmin(
                    nameUser: hoSo?.hoTen ?? 'Không có tên',
                    idTeacher: user.id.toString(),
                    email: hoSo?.email ?? 'Không có email',
                  );
                } else if (state is AdminError) {
                  return Text(
                    '❌ ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),

            // const SizedBox(height: 20),
            // GridAppHomeAdmin(),
            const SizedBox(height: 20),

            // Bộ lọc thông báo
            _buildFilterTabs(),

            const SizedBox(height: 10),

            BlocBuilder<ThongBaoBloc, ThongBaoState>(
              builder: (context, state) {
                if (state is TBLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TBListLoaded) {
                  final now = DateTime.now();
                  final recentList = state.list
                      .where(
                        (e) => e.ngayGui.isAfter(
                          now.subtract(const Duration(days: 30)),
                        ),
                      )
                      .toList();

                  final khoaNoti = state.list
                      .where((e) => e.tuAi == 'khoa' && e.trangThai == 1)
                      .toList();
                  final lopNoti = state.list
                      .where((e) => e.tuAi == 'lop' && e.trangThai == 1)
                      .toList();
                  final gvNoti = state.list
                      .where((e) => e.tuAi == 'giangvien' && e.trangThai == 1)
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (selectedFilter == 'Tất cả' ||
                          selectedFilter == 'Khoa')
                        khoaNoti.isNotEmpty
                            ? NotificationsHomeAdmin(
                                typeNotification: 'Thông báo khoa',
                                notifications: khoaNoti,
                                onReload: () {
                                  setState(() {}); // 👈 ép cập nhật lại UI
                                  context.read<ThongBaoBloc>().add(
                                    FetchThongBaoList(),
                                  );
                                },
                              )
                            : const Text('📭 Chưa có thông báo khoa'),

                      if (selectedFilter == 'Tất cả' || selectedFilter == 'Lớp')
                        lopNoti.isNotEmpty
                            ? NotificationsHomeAdmin(
                                typeNotification: 'Thông báo lớp',
                                notifications: lopNoti,
                                onReload: () {
                                  setState(() {}); // 👈 ép cập nhật lại UI
                                  context.read<ThongBaoBloc>().add(
                                    FetchThongBaoList(),
                                  );
                                },
                              )
                            : const Text('Chưa có thông báo lớp'),

                      if (selectedFilter == 'Tất cả' ||
                          selectedFilter == 'Giảng viên')
                        gvNoti.isNotEmpty
                            ? NotificationsHomeAdmin(
                                typeNotification: 'Thông báo giảng viên',
                                notifications: gvNoti,
                                onReload: () {
                                  setState(() {}); // 👈 ép cập nhật lại UI
                                  context.read<ThongBaoBloc>().add(
                                    FetchThongBaoList(),
                                  );
                                },
                              )
                            : const Text('Chưa có thông báo giảng viên'),
                    ],
                  );
                } else if (state is TBFailure) {
                  return Text(
                    '❌ ${state.error}',
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    final filters = [
      'Tất cả',
      'Khoa',
      'Lớp',
      'Giảng viên',
    ]; // bạn có thể thêm nhiều mục
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
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
