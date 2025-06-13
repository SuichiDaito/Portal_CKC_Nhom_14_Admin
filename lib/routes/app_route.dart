import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/main.dart';
import 'package:portal_ckc/presentation/pages/dashboard_admin.dart';
import 'package:portal_ckc/presentation/pages/page_change_password_admin.dart';
import 'package:portal_ckc/presentation/pages/page_home_admin.dart';
import 'package:portal_ckc/presentation/pages/page_login_admin.dart';
import 'package:portal_ckc/presentation/pages/page_management_group_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_book_admin.dart';
import 'package:portal_ckc/presentation/pages/page_infomation_detail_admin.dart';
import 'package:portal_ckc/presentation/pages/page_notification_admin.dart';

class RouteName {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter route = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const PageLoginAdmin(),
      ),

      /// 🔁 ShellRoute dùng `shellNavigatorKey` static
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => DashboardAdminPage(child: child),
        routes: [
          GoRoute(
            path: '/admin/home',
            builder: (context, state) => const AdminHomePage(),
          ),
          GoRoute(
            path: '/admin/info',
            builder: (context, state) => const PageThongtinAdmin(),
          ),
          GoRoute(
            path: '/admin/solenlop',
            builder: (context, state) => const PageSolenlopAdmin(),
          ),
          GoRoute(
            path: '/admin/quanlyphong',
            builder: (context, state) => const PageQuanlyphongAdmin(),
          ),
          GoRoute(
            path: '/doimatkhau',
            builder: (context, state) => const PageDoimatkhauAdmin(),
          ),
          GoRoute(
            path: '/notifications',
            builder: (context, state) => const NotificationPage(),
          ),
        ],
      ),
    ],
  );
}
