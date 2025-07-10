import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:portal_ckc/gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _teacherEmailController = TextEditingController();
  final _teacherPasswordController = TextEditingController();
  final _adminAccountController = TextEditingController();
  final _adminPasswordController = TextEditingController();
  bool _isLoggingIn = false;

  bool _isTeacherPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _teacherEmailController.dispose();
    _teacherPasswordController.dispose();
    _adminAccountController.dispose();
    _adminPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildFormLogin();
  }

  Widget _buildFormLogin() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2196F3), Color(0xFF1976D2), Color(0xFF0D47A1)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),

              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildTabBar(),

                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildTeacherLoginForm(),
                            _buildResetPasswordForm(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Logo
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.logoPng.image(
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),

          SizedBox(height: 15),
          // Tên trường
          Text(
            'TRƯỜNG CAO ĐẲNG KỸ THUẬT CAO THẮNG',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 10),

          // Mô tả
          Text(
            'Cổng thông tin nội bộ\nHệ thống quản lý đào tạo Trường Cao Thắng',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFF1976D2),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 20),
                SizedBox(width: 8),
                Text('Giảng Viên'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.admin_panel_settings, size: 20),
                SizedBox(width: 8),
                Text(''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherLoginForm() {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: BlocConsumer<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is AdminLoading) {
              setState(() {
                _isLoggingIn = true;
              });
            } else if (state is AdminLoaded) {
              setState(() {
                _isLoggingIn = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('✅ Đăng nhập thành công'),
                  backgroundColor: Colors.green,
                ),
              );

              // Chuyển trang
              context.go('/home/admin', extra: state.user.id);
            } else if (state is AdminError) {
              setState(() {
                _isLoggingIn = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.error, color: Colors.white),
                      SizedBox(width: 10),
                      Text('Đăng nhập không thành công'),
                    ],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },

          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Đăng Nhập Giảng Viên',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 30),

                _buildTextField(
                  controller: _teacherEmailController,
                  label: 'Email giảng viên',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 20),

                _buildPasswordField(
                  controller: _teacherPasswordController,
                  label: 'Mật khẩu',
                  isVisible: _isTeacherPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isTeacherPasswordVisible = !_isTeacherPasswordVisible;
                    });
                  },
                ),

                SizedBox(height: 30),

                _buildLoginButton('Đăng Nhập Giảng Viên', () {
                  if (state is! AdminLoading) {
                    // request information (account, password) api
                    _handleTeacherLogin();
                    Center(child: CircularProgressIndicator());
                  }
                }),

                SizedBox(height: 15),

                TextButton(
                  onPressed: () {
                    _tabController.animateTo(
                      1,
                    ); // Chuyển sang tab Admin (tab thứ 2)
                  },
                  child: Text(
                    'Quên mật khẩu?',
                    style: TextStyle(color: Color(0xFF1976D2), fontSize: 16),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildResetPasswordForm() {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: BlocConsumer<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '✅ Mật khẩu mới đã được gửi tới: ${state.email}',
                    style: TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              _tabController.animateTo(0); // Chuyển lại tab đăng nhập
            } else if (state is ForgotPasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('❌ ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Quên mật khẩu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                _buildTextField(
                  controller: _adminAccountController,
                  label: 'Email',
                  icon: Icons.admin_panel_settings,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                _buildLoginButton(
                  state is ForgotPasswordLoading
                      ? 'Đang gửi...'
                      : 'Gửi yêu cầu',
                  () => _handleForgotPassword(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleForgotPassword(BuildContext context) {
    String email = _adminAccountController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập email'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<AdminBloc>().add(ForgotPasswordRequested(email));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF1976D2)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
          labelStyle: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(Icons.lock, color: Color(0xFF1976D2)),
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey[600],
            ),
            onPressed: onToggleVisibility,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
          labelStyle: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }

  Widget _buildLoginButton(String text, VoidCallback onPressed) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1976D2).withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoggingIn ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: _isLoggingIn
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  void _handleTeacherLogin() {
    String account = _teacherEmailController.text.trim();
    String password = _teacherPasswordController.text.trim();

    if (account.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Vui lòng nhập đầy đủ thông tin',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red[600],
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(16),
        ),
      );
      return;
    }

    context.read<AdminBloc>().add(
      AdminLoginEvent(taiKhoan: account, password: password),
    );
  }

  // void _handleAdminLogin() {
  //   String account = _adminAccountController.text.trim();
  //   String password = _adminPasswordController.text.trim();

  //   if (account.isEmpty || password.isEmpty) {
  //     // _showToast('Vui lòng nhập đầy đủ thông tin');
  //     return;
  //   }

  //   context.read<AdminBloc>().add(
  //     AdminLoginEvent(taiKhoan: account, password: password),
  //   );
  //   // TODO: Implement admin login logic
  //   _showToast('Đăng nhập thành công!', isError: false);
  // }

  // void _showToast(String message, {bool isError = true}) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Row(
  //         children: [
  //           Icon(
  //             isError ? Icons.error : Icons.check_circle,
  //             color: Colors.white,
  //             size: 20,
  //           ),
  //           SizedBox(width: 12),
  //           Expanded(
  //             child: Text(
  //               message,
  //               style: TextStyle(color: Colors.white, fontSize: 16),
  //             ),
  //           ),
  //         ],
  //       ),
  //       backgroundColor: isError ? Colors.red[600] : Colors.green[600],
  //       duration: Duration(seconds: 3),
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //       margin: EdgeInsets.all(16),
  //     ),
  //   );
  // }
}
