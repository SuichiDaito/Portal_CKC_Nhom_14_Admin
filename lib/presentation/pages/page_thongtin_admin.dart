import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/admin/admin_bloc.dart';
import 'package:portal_ckc/bloc/admin/admin_state.dart';

class PageThongtinAdmin extends StatelessWidget {
  const PageThongtinAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin chi tiết')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is AdminLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdminLoaded) {
              final user = state.user;
              final hoSo = user.hoSo;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey[400],
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: Text(
                              hoSo?.hoTen ?? 'Chưa có tên',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRowUnderline(
                            'Mã giảng viên',
                            user.id.toString(),
                          ),
                          _buildInfoRowUnderline(
                            'Số điện thoại',
                            hoSo?.soDienThoai ?? 'Chưa có',
                          ),
                          _buildInfoRowUnderline(
                            'Email',
                            hoSo?.email ?? 'Chưa có',
                          ),
                          _buildInfoRowUnderline(
                            'Ngành',
                            user.idBoMon.toString(),
                          ),
                          _buildInfoRowUnderline(
                            'Khoa',
                            user.idBoMon.toString(),
                          ),
                          _buildInfoRowUnderline(
                            'Chức vụ',
                            user.roles[0].name ?? 'Chưa có',
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.zero, // Không bo góc
                                    ),
                                  ),
                                  onPressed: () {
                                    // TODO: xử lý đăng xuất
                                  },
                                  child: const Text(
                                    'Đăng xuất',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.zero, // Không bo góc
                                    ),
                                  ),
                                  onPressed: () {
                                    context.push('/doimatkhau');
                                  },
                                  child: const Text(
                                    'Thay đổi mật khẩu',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('$title:')),
          Expanded(flex: 5, child: Text(value)),
        ],
      ),
    );
  }
}

Widget _buildInfoRowUnderline(String title, String value) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text('$title:')),
            Expanded(flex: 5, child: Text(value)),
          ],
        ),
      ),
      const Divider(thickness: 1),
    ],
  );
}
