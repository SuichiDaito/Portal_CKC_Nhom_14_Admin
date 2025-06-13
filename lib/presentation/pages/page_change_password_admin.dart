import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';

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
      backgroundColor: const Color(0xFFF5F7FA),
      body: Stack(
        children: [
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(color: Color(0xFF6D28D9)),
            )
          else
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigo.shade600,
                          Colors.purple.shade600,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context); // Quay lại trang trước
                          },
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Đổi mật khẩu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(0xFF6D28D9),
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  BlocBuilder<AdminBloc, AdminState>(
                    builder: (context, state) {
                      if (state is AdminLoaded) {
                        final hoTen = state.user.hoSo?.hoTen ?? 'Chưa có tên';
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            hoTen,
                            style: const TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return const SizedBox(height: 24);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildPasswordField(
                            controller: oldPassCtrl,
                            label: 'Mật khẩu cũ',
                            validator: (value) => value == null || value.isEmpty
                                ? 'Vui lòng nhập mật khẩu cũ'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          _buildPasswordField(
                            controller: newPassCtrl,
                            label: 'Mật khẩu mới',
                            validator: (value) =>
                                value != null && value.length < 6
                                ? 'Mật khẩu ít nhất 6 ký tự'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          _buildPasswordField(
                            controller: confirmPassCtrl,
                            label: 'Nhập lại mật khẩu mới',
                            validator: (value) => value != newPassCtrl.text
                                ? 'Mật khẩu không khớp'
                                : null,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFCBD5E1),
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Quay lại'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF6D28D9),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: _submit,
                                  child: const Text(
                                    'Xác nhận',
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
                  const SizedBox(height: 40),
                  const Text(
                    'Nhóm: 14_NgọcCẩm_NgọcTrang\n© 2025',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF0F172A)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF6D28D9), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
      ),
      validator: validator,
    );
  }
}
