import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portal_ckc/presentation/sections/grid_app_home_admin.dart';
import 'package:portal_ckc/presentation/sections/header_home_admin_section.dart';
import 'package:portal_ckc/presentation/sections/notifications_home_admin.dart';
import 'package:portal_ckc/presentation/sections/user_profile_card_home_admin.dart';

class MainLayoutHomeAdminPage extends StatefulWidget {
  const MainLayoutHomeAdminPage({super.key});
  State<MainLayoutHomeAdminPage> createState() => _MainLayoutHomeAdminSection();
}

class _MainLayoutHomeAdminSection extends State<MainLayoutHomeAdminPage> {
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
            UserProfileCardHomeAdmin(
              nameUser: "Nguyễn Văn A",
              idStudent: '030621389',
              email: "040493737@gmail.com",
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
