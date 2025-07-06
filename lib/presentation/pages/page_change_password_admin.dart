import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:portal_ckc/constant/string.dart';

class PageDoimatkhauAdmin extends StatefulWidget {
  const PageDoimatkhauAdmin({super.key});

  @override
  State<PageDoimatkhauAdmin> createState() => _PageDoimatkhauAdminState();
}

class _PageDoimatkhauAdminState extends State<PageDoimatkhauAdmin> {
  final _formKey = GlobalKey<FormState>();
  final oldPassCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  bool isLoading = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Đổi mật khẩu thành công')),
        );
        Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    oldPassCtrl.dispose();
    newPassCtrl.dispose();
    confirmPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 239, 236, 236),
        padding: const EdgeInsets.all(16),
        child: Text(
          BottomBarString.copyRight,
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF666666), fontSize: 12),
        ),
      ),
      body: Stack(
        children: [
          // Nền xám + trắng bo góc
          Positioned.fill(
            child: Column(
              children: [
                Container(height: 140, color: const Color(0xFFEFEFEF)),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Nội dung
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),

                // Avatar giữa nền xám và trắng
                const Center(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                ),

                // Tên bên dưới avatar
                BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    if (state is AdminLoaded) {
                      final hoTen = state.user.hoSo?.hoTen ?? 'Chưa có tên';
                      return Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                        child: Text(
                          hoTen,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    return const SizedBox(height: 24);
                  },
                ),

                // Form đổi mật khẩu
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: oldPassCtrl,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Mật khẩu cũ',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập mật khẩu cũ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: newPassCtrl,
                            obscureText: false,
                            decoration: const InputDecoration(
                              labelText: 'Mật khẩu mới',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return 'Mật khẩu ít nhất 6 ký tự';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: confirmPassCtrl,
                            obscureText: false,
                            decoration: const InputDecoration(
                              labelText: 'Nhập lại mật khẩu mới',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value != newPassCtrl.text) {
                                return 'Mật khẩu không khớp';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
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
                                    context.pop('/doimatkhau');
                                  },
                                  child: const Text(
                                    'Quay lại',
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
                                    context.pop('/doimatkhau');
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
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                top: 40,
                left: 16,
                right: 16,
                bottom: 12,
              ),
              color: const Color(0xFFEFEFEF),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Đổi mật khẩu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
