import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';

class AppBarNavigationHomePage extends StatefulWidget {
  final Widget child;
  const AppBarNavigationHomePage({super.key, required this.child});

  @override
  State<AppBarNavigationHomePage> createState() => _AppBarNavigationHomePage();
}

class _AppBarNavigationHomePage extends State<AppBarNavigationHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
            child: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                String hoTen = 'Chưa đăng nhập';
                String vaiTro = '';

                if (state is AdminLoaded || state is AdminSuccess) {
                  final user = (state is AdminLoaded)
                      ? state.user
                      : (state as AdminSuccess).user;
                  print(user);
                  hoTen = user.hoSo?.hoTen ?? 'Không rõ tên';
                  vaiTro = user.roles.isNotEmpty
                      ? user.roles.first.name ?? 'Không rõ vai trò'
                      : 'Không rõ vai trò';
                }

                return Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      radius: 20,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
