import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/main.dart';
import 'package:portal_ckc/presentation/pages/dashboard_admin.dart';
import 'package:portal_ckc/presentation/pages/page_change_password_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_list_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_management_admin.dart';
import 'package:portal_ckc/presentation/pages/page_login_admin.dart';
import 'package:portal_ckc/presentation/pages/page_management_group_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_book_admin.dart';
import 'package:portal_ckc/presentation/pages/page_info_admin.dart';
import 'package:portal_ckc/presentation/pages/page_student_conduct_score.dart';
import 'package:portal_ckc/presentation/pages/page_teaching_schedule_admin.dart';

class RouteName {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter route = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => MyHomePage(title: "My Home Page Screen"),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const PageLoginAdmin(),
      ),
      GoRoute(
        path: '/doimatkhau',
        builder: (context, state) => const PageDoimatkhauAdmin(),
      ),
      GoRoute(
        path: '/admin/diemrenluyen',
        builder: (context, state) => PageStudentConductScore(),
      ),

      /// 🔁 ShellRoute dùng `shellNavigatorKey` static
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => DashboardAdminPage(child: child),
        routes: [
          GoRoute(
            path: '/admin/home',
            builder: (context, state) => const PageHomeAdminEmpty(),
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
            path: '/admin/danhsachlop',
            builder: (context, state) => PageClassListAdmin(),
          ),
          GoRoute(
            path: '/admin/lichday',
            builder: (context, state) => PageTeachingScheduleAdmin(),
          ),
          GoRoute(
            path: '/admin/lophocphan',
            builder: (context, state) => PageClassManagementAdmin(),
          ),
        ],
      ),
    ],
  );
}
