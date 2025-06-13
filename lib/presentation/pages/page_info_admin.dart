import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';

class PageThongtinAdmin extends StatelessWidget {
  const PageThongtinAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 59, 114),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Thông tin Admin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 51, 72, 209),
                Color.fromARGB(255, 157, 44, 188),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.white.withOpacity(0.1), // vạch mờ bên dưới
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is AdminLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (state is AdminLoaded) {
              final user = state.user;
              final hoSo = user.hoSo;

              return Column(
                children: [
                  // Avatar & Name
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: const Color(0xFF4F46E5),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          hoSo?.hoTen ?? 'Chưa có tên',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Info Card
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 60, 98, 159),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _infoTile('Mã giảng viên', user.id.toString()),
                          _infoTile(
                            'Số điện thoại',
                            hoSo?.soDienThoai ?? 'Chưa có',
                          ),
                          _infoTile('Email', hoSo?.email ?? 'Chưa có'),
                          _infoTile('Địa chỉ', user.hoSo!.diaChi),
                          _infoTile('Khoa/Phòng', 'Phòng đào tạo'),
                          _infoTile('Chức vụ', user.roles[0].name ?? 'Chưa có'),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4ADE80),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.logout, color: Colors.black),
                          label: const Text(
                            'Đăng xuất',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            // TODO: xử lý đăng xuất
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6366F1),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.lock, color: Colors.white),
                          label: const Text(
                            'Đổi mật khẩu',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            context.push('/doimatkhau');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is AdminError) {
              return Center(
                child: Text(
                  '❌ Lỗi: ${state.message}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            return const Center(
              child: Text(
                'Vui lòng đăng nhập',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$title:',
              style: const TextStyle(
                color: Color.fromARGB(255, 221, 212, 212),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
