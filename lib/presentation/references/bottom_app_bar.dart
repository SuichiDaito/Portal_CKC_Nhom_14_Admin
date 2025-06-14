import 'package:flutter/material.dart';

class BottomAppBarScreen extends StatefulWidget {
  const BottomAppBarScreen({super.key});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<BottomAppBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    NotificationScreen(),
    ProfileScreen(),
    AppsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xFF2196F3), // Màu xanh dương như hình
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            selectedFontSize: 12,
            unselectedFontSize: 11,
            elevation: 0,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _currentIndex == 0
                        ? Colors.white.withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.home_rounded, size: 24),
                ),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _currentIndex == 1
                            ? Colors.white.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.notifications_rounded, size: 24),
                    ),
                    // Badge thông báo
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                label: 'Thông báo',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _currentIndex == 2
                        ? Colors.white.withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.person_rounded, size: 24),
                ),
                label: 'Tài khoản',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _currentIndex == 3
                        ? Colors.white.withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.dashboard, size: 24),
                ),
                label: 'Ứng dụng',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Màn hình Trang chủ
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang chủ'),
        backgroundColor: Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_rounded, size: 80, color: Color(0xFF2196F3)),
            SizedBox(height: 20),
            Text(
              'Trang chủ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2196F3),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Chào mừng bạn đến với ứng dụng',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

// Màn hình Thông báo
class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
        backgroundColor: Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFF2196F3),
                child: Icon(Icons.notifications, color: Colors.white),
              ),
              title: Text('Thông báo ${index + 1}'),
              subtitle: Text('Nội dung thông báo số ${index + 1}'),
              trailing: Text(
                '${index + 1}h',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Màn hình Tài khoản
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài khoản'),
        backgroundColor: Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF2196F3),
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Nguyễn Văn B',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Trưởng khoa CNTT',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 30),
            _buildProfileOption(
              icon: Icons.edit,
              title: 'Chỉnh sửa thông tin',
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.lock,
              title: 'Đổi mật khẩu',
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.settings,
              title: 'Cài đặt',
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.logout,
              title: 'Đăng xuất',
              onTap: () {},
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : Color(0xFF2196F3)),
        title: Text(
          title,
          style: TextStyle(color: isLogout ? Colors.red : Colors.black87),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

// Màn hình Ứng dụng
class AppsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apps = [
      {'name': 'Sổ lên lớp', 'icon': Icons.class_, 'color': Colors.blue},
      {
        'name': 'Lịch tuần',
        'icon': Icons.calendar_today,
        'color': Colors.orange,
      },
      {'name': 'Quản lý SV', 'icon': Icons.school, 'color': Colors.green},
      {'name': 'Phòng học', 'icon': Icons.meeting_room, 'color': Colors.purple},
      {'name': 'Lịch thi', 'icon': Icons.quiz, 'color': Colors.red},
      {'name': 'Giấy xác nhận', 'icon': Icons.verified, 'color': Colors.teal},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Ứng dụng'),
        backgroundColor: Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: apps.length,
          itemBuilder: (context, index) {
            final app = apps[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Mở ${app['name']}'),
                      backgroundColor: app['color'] as Color,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: (app['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          app['icon'] as IconData,
                          size: 32,
                          color: app['color'] as Color,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        app['name'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
