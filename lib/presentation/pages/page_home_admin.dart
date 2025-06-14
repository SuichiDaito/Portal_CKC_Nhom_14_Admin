import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminHomePage extends StatefulWidget {
  final Widget child;
  AdminHomePage({super.key, required this.child});
  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0; // Home tab selected by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      body: widget.child,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  void _handleNavigation(int index) {
    final routes = [
      '/home/admin',
      '/apps',
      '/notifications',
      '/admin/infomation/user',
    ];
    if (index < routes.length) {
      context.go(routes[index]);
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue[600],
      unselectedItemColor: Colors.grey[500],
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          _handleNavigation(index);
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Ứng dụng'),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Thông báo',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
      ],
    );
  }
}
