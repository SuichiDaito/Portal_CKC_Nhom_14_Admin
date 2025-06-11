import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/admin/admin_bloc.dart';
import 'package:portal_ckc/bloc/admin/admin_event.dart';
import 'package:portal_ckc/bloc/admin/admin_state.dart';
import 'package:portal_ckc/presentation/pages/page_thongtin_admin.dart';

class PageLoginAdmin extends StatefulWidget {
  const PageLoginAdmin({super.key});

  @override
  State<PageLoginAdmin> createState() => _PageLoginAdminState();
}

class _PageLoginAdminState extends State<PageLoginAdmin> {
  final _formKey = GlobalKey<FormState>();
  final _taiKhoanController = TextEditingController();
  final _passwordController = TextEditingController();
  void adminLogin(BuildContext context) {
    final taiKhoan = _taiKhoanController.text.trim();
    final password = _passwordController.text.trim();

    if (taiKhoan.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')));
      return;
    }

    context.read<AdminBloc>().add(
      AdminLoginEvent(taiKhoan: taiKhoan, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: Form(
              key: _formKey,
              child: BlocConsumer<AdminBloc, AdminState>(
                listener: (context, state) {
                  if (state is AdminLoaded) {
                    print('✅ Đăng nhập thành công');
                    context.go('/admin/info');
                  } else if (state is AdminError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },

                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đăng nhập quản trị viên',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _taiKhoanController,
                        decoration: const InputDecoration(
                          labelText: 'Tài khoản',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Nhập tài khoản'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Mật khẩu',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Nhập mật khẩu'
                            : null,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state is AdminLoading
                              ? null
                              : () => adminLogin(context),
                          child: state is AdminLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                )
                              : const Text('Đăng nhập'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
