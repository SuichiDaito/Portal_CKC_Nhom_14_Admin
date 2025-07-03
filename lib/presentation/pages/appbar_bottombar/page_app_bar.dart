import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarNavigationHomePage extends StatefulWidget {
  final Widget child;
  const AppBarNavigationHomePage({super.key, required this.child});

  @override
  State<AppBarNavigationHomePage> createState() => _AppBarNavigationHomePage();
}

class _AppBarNavigationHomePage extends State<AppBarNavigationHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<String> getRoleName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name_role') ?? "Không có chức vụ";
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name_fullname') ?? "Chưa đăng nhập";
  }

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
            child: FutureBuilder(
              future: Future.wait([getUserName(), getRoleName()]),
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(color: Colors.white);
                }
                final hoTen = snapshot.data?[0] ?? 'Chưa đăng nhập';
                final vaiTro = snapshot.data?[1] ?? 'Không có chức vụ';
                return _buildUserInfo(hoTen, vaiTro);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(String hoTen, String vaiTro) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.3),
          radius: 20,
          child: const Icon(Icons.person, color: Colors.white, size: 24),
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
  }
}
