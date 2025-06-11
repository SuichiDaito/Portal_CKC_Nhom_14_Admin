import 'package:go_router/go_router.dart';
import 'package:portal_ckc/main.dart';
import 'package:portal_ckc/presentation/pages/demo.dart';
import 'package:portal_ckc/presentation/pages/page_demo.dart';
import 'package:portal_ckc/presentation/pages/page_login_admin.dart';
import 'package:portal_ckc/presentation/pages/page_thongtin_admin.dart';

class RouteName {
  static final route = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => MyHomePage(title: "My Home Page Screen"),
      ),

      //shell route chỉ sử dụng cho các màn hình có sự thay đổi nổi dung bên trong,
      // hoặc đơn giản hơn là làm sao để có thể giữ lấy bottomAppBar bên dưới.
      // chỉ đơn giản là: layout cha không thay đổi mà chỉ layout con thay đổi.
      // giữ shellRoute với tất cả các màn hình có bottomAppBar bên dưới, còn không có thì khai báo bên ngoài ShellRoute.
      // ShellRoute(
      //   builder: (context, state, child) {
      //     return MyHomePage(title: "Demo Go Route");
      //   },
      //   routes: [
      //     // GoRoute(
      //     //   path: '/',
      //     //   builder: (context, state) => MyHomePage(title: ""),
      //     // ),
      //   ],
      // ),
      GoRoute(path: '/demo', builder: (context, state) => Demo()),
      GoRoute(path: '/page/demo', builder: (context, state) => PageDemo()),
      GoRoute(
        path: '/login',
        builder: (context, state) => const PageLoginAdmin(),
      ),
      GoRoute(
        path: '/admin/info',
        builder: (context, state) => const PageThongtinAdmin(),
      ),
    ],
  );
}
