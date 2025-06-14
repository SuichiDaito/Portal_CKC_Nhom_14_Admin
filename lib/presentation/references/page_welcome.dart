import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: SingleChildScrollView(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(minHeight: screenHeight),
//           child: IntrinsicHeight(
//             child: Column(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 24),
//                     width: double.infinity,
//                     color: const Color(0xFF2196F3),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const SizedBox(height: 40),
//                         Image.asset(
//                           'assets/images/logo.png',
//                           width: 100,
//                           height: 100,
//                         ),
//                         const SizedBox(height: 20),
//                         const Text(
//                           'TRƯỜNG CAO ĐẲNG KỸ THUẬT CAO THẮNG',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           'Cổng thông tin nội bộ\nHệ thống quản lý đào tạo Trường Cao Thắng',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 14, color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 16,
//                     ),
//                     padding: const EdgeInsets.all(0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 8,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               GoRouter.of(context).go('/login');
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue, // Nền xanh
//                               foregroundColor: Colors.white, // Chữ trắng
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 24,
//                                 vertical: 16,
//                               ),
//                               textStyle: const TextStyle(fontSize: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(
//                                   8,
//                                 ), // Bo góc vừa phải
//                               ),
//                             ),
//                             child: const Text('Giảng viên đăng nhập'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 const Padding(
//                   padding: EdgeInsets.only(bottom: 16),
//                   child: Text(
//                     'Nhom_14_NgocCan_NgocTrang Copyright © 2025',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 12, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2196F3), // Xanh dương đậm
              Color(0xFF1976D2), // Xanh dương đậm hơn
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo và tên trường
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon trường học
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color(0xFF2196F3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                Icons.school,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                            SizedBox(height: 8),
                            // Text "CĐ"
                            Text(
                              'CĐ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2196F3),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30),

                      // Tên trường
                      Text(
                        'TRƯỜNG CAO ĐẲNG KỸ\nTHUẬT CAO THẮNG',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),

                      SizedBox(height: 20),

                      // Mô tả
                      Text(
                        'Cổng thông tin nội bộ\nHệ thống quản lý đào tạo\nTrường Cao Thắng',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Phần nút đăng nhập
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Nút Admin đăng nhập
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              _handleAdminLogin(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF2196F3),
                              foregroundColor: Colors.white,
                              elevation: 3,
                              shadowColor: Color(0xFF2196F3).withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.admin_panel_settings, size: 24),
                                SizedBox(width: 12),
                                Text(
                                  'Admin đăng nhập',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Nút Giảng viên đăng nhập
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              _handleTeacherLogin(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Color(0xFF2196F3),
                              elevation: 2,
                              shadowColor: Colors.grey.withOpacity(0.3),
                              side: BorderSide(
                                color: Color(0xFF2196F3),
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_outline, size: 24),
                                SizedBox(width: 12),
                                Text(
                                  'Giảng viên đăng nhập',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        // Thông tin bản quyền
                        Text(
                          'Trường Cao Đẳng Kỹ Thuật Cao Thắng\nCopyright © 2024',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAdminLogin(BuildContext context) {
    // Xử lý đăng nhập Admin
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildLoginDialog(
          context: context,
          title: 'Đăng nhập Admin',
          icon: Icons.admin_panel_settings,
          onLogin: (username, password) {
            // Xử lý logic đăng nhập admin
            Navigator.of(context).pop();
            _showLoginResult(context, 'Admin', username);
          },
        );
      },
    );
  }

  void _handleTeacherLogin(BuildContext context) {
    // Xử lý đăng nhập Giảng viên
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildLoginDialog(
          context: context,
          title: 'Đăng nhập Giảng viên',
          icon: Icons.person_outline,
          onLogin: (username, password) {
            // Xử lý logic đăng nhập giảng viên
            Navigator.of(context).pop();
            _showLoginResult(context, 'Giảng viên', username);
          },
        );
      },
    );
  }

  Widget _buildLoginDialog({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Function(String, String) onLogin,
  }) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    bool isPasswordVisible = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(icon, color: Color(0xFF2196F3)),
              SizedBox(width: 10),
              Text(title, style: TextStyle(fontSize: 18)),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Tên đăng nhập',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                final username = usernameController.text.trim();
                final password = passwordController.text.trim();

                if (username.isNotEmpty && password.isNotEmpty) {
                  onLogin(username, password);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Vui lòng nhập đầy đủ thông tin'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2196F3),
              ),
              child: Text('Đăng nhập', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showLoginResult(
    BuildContext context,
    String userType,
    String username,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đăng nhập thành công với tư cách $userType: $username'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    context.go('/login');

    // Ở đây bạn có thể điều hướng đến màn hình chính
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
  }
}
