import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/main.dart';
import 'package:portal_ckc/presentation/pages/DashboardAdminLayout.dart';
import 'package:portal_ckc/presentation/pages/demo.dart';
import 'package:portal_ckc/presentation/pages/page_demo.dart';
import 'package:portal_ckc/presentation/pages/page_doimatkhau_admin.dart';
import 'package:portal_ckc/presentation/pages/page_login_admin.dart';
import 'package:portal_ckc/presentation/pages/page_quanlyphong_admin.dart';
import 'package:portal_ckc/presentation/pages/page_solenlop_admin.dart';
import 'package:portal_ckc/presentation/pages/page_thongtin_admin.dart';

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
      GoRoute(path: '/demo', builder: (context, state) => Demo()),
      GoRoute(path: '/page/demo', builder: (context, state) => PageDemo()),
      GoRoute(
        path: '/login',
        builder: (context, state) => const PageLoginAdmin(),
      ),
      GoRoute(
        path: '/doimatkhau',
        builder: (context, state) => const PageDoimatkhauAdmin(),
      ),

      /// 🔁 ShellRoute dùng `shellNavigatorKey` static
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => DashboardAdminLayout(child: child),
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
        ],
      ),
    ],
  );
}
