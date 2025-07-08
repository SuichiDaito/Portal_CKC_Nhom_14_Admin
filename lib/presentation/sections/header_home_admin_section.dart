import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/auth_bloc.dart';

enum UserAction { viewProfile, logout }

class HeaderHomeAdminSection extends StatefulWidget {
  final String? nameLogin;
  const HeaderHomeAdminSection({super.key, required this.nameLogin});

  @override
  State<HeaderHomeAdminSection> createState() => _HeaderHomeAdminSection();
}

class _HeaderHomeAdminSection extends State<HeaderHomeAdminSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Xin chào, ${widget.nameLogin}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Chào mừng đến với hệ thống quản lý',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          PopupMenuButton<UserAction>(
            onSelected: (action) {
              switch (action) {
                case UserAction.viewProfile:
                  context.go('/admin/information/user');
                  break;
                case UserAction.logout:
                  context.go('/login');
                  context.read<AuthBloc>().add(LoggedOut());
                  break;
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: UserAction.viewProfile,
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Xem thông tin'),
                ),
              ),
              const PopupMenuItem(
                value: UserAction.logout,
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Đăng xuất'),
                ),
              ),
            ],
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
