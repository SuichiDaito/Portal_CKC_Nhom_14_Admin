import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/admin/admin_bloc.dart';
import 'package:portal_ckc/bloc/admin/admin_state.dart';

class PageThongtinAdmin extends StatelessWidget {
  const PageThongtinAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thông tin giảng viên')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is AdminLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdminLoaded) {
              final user = state.user;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("🧑 Họ tên: ${user.id ?? 'Chưa có'}"),
                  Text("🆔 Mã ID: ${user.id}"),
                  Text("📧 Email: ${user.id ?? 'Chưa có'}"),
                ],
              );
            } else if (state is AdminError) {
              return Center(child: Text('❌ Lỗi: ${state.message}'));
            }
            return const Center(child: Text('Vui lòng đăng nhập'));
          },
        ),
      ),
    );
  }
}
