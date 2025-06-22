import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:portal_ckc/presentation/pages/page_notification_detail_admin.dart';
import 'package:portal_ckc/presentation/sections/grid_app_home_admin.dart';
import 'package:portal_ckc/presentation/sections/header_home_admin_section.dart';
import 'package:portal_ckc/presentation/sections/notifications_home_admin.dart';
import 'package:portal_ckc/presentation/sections/user_profile_card_home_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLayoutHomeAdminPage extends StatefulWidget {
  const MainLayoutHomeAdminPage({super.key});
  State<MainLayoutHomeAdminPage> createState() => _MainLayoutHomeAdminPage();
}

class _MainLayoutHomeAdminPage extends State<MainLayoutHomeAdminPage> {
  @override
  void initState() {
    super.initState();
    _loadAdminInfo();
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
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            HeaderHomeAdminSection(nameLogin: "Admin"),
            SizedBox(height: 20),

            // User Profile Card
            BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state is AdminLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AdminSuccess) {
                  final user = state.user;
                  final hoSo = user.hoSo;
                  print('Hồ sơ của: ${hoSo}');
                  return UserProfileCardHomeAdmin(
                    nameUser: user.hoSo?.hoTen ?? 'Không có tên',
                    idTeacher: user.id.toString(),
                    email: user.hoSo?.email ?? 'Không có email',
                  );
                } else if (state is AdminError) {
                  return Text(
                    '❌ ${state.message}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return const SizedBox.shrink(); // tránh hiển thị thừa
                }
              },
            ),

            SizedBox(height: 20),

            // Function Grid
            GridAppHomeAdmin(),
            SizedBox(height: 20),

            // Latest Notifications Section
            NotificationsHomeAdmin(
              typeNotification: 'Thông báo khoa',
              contentNotification: 'Thông báo mới nhất',
              date: '24/06/2025',
            ),
          ],
        ),
      ),
    );
  }
}
