import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _UserAction { viewProfile, logout }

class AppBarNavigationHomePage extends StatefulWidget {
  final Widget child;
  const AppBarNavigationHomePage({super.key, required this.child});

  @override
  State<AppBarNavigationHomePage> createState() => _AppBarNavigationHomePage();
}

class _AppBarNavigationHomePage extends State<AppBarNavigationHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<String> getRoleName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name_role') ?? "Không có chức vụ";
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name_fullname') ?? "Chưa đăng nhập";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBarHomePage(),
      body: widget.child,
    );
  }

  PreferredSizeWidget _buildAppBarHomePage() {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      toolbarHeight: 75,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.blue.shade600],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: Future.wait([getUserName(), getRoleName()]),
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(color: Colors.white);
                }
                final hoTen = snapshot.data?[0] ?? 'Chưa đăng nhập';
                final vaiTro = snapshot.data?[1] ?? 'Không có chức vụ';
                return _buildUserInfo(hoTen, vaiTro);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(String hoTen, String vaiTro) {
    return PopupMenuButton<_UserAction>(
      onSelected: (action) {
        switch (action) {
          case _UserAction.viewProfile:
            Navigator.pushNamed(context, '/user/detail');
            break;
          case _UserAction.logout:
            context.go('/login');
            context.read<AuthBloc>().add(LoggedOut());
            break;
        }
      },
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      itemBuilder: (_) => [
        const PopupMenuItem(
          value: _UserAction.viewProfile,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Xem thông tin'),
          ),
        ),
        const PopupMenuItem(
          value: _UserAction.logout,
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Đăng xuất'),
          ),
        ),
      ],
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.3),
            radius: 20,
            child: const Icon(Icons.person, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hoTen,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                vaiTro,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Enum để phân biệt action
}
